//
//  SearchViewController.m
//  trademe
//
//  Created by André Rodrigues on 03/05/2018.
//  Copyright © 2018 Verglas. All rights reserved.
//

#import "SearchViewController.h"
#import "ResultModel.h"
#import "SearchOperation.h"
#import "RequestBlock.h"
#import "SVProgressHUD.h"
#import "Provider.h"
#import "UIImageView+AFNetworking.h"
#import "DetailViewController.h"

#import "UIImage+Utils.h"

@implementation SearchResultCell

@end


@interface SearchViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *searchField;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UITableView *resultListView;


@property (strong, nonatomic) ResultModel *result;

@end

@implementation SearchViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    if ((_searchValue != nil) && (_searchValue.length > 0)) {
        _searchField.text = _searchValue;
        [self launchSearch];
        self.title = @"Results";
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickSearchButton:(id)sender {
    [self launchSearch];
}

- (void)launchSearch {
    SearchOperation *operation = [[SearchOperation alloc] init];
    
    if ([_searchField.text length] > 0) {
        operation.parameters =
        [NSMutableDictionary dictionaryWithDictionary:@{@"search_string": _searchField.text}];
    }
        
    RequestBlock *block = [RequestBlock initWithStartBlock:^{
            [SVProgressHUD show];
        } andSuccessBlock:^(NSURLSessionDataTask * _Nullable dataTask, id _Nullable result) {
            NSLog(@"successBlock");
            _result = ((ResultModel *)result);
            self.title = [NSString stringWithFormat:@"Results: %ld", (long)_result.TotalCount];
        } errorBlock:^(NSURLSessionDataTask * _Nullable dataTask, NSError * _Nonnull error) {
            NSLog(@"error: %@", error);
        } networkErrorBlock:^{
            NSLog(@"networkErrorBlock");
        } finishBlock:^{
            [_resultListView reloadData];
            [SVProgressHUD dismiss];
        }];
    
        [Provider requestOperation:operation withBlock:block];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ((_result != nil) && (_result.List != nil)) {
        return [_result.List count];
    }
    
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *myIdentifier = @"SearchResultCellIdentifier";
    SearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:myIdentifier forIndexPath:indexPath];
    
    cell.title.text = [[_result.List objectAtIndex:indexPath.row] Title];
    cell.region.text = [[_result.List objectAtIndex:indexPath.row] Region];
    cell.price.text = [NSString stringWithFormat:@"%ld$", (long)[[_result.List objectAtIndex:indexPath.row] BuyNowPrice]];
    
    if ([[_result.List objectAtIndex:indexPath.row] PictureHref]) {
        NSURL *pictureUrl = [NSURL URLWithString:[[_result.List objectAtIndex:indexPath.row] PictureHref]];
        [cell.picture setImageWithURL:pictureUrl placeholderImage:[UIImage imageFromColor:[UIColor lightGrayColor]]];
        cell.picture.backgroundColor = [UIColor clearColor];
    } else {
        cell.picture.image = nil;
        cell.picture.backgroundColor = [UIColor lightGrayColor];
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
    DetailViewController *detailVC = [DetailViewController new];
    NSString *detailIdString = [NSString stringWithFormat:@"%ld", (long)[[_result.List objectAtIndex:indexPath.row] ListingId]];
    [detailVC loadDetailItemWithId:detailIdString];
    
    [self.navigationController pushViewController:detailVC animated:YES];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                 style:UIBarButtonItemStylePlain
                                                                target:nil
                                                                action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    
    [_resultListView deselectRowAtIndexPath:indexPath animated:YES];
}

@end

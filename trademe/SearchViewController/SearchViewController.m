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
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ((_searchValue != nil) && (_searchValue.length > 0)) {
        _searchField.text = _searchValue;
        [self launchSearch];
    }
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
            NSLog(@"start");
            [SVProgressHUD show];
        } andSuccessBlock:^(NSURLSessionDataTask * _Nullable dataTask, id _Nullable result) {
            NSLog(@"andSuccessBlock");
            _result = ((ResultModel *)result);
        } errorBlock:^(NSURLSessionDataTask * _Nullable dataTask, NSError * _Nonnull error) {
            NSLog(@"errorBlock");
            NSLog(@"eroor: %@", error);
        } networkErrorBlock:^{
            NSLog(@"networkErrorBlock");
        } finishBlock:^{
            NSLog(@"finishBlock");
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
    cell.price.text = [NSString stringWithFormat:@"%ld", (long)[[_result.List objectAtIndex:indexPath.row] BuyNowPrice]];
    
    if ([[_result.List objectAtIndex:indexPath.row] PictureHref]) {
        NSURL *pictureUrl = [NSURL URLWithString:[[_result.List objectAtIndex:indexPath.row] PictureHref]];
        [cell.picture setImageWithURL:pictureUrl];
        cell.picture.backgroundColor = [UIColor clearColor];
    } else {
        cell.picture.image = nil;
        cell.picture.backgroundColor = [UIColor lightGrayColor];
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    if ([[_categories objectAtIndex:indexPath.row] Subcategories] != nil && [[[_categories objectAtIndex:indexPath.row] Subcategories] count] > 0) {
//        CategoryViewController *categoryVC = [self.storyboard instantiateViewControllerWithIdentifier:@"categoryStoryboardID"];
//        categoryVC.categories = [[_categories objectAtIndex:indexPath.row] Subcategories];
//        categoryVC.title = [[_categories objectAtIndex:indexPath.row] Name];
//
//        [self.navigationController pushViewController:categoryVC animated:YES];
//    }
//
    [_resultListView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
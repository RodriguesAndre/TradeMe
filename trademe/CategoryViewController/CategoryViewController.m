//
//  ViewController.m
//  trademe
//
//  Created by André Rodrigues on 30/04/2018.
//  Copyright © 2018 Verglas. All rights reserved.
//

#import "CategoryViewController.h"

#import "NetworkManager.h"
#import "RequestBlock.h"
#import "CategoryModel.h"
#import "CategoryOperation.h"
#import "SearchViewController.h"

#import "Provider.h"
#import "SVProgressHUD.h"
#import "UIImageView+AFNetworking.h"


@interface CategoryViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *searchField;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (weak, nonatomic) IBOutlet UITableView *resultListView;

@property (strong, nonatomic) NSArray <CategoryModel *> *categories;

@end

@implementation CategoryViewController

- (instancetype)initWithCategories:(NSArray <CategoryModel *> *)categories {
    self = [super init];
    if (self) {
        self.categories = categories;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    if (_categories == nil) {
        self.title = @"Trade me";// localizeStrings
        _categories = @[];
        [self getRootCategory];
    } else {
        [_resultListView reloadData];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)getRootCategory {
    CategoryOperation *operation = [[CategoryOperation alloc] init];
    RequestBlock *block = [RequestBlock initWithStartBlock:^{
        NSLog(@"start");
        [SVProgressHUD show];
    } andSuccessBlock:^(NSURLSessionDataTask * _Nullable dataTask, id _Nullable result) {
        NSLog(@"andSuccessBlock");
        _categories = ((CategoryModel *)result).Subcategories;
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

- (IBAction)clickSearchButton:(id)sender {
    if ([_searchField.text length] > 0) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SearchView" bundle:nil];
        SearchViewController *searchVC = [storyboard instantiateInitialViewController];

        searchVC.title = _searchField.text;
        searchVC.searchValue = _searchField.text;
        
        [self.navigationController pushViewController:searchVC animated:YES];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_categories count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *myIdentifier = @"customReuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myIdentifier];
    }
    
    cell.textLabel.text = [[_categories objectAtIndex:indexPath.row] Name];

    if ([[_categories objectAtIndex:indexPath.row] Subcategories] != nil && [[[_categories objectAtIndex:indexPath.row] Subcategories] count] > 0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([[_categories objectAtIndex:indexPath.row] Subcategories] != nil && [[[_categories objectAtIndex:indexPath.row] Subcategories] count] > 0) {
        CategoryViewController *categoryVC = [self.storyboard instantiateViewControllerWithIdentifier:@"categoryStoryboardID"];
        categoryVC.categories = [[_categories objectAtIndex:indexPath.row] Subcategories];
        categoryVC.title = [[_categories objectAtIndex:indexPath.row] Name];
        
        [self.navigationController pushViewController:categoryVC animated:YES];
    } else {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"SearchView" bundle:nil];
        SearchViewController *searchVC = [storyboard instantiateInitialViewController];
        
        searchVC.title = [[_categories objectAtIndex:indexPath.row] Name];
        searchVC.searchValue = [[_categories objectAtIndex:indexPath.row] Name];
        
        [self.navigationController pushViewController:searchVC animated:YES];
    }
    
    [_resultListView deselectRowAtIndexPath:indexPath animated:YES];
}


@end


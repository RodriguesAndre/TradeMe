//
//  DetailViewController.m
//  trademe
//
//  Created by André Rodrigues on 04/05/2018.
//  Copyright © 2018 Verglas. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailItemModel.h"
#import "DetailItemOperation.h"

#import "SVProgressHUD.h"
#import "RequestBlock.h"
#import "Provider.h"

#import "UIImageView+AFNetworking.h"
#import "UIImage+Utils.h"
#import "iCarousel.h"
#import "IDMPhotoBrowser.h"



@interface DetailViewController () <iCarouselDataSource, iCarouselDelegate, IDMPhotoBrowserDelegate, MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *memberLabel;
@property (weak, nonatomic) IBOutlet UILabel *regionLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *startPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *startPriceValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *buyNowPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *buyNowPriceValueLabel;

@property (weak, nonatomic) IBOutlet UIButton *contactButton;

@property (weak, nonatomic) IBOutlet iCarousel *carouselImgVw;

@property (strong, nonatomic) NSString *detailItemID;
@property (strong, nonatomic) DetailItemModel *detailItem;

@property (strong, nonatomic) IDMPhotoBrowser *browser;


@end

@implementation DetailViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _carouselImgVw.decelerationRate = 0.6f;
    _carouselImgVw.bounceDistance = 0.2f;

//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
//    self.navigationController.navigationBar.topItem.title = @"Back";

}

                    
- (void)loadDetailItemWithId:(NSString *)detailID {
    DetailItemOperation *operation = [[DetailItemOperation alloc] init];
    
    operation.urlComplement = [NSString stringWithFormat:@"/%@", detailID];
    operation.fileFormat = @".json";
    
    RequestBlock *block = [RequestBlock initWithStartBlock:^{
        [SVProgressHUD show];
    } andSuccessBlock:^(NSURLSessionDataTask * _Nullable dataTask, id _Nullable result) {
        NSLog(@"SuccessBlock");
        _detailItem = (DetailItemModel *)result;
        [self updateViewWithItem:_detailItem];
    } errorBlock:^(NSURLSessionDataTask * _Nullable dataTask, NSError * _Nonnull error) {
        NSLog(@"error: %@", error);
    } networkErrorBlock:^{
        NSLog(@"networkErrorBlock");
    } finishBlock:^{
        [SVProgressHUD dismiss];
    }];
    
    [Provider requestOperation:operation withBlock:block];
}


- (void)updateViewWithItem:(DetailItemModel *)item {
    _titleLabel.text = item.Title;
    _memberLabel.text = item.Member.Nickname;
    _categoryLabel.text = item.Category;
    _regionLabel.text = item.Region;
    
    _startPriceLabel.alpha = (item.StartPrice > 0);
    _startPriceValueLabel.alpha = (item.StartPrice > 0);
    _startPriceValueLabel.text = [NSString stringWithFormat:@"%.2f$", item.StartPrice];
    
    _buyNowPriceLabel.alpha = (item.BuyNowPrice > 0);
    _buyNowPriceValueLabel.alpha = (item.BuyNowPrice > 0);
    _buyNowPriceValueLabel.text = [NSString stringWithFormat:@"%.2f$", item.BuyNowPrice];
    
    [_carouselImgVw reloadData];
    
    if (_detailItem.Member == nil || _detailItem.Member.Email == nil) {
        _contactButton.alpha = 0;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)contactSeller:(id)sender {

    if([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailCVC = [[MFMailComposeViewController alloc] init];
        mailCVC.mailComposeDelegate = self;
        
        [mailCVC setSubject:@"Trade Me"];
        [mailCVC setToRecipients:[NSArray arrayWithObject:_detailItem.Member.Email]];
        
        [self presentViewController:mailCVC animated:YES completion:nil];
    }
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    return _detailItem.Photos != nil ? [_detailItem.Photos count] : 0;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(nullable UIView *)view {
    UIImageView *itemView;
    if (view == nil) {
        itemView = [[UIImageView alloc] initWithFrame:carousel.frame];
        itemView.contentMode = UIViewContentModeScaleAspectFit;
        itemView.backgroundColor = [UIColor clearColor];
    } else {
        itemView = (UIImageView *)view;
    }
    
    if ([_detailItem.Photos count] > 0) {
        NSURL *photoUrl = [NSURL URLWithString:((PhotoModel *)[_detailItem.Photos objectAtIndex:index]).Large];
        [itemView setImageWithURL:photoUrl placeholderImage:[UIImage imageFromColor:[UIColor lightGrayColor]]];
    }
    
    return itemView;
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index {

    NSMutableArray *photos = [NSMutableArray new];
    
    for (PhotoModel *photoItem in _detailItem.Photos) {
        NSURL *photoUrl = [NSURL URLWithString:photoItem.Large];
        IDMPhoto *photo = [IDMPhoto photoWithURL:photoUrl];
        [photos addObject:photo];
    }
    
    IDMPhotoBrowser *photoBrowser = [[IDMPhotoBrowser alloc] initWithPhotos:photos animatedFromView:[carousel itemViewAtIndex:index]];
    [photoBrowser setInitialPageIndex:index];
    [photoBrowser setDelegate:self];
    
    [self presentViewController:photoBrowser animated:YES completion:nil];
}

- (void)photoBrowser:(IDMPhotoBrowser *)photoBrowser didShowPhotoAtIndex:(NSUInteger)index {
    [_carouselImgVw setCurrentItemIndex:index];
}

@end

//
//  ResultModel.h
//  trademe
//
//  Created by André Rodrigues on 03/05/2018.
//  Copyright © 2018 Verglas. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol ListItemModel;


@interface ListItemModel : JSONModel

@property (assign, nonatomic) NSInteger ListingId;
@property (copy, nonatomic) NSString *Title;
@property (copy, nonatomic) NSString *Category;
@property (assign, nonatomic) NSInteger StartPrice;
@property (assign, nonatomic) NSInteger BuyNowPrice;
@property (copy, nonatomic) NSString *StartDate;
@property (copy, nonatomic) NSString *EndDate;
@property (copy, nonatomic) NSString <Optional> *ListingLength;
@property (copy, nonatomic) NSString *AsAt;
@property (copy, nonatomic) NSString *CategoryPath;
@property (copy, nonatomic) NSString *PictureHref;
@property (assign, nonatomic) bool IsNew;
@property (copy, nonatomic) NSString *Region;
@property (copy, nonatomic) NSString *Suburb;
@property (assign, nonatomic) bool HasBuyNow;
@property (copy, nonatomic) NSString *NoteDate;
@property (assign, nonatomic) NSInteger ReserveState;
@property (assign, nonatomic) bool IsBuyNowOnly;
@property (copy, nonatomic) NSString *PriceDisplay;
@property (assign, nonatomic) bool HasFreeShipping;
@property (assign, nonatomic) NSInteger PromotionId;
//@property (copy, nonatomic) NSArray *AdditionalData;
@property (assign, nonatomic) NSInteger MemberId;

@end

@interface ResultModel : JSONModel

@property (assign, nonatomic) NSInteger TotalCount;
@property (assign, nonatomic) NSInteger Page;
@property (assign, nonatomic) NSInteger PageSize;
@property (strong, nonatomic) NSArray <ListItemModel> *List;
@property (assign, nonatomic) NSString *DidYouMean;
//@property (strong, nonatomic) NSArray *FoundCategories;

@end



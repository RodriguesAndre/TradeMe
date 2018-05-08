//
//  DetailItemModel.h
//  trademe
//
//  Created by André Rodrigues on 04/05/2018.
//  Copyright © 2018 Verglas. All rights reserved.
//

#import <JSONModel/JSONModel.h>



@protocol PhotoModel;

@interface PhotoModel : JSONModel

@property (assign, nonatomic) NSInteger Key;
@property (copy, nonatomic) NSString *Thumbnail;
@property (copy, nonatomic) NSString *Medium;
@property (copy, nonatomic) NSString *Gallery;
@property (copy, nonatomic) NSString *Large;
@property (copy, nonatomic) NSString *FullSize;

@end

@interface MemberModel : JSONModel

@property (assign, nonatomic) NSInteger MemberId;
@property (copy, nonatomic) NSString *Nickname;
@property (copy, nonatomic) NSString *Email;

@end

@interface DetailItemModel : JSONModel

@property (assign, nonatomic) NSInteger ListingId;
@property (copy, nonatomic) NSString *Title;
@property (copy, nonatomic) NSString *Category;
@property (assign, nonatomic) float StartPrice;
@property (assign, nonatomic) float BuyNowPrice;
@property (copy, nonatomic) NSString *StartDate;
@property (assign, nonatomic) NSInteger EndDate;
@property (assign, nonatomic) bool IsFeatured;
@property (assign, nonatomic) bool HasGallery;
@property (copy, nonatomic) NSString *Region;
@property (strong, nonatomic) MemberModel *Member;
@property (strong, nonatomic) NSArray <PhotoModel, Optional> *Photos;



@end

//
//  ResultModel.m
//  trademe
//
//  Created by André Rodrigues on 03/05/2018.
//  Copyright © 2018 Verglas. All rights reserved.
//

#import "ResultModel.h"

@implementation ListItemModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    if ([propertyName isEqualToString:@"IsBuyNowOnly"]) {
        return YES;
    }
    
    if ([propertyName isEqualToString:@"ReserveState"]) {
        return YES;
    }
    
    if ([propertyName isEqualToString:@"HasFreeShipping"]) {
        return YES;
    }
    
    if ([propertyName isEqualToString:@"IsNew"]) {
        return YES;
    }
    
    if ([propertyName isEqualToString:@"HasBuyNow"]) {
        return YES;
    }
    
    if ([propertyName isEqualToString:@"BuyNowPrice"]) {
        return YES;
    }
    
    if ([propertyName isEqualToString:@"PictureHref"]) {
        return YES;
    }
    
    if ([propertyName isEqualToString:@"PromotionId"]) {
        return YES;
    }
    
    return NO;
}

@end

@implementation ResultModel

@end

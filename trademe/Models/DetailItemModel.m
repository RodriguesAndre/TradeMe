//
//  DetailItemModel.m
//  trademe
//
//  Created by André Rodrigues on 04/05/2018.
//  Copyright © 2018 Verglas. All rights reserved.
//

#import "DetailItemModel.h"



@implementation PhotoModel

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"Key": @"Key",
                                                                  @"Thumbnail": @"Value.Thumbnail",
                                                                  @"List": @"Value.List",
                                                                  @"Medium": @"Value.Medium",
                                                                  @"Gallery": @"Value.Gallery",
                                                                  @"Large": @"Value.Large",
                                                                  @"FullSize": @"Value.FullSize"}];
}

@end

@implementation MemberModel


+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    if ([propertyName isEqualToString:@"Email"]) {
        return YES;
    }
    
    return NO;
}

@end


@implementation DetailItemModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    if ([propertyName isEqualToString:@"HasGallery"]) {
        return YES;
    }
    
    if ([propertyName isEqualToString:@"BuyNowPrice"]) {
        return YES;
    }
    
    if ([propertyName isEqualToString:@"IsFeatured"]) {
        return YES;
    }
    
    return NO;
}

@end

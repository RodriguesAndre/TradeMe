//
//  CategoryModel.m
//  trademe
//
//  Created by André Rodrigues on 02/05/2018.
//  Copyright © 2018 Verglas. All rights reserved.
//

#import "CategoryModel.h"

@implementation CategoryModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    if ([propertyName isEqualToString:@"CanBeSecondCategory"]) {
        return YES;
    }
    
    if ([propertyName isEqualToString:@"CanHaveSecondCategory"]) {
        return YES;
    }
    
    if ([propertyName isEqualToString:@"AreaOfBusiness"]) {
        return YES;
    }
    
    return NO;
}

@end

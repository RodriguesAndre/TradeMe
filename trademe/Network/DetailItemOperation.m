//
//  DetailItemOperation.m
//  trademe
//
//  Created by Verglas@2x on 05/05/2018.
//  Copyright © 2018 Verglas. All rights reserved.
//

#import "DetailItemOperation.h"
#import "DetailItemModel.h"

@implementation DetailItemOperation

- (instancetype)init {
    self = [super init];
    if (self) {
        self.modelClassName = NSStringFromClass([DetailItemModel class]);
    }
    return self;
}


- (NSString *)getEndpoint {
    return @"/Listings";
}

@end

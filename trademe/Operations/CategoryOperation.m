//
//  CategoryOperation.m
//  trademe
//
//  Created by André Rodrigues on 30/04/2018.
//  Copyright © 2018 Verglas. All rights reserved.
//

#import "CategoryOperation.h"
#import "CategoryModel.h"

@implementation CategoryOperation

- (instancetype)init {
    self = [super init];
    if (self) {
        self.modelClassName = NSStringFromClass([CategoryModel class]);
    }
    return self;
}


- (NSString *)getEndpoint {
    return @"/Categories/0.json";
}

@end

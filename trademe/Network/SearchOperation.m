//
//  SearchOperation.m
//  trademe
//
//  Created by André Rodrigues on 04/05/2018.
//  Copyright © 2018 Verglas. All rights reserved.
//

#import "SearchOperation.h"
#import "ResultModel.h"

@implementation SearchOperation

- (instancetype)init {
    self = [super init];
    if (self) {
        self.modelClassName = NSStringFromClass([ResultModel class]);
    }
    return self;
}


- (NSString *)getEndpoint {
    return @"/Search/General.json";
}

@end

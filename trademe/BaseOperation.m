//
//  BaseOperation.m
//  trademe
//
//  Created by André Rodrigues on 30/04/2018.
//  Copyright © 2018 Verglas. All rights reserved.
//

#import "BaseOperation.h"

@implementation BaseOperation

- (instancetype)init {
    self = [super init];
    if (self) {
        self.httpVerb = GET;
        self.parameters = [NSMutableDictionary new];
    }
    return self;
}

- (instancetype)initWithParameters:(NSMutableDictionary *)parameters {
    self = [super init];
    if (self) {
        self.parameters = parameters;
    }
    return self;
}

- (instancetype)initWithVerb:(HttpVerb)verb andParameters:(NSMutableDictionary *)parameters {
    self = [super init];
    if (self) {
        self.httpVerb = verb;
        self.parameters = parameters;
    }
    return self;
}

- (NSString *)getEndpoint {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

@end

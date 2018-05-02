//
//  NetworkManager.h
//  trademe
//
//  Created by André Rodrigues on 30/04/2018.
//  Copyright © 2018 Verglas. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BaseOperation, RequestBlock;

@interface NetworkManager : NSObject

+ (instancetype)sharedInstance;
- (NSURLSessionDataTask *)requestOperation:(BaseOperation* _Nonnull)operation withBlock:(RequestBlock *)requestBlock;

@end

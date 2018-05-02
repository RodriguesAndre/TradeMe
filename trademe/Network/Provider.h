//
//  CategoryProvider.h
//  trademe
//
//  Created by André Rodrigues on 02/05/2018.
//  Copyright © 2018 Verglas. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BaseOperation, RequestBlock;

@interface Provider : NSObject

+ (NSURLSessionDataTask *)requestOperation:(BaseOperation *_Nonnull)operation withBlock:(RequestBlock *)requestBlock;
    
@end

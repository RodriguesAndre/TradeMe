//
//  CategoryProvider.m
//  trademe
//
//  Created by André Rodrigues on 02/05/2018.
//  Copyright © 2018 Verglas. All rights reserved.
//

#import "Provider.h"
#import "CategoryModel.h"
#import "CategoryOperation.h"
#import "RequestBlock.h"
#import "NetworkManager.h"
#import "JSONModel.h"


@implementation Provider


+ (NSURLSessionDataTask *)requestOperation:(BaseOperation * _Nonnull)operation withBlock:(RequestBlock *)requestBlock {
 
    RequestBlock *providerBlock = [RequestBlock initWithStartBlock:^{
        [requestBlock onStart];
    } andSuccessBlock:^(NSURLSessionDataTask * _Nullable dataTask, id _Nullable result) {
        
        NSError *error;
        CategoryModel *object = [[NSClassFromString([operation modelClassName]) alloc] initWithDictionary:result error:&error];
        
        if (error) {
            [requestBlock onError:error];
        } else {
            [requestBlock onSuccess:object];
        }

        [requestBlock onFinish];
    } errorBlock:^(NSURLSessionDataTask * _Nullable dataTask, NSError * _Nonnull error) {
        [requestBlock onError:error];
        [requestBlock onFinish];
    } networkErrorBlock:^{
        [requestBlock onNetworkError];
        [requestBlock onFinish];
    } finishBlock:nil];//Todo: use promises to chain tasks
    
    return [[NetworkManager sharedInstance] requestOperation:operation withBlock:providerBlock];
}


@end

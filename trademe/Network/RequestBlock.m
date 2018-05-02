//
//  RequestBlock.m
//  trademe
//
//  Created by André Rodrigues on 30/04/2018.
//  Copyright © 2018 Verglas. All rights reserved.
//

#import "RequestBlock.h"

@implementation RequestBlock

+ (instancetype)initWithStartBlock:(Start)startBlock
                   andSuccessBlock:(Success)successBlock
                        errorBlock:(Error)errorBlock
                 networkErrorBlock:(NetworkError)networkErrorBlock
                       finishBlock:(Finish)finishBlock {
    RequestBlock *block = [RequestBlock new];
    block.startBlock = startBlock;
    block.successBlock = successBlock;
    block.errorBlock = errorBlock;
    block.networkErrorBlock = networkErrorBlock;
    block.finishBlock = finishBlock;
    
    return block;
}


- (void)onStart {
    if (self.startBlock) {
        self.startBlock();
    }
}

- (void)onSuccess:(id)object {
    self.successBlock(nil, object);
}

- (void)onError:(NSError *)error {
    self.errorBlock(nil, error);
}

- (void)onNetworkError {
    if (self.networkErrorBlock) {
        self.networkErrorBlock();
    }
}

- (void)onFinish {
    if (self.finishBlock) {
        self.finishBlock();
    }
}


@end



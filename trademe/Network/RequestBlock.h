//
//  RequestBlock.h
//  trademe
//
//  Created by André Rodrigues on 30/04/2018.
//  Copyright © 2018 Verglas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestProtocol.h"


@interface RequestBlock : NSObject<RequestProtocol>

@property (nonatomic, strong) Start startBlock;
@property (nonatomic, strong) Success successBlock;
@property (nonatomic, strong) Error errorBlock;
@property (nonatomic, strong) NetworkError networkErrorBlock;
@property (nonatomic, strong) Finish finishBlock;

+ (instancetype)initWithStartBlock:(Start)startBlock
                   andSuccessBlock:(Success)successBlock
                        errorBlock:(Error)errorBlock
                 networkErrorBlock:(NetworkError)networkErrorBlock
                       finishBlock:(Finish)finishBlock;

@end

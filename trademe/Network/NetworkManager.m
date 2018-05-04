//
//  NetworkManager.m
//  trademe
//
//  Created by André Rodrigues on 30/04/2018.
//  Copyright © 2018 Verglas. All rights reserved.
//

#import "NetworkManager.h"
#import <AFNetworking/AFNetworking.h>
#import "BaseOperation.h"
#import "RequestBlock.h"

@interface NetworkManager ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end

@implementation NetworkManager


static NSString *kBaseURL = @"https://api.tmsandbox.co.nz/v1";

static NSString *kAuthorizationKey = @"Authorization";
static NSString *kAuthorizationValue = @"OAuth oauth_consumer_key=\"A1AC63F0332A131A78FAC304D007E7D1\",oauth_signature_method=\"HMAC-SHA1\",oauth_timestamp=\"1525266047\",oauth_nonce=\"FJQsJbldW57\",oauth_version=\"1.0\",oauth_signature=\"sdhmu%2FuyTLjuqHX1m%2BfJxZxXwqo%3D\"";


+ (instancetype)sharedInstance {
    static NetworkManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[NetworkManager alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _sessionManager = [AFHTTPSessionManager manager];
        
        _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        [_sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [_sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [_sessionManager.requestSerializer setValue:@"OAuth oauth_consumer_key=\"A1AC63F0332A131A78FAC304D007E7D1\", oauth_signature_method=\"PLAINTEXT\", oauth_signature=\"EC7F18B17A062962C6930A8AE88B16C7&\"" forHTTPHeaderField:kAuthorizationKey];
        
//        [_sessionManager.requestSerializer setValue:kAuthorizationValue forHTTPHeaderField:kAuthorizationKey];
        
    }
    return self;
}


- (NSString *)urlFromOperation:(BaseOperation *)operation {
    return [NSString stringWithFormat:@"%@%@%@", kBaseURL, [operation getEndpoint], ([operation urlComplement] ? [operation urlComplement] : @"")];
}

- (NSURLSessionDataTask *)requestOperation:(BaseOperation* _Nonnull)operation withBlock:(RequestBlock *)requestBlock {
    
    NSURLSessionDataTask *dataTask;
    NSString *url = [self urlFromOperation:operation];
    requestBlock.startBlock();
    
    switch ([operation httpVerb]) {
        case GET:
            dataTask = [_sessionManager GET:url
                                 parameters:[operation parameters]
                                   progress:nil
                                    success:requestBlock.successBlock
                                    failure:requestBlock.errorBlock];
            break;
        case POST:
            dataTask = [_sessionManager POST:url
                                  parameters:[operation parameters]
                                    progress:nil
                                     success:requestBlock.successBlock
                                     failure:requestBlock.errorBlock];
            break;
        case PUT:
            dataTask = [_sessionManager PUT:url
                                 parameters:[operation parameters]
                                    success:requestBlock.successBlock
                                    failure:requestBlock.errorBlock];
            break;
        case PATCH:
            dataTask = [_sessionManager PATCH:url
                                   parameters:[operation parameters]
                                      success:requestBlock.successBlock
                                      failure:requestBlock.errorBlock];
            break;
        case DELETE:
            dataTask = [_sessionManager DELETE:url
                                    parameters:[operation parameters]
                                       success:requestBlock.successBlock
                                       failure:requestBlock.errorBlock];
            break;
    }
    return dataTask;
}

@end

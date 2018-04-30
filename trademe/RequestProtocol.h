//
//  RequestProtocol.h
//  trademe
//
//  Created by André Rodrigues on 30/04/2018.
//  Copyright © 2018 Verglas. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^Start)(void);
typedef void (^Success)(NSURLSessionDataTask * _Nullable, id _Nullable);
typedef void (^Error)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull);
typedef void (^NetworkError)(void);
typedef void (^Finish)(void);

@protocol RequestProtocol<NSObject>

- (void)onSuccess:(id _Nullable)object;
- (void)onFailure:(NSError* _Nonnull)error;

@optional
- (void)onStart;
- (void)onFinish;
- (void)onNetworkError;

@end

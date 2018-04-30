//
//  BaseOperation.h
//  trademe
//
//  Created by André Rodrigues on 30/04/2018.
//  Copyright © 2018 Verglas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseOperation : NSObject

typedef enum { GET, POST, PUT, PATCH, DELETE } HttpVerb;

@property (nonatomic, strong) NSMutableDictionary *parameters;
@property (nonatomic, assign) HttpVerb httpVerb;
@property (nonatomic, strong) NSString *urlComplement;
@property (nonatomic, strong) id operationResult;


- (instancetype)initWithParameters:(NSDictionary *)parameters;
- (NSString *)getEndpoint;

@end

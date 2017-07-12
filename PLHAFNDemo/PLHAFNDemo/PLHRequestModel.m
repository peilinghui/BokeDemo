//
//  PLHRequestModel.m
//  PLHAFNDemo
//
//  Created by peilinghui on 2017/7/12.
//  Copyright © 2017年 peilinghui. All rights reserved.
//

#import "PLHRequestModel.h"

@implementation PLHRequestModel

- (instancetype)init {
    if (self = [super init]) {
    
    }
    
    return self;
}

- (NSString *)convertURLPart:(NSString *)urlPart {
    NSMutableString  *mutableString = [urlPart mutableCopy];
    
    if ([mutableString hasPrefix:@"/"]) {
        [mutableString deleteCharactersInRange:NSMakeRange(0, 1)];
    }
    
    if ([mutableString hasSuffix:@"/"]) {
        [mutableString deleteCharactersInRange:NSMakeRange(mutableString.length - 1, 1)];
    }
    
    return [mutableString copy];
}

- (void)setServerRoot:(NSString *)serverRoot {
    _serverRoot = [self convertURLPart:serverRoot];
}

- (void)setActionPath:(NSString *)actionPath {
    _actionPath = [self convertURLPart:actionPath];
}

- (void)setApiVersion:(NSString *)apiVersion {
    _apiVersion = [self convertURLPart:apiVersion];
}

- (void)setServiceName:(NSString *)serviceName {
    _serviceName = [self convertURLPart:serviceName];
}

@end

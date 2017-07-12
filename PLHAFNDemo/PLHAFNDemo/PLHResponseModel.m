//
//  PLHResponseModel.m
//  PLHAFNDemo
//
//  Created by peilinghui on 2017/7/12.
//  Copyright © 2017年 peilinghui. All rights reserved.
//

#import "PLHResponseModel.h"

static NSString *kNetworkErrorDomain = @"kNetworkErrorDomain";

@implementation PLHResponseModel


//此判断限制了返回的responseModel必须是这种的格式，不具有适用性
- (BOOL)isSuccess
{
    if (self.responseObject) {
        NSNumber *code = [self.responseObject objectForKey:@"code"];
        
        if ([code integerValue] == 0) {
            NSString *message = [self.responseObject objectForKey:@"message"];
            self.error = [NSError errorWithDomain:kNetworkErrorDomain code:[code integerValue] userInfo:@{NSLocalizedDescriptionKey : message}];
            return NO;
        } else {
            self.dataObject = [self.responseObject objectForKey:@"data"];
            return YES;
        }
    }
    self.error = [NSError errorWithDomain:kNetworkErrorDomain code:-1 userInfo:@{NSLocalizedDescriptionKey : @"返回对象为空"}];
    
    return NO;
}

@end

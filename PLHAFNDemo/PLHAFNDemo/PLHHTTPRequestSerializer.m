//
//  PLHHTTPRequestSerializer.m
//  PLHAFNDemo
//
//  Created by peilinghui on 2017/7/12.
//  Copyright © 2017年 peilinghui. All rights reserved.
//

#import "PLHHTTPRequestSerializer.h"
#import "AFURLRequestSerialization.h"
#import "PLHRequestModel.h"
#import "PLHCommonParams.h"
#import "NSString+UtilNetworking.h"
static NSTimeInterval kPLHANetworkingTimeoutSeconds = 20.0f;//设置超时时间


@interface PLHHTTPRequestSerializer ()


@property (nonatomic, strong) AFHTTPRequestSerializer *httpRequestSerializer;

@end


@implementation PLHHTTPRequestSerializer

+(instancetype)sharedInstance{
    static dispatch_once_t  onceToken;
    static PLHHTTPRequestSerializer *shareInstance = nil;
    
    dispatch_once(&onceToken,^{
        shareInstance = [[PLHHTTPRequestSerializer alloc]init];
    });
    return shareInstance;
}

//生成NSURLRequest
-(NSURLRequest *)generateWithRequestWithModel:(PLHRequestModel *)requestModel{
    
//可以写个BaseService来管理不同的环境，例如开发，测试，预发布和发布--没写
    NSMutableDictionary *commonParams = [NSMutableDictionary dictionaryWithDictionary:[PLHCommonParams commonParamsDictionary]];
    [commonParams addEntriesFromDictionary:requestModel.parameters];
    
    NSString *urlString = [self URLStringWithServiceUrl:requestModel.serverRoot path:requestModel.actionPath];
    
    NSError *error;
    NSMutableURLRequest *mutableRequest;
    
    NSMutableDictionary<NSString *, NSString *> *headers = [mutableRequest.allHTTPHeaderFields mutableCopy];
    mutableRequest.allHTTPHeaderFields = headers;
    
    if (requestModel.requestType == PLHHTTPRequestTypeGET) {
        mutableRequest = [self.httpRequestSerializer requestWithMethod:@"GET" URLString:urlString parameters:commonParams error:&error];
    } else if (requestModel.requestType == PLHHTTPRequestTypePOST) {
        mutableRequest = [self.httpRequestSerializer requestWithMethod:@"POST" URLString:urlString parameters:commonParams error:&error];
    }
    
      mutableRequest.timeoutInterval = kPLHANetworkingTimeoutSeconds;
    return mutableRequest;
}


#pragma mark - private methods
- (NSString *)URLStringWithServiceUrl:(NSString *)serviceUrl path:(NSString *)path{
    NSURL *fullURL = [NSURL URLWithString:serviceUrl];
    if (![NSString isEmptyString:path]) {
        fullURL = [NSURL URLWithString:path relativeToURL:fullURL];
    }
    if (fullURL == nil) {
        NSLog(@"YAAPIURLRequestGenerator--URL拼接错误:\n---------------------------\n\
              apiBaseUrl:%@\n\
              urlPath:%@\n\
              \n---------------------------\n",serviceUrl,path);
        return nil;
    }
    return [fullURL absoluteString];
}

#pragma mark - getters and setters
- (AFHTTPRequestSerializer *)httpRequestSerializer
{
    if (_httpRequestSerializer == nil) {
        _httpRequestSerializer = [AFHTTPRequestSerializer serializer];
        _httpRequestSerializer.timeoutInterval = kPLHANetworkingTimeoutSeconds;
        _httpRequestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    }
    return _httpRequestSerializer;
}


@end

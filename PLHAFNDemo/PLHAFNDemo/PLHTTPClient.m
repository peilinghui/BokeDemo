//
//  PLHTTPClient.m
//  PLHAFNDemo
//
//  Created by peilinghui on 2017/7/12.
//  Copyright © 2017年 peilinghui. All rights reserved.
//

#import "PLHTTPClient.h"
#import "AFURLSessionManager.h"
#import  <AFHTTPSessionManager.h>
#import "PLHHTTPRequestSerializer.h"
#import "PLHRequestModel.h"
#import "PLHCommonParams.h"
#import "PLHResponseModel.h"
@interface PLHTTPClient ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;

@end


@implementation PLHTTPClient

+(instancetype)sharedInstance{
    static PLHTTPClient *shareClient  = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        shareClient = [[PLHTTPClient alloc]init];
    
    });
    return shareClient;
}

//根据requestModel发起网络请求，并且发起回调

- (NSURLSessionDataTask *)callRequestWithRequestModel:(PLHRequestModel *)requestModel
                                             progress:(nullable void (^)(NSProgress *_Nullable))progressBlock
                                             callback:(nullable void (^)(PLHResponseModel *_Nullable))callback
{
    
    NSURLRequest *request = [[PLHHTTPRequestSerializer sharedInstance]generateWithRequestWithModel:requestModel];
    typeof (self)__weak weaksSelf = self;
    AFURLSessionManager *sessionManager = self.sessionManager;
    NSURLSessionDataTask *sessionDataTask = nil;
    
    NSString *urlString = [NSString stringWithFormat:@"%@/%@", requestModel.serverRoot, requestModel.serviceName];
    
    //发送的参数
    NSMutableDictionary *mutableParameters = requestModel.parameters? [requestModel.parameters mutableCopy] : [NSMutableDictionary dictionaryWithCapacity:4];
    
    //共有默认参数
    NSDictionary *defaultParameters = [PLHCommonParams commonParamsDictionary];
    
    [defaultParameters enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if (![requestModel.parameters.allKeys containsObject:key]) {
            mutableParameters[key] = obj;
        }
    }];
    
    NSDictionary *parameters = [mutableParameters copy];
    
    NSLog(@"%@",parameters);
    

    //发送请求成功的successBlock
    void (^successBlock)(NSURLSessionDataTask *, id) = ^(NSURLSessionDataTask *task, id oresponseObject){
        PLHResponseModel *responseModel = [[PLHResponseModel alloc] init];
        responseModel.responseObject = oresponseObject;
        responseModel.sessionDataTask = task;
        
        NSLog(@"responseObject：%@",oresponseObject);
        NSInteger code = [oresponseObject[@"code"] integerValue];
        
        if(callback) {
            callback(responseModel);
        }
    };
    
    //发送请求失败的failureBlock
    void (^failureBlock)(NSURLSessionDataTask *, NSError *) = ^(NSURLSessionDataTask *task, NSError *error) {
        PLHResponseModel *responseModel = [[PLHResponseModel alloc] init];
     
        NSDictionary *userInfo = @{NSLocalizedDescriptionKey : @"网络不给力，请稍后再试"};
        error = [NSError errorWithDomain:@"TDF" code:error.code userInfo:userInfo];
        
        responseModel.error = error;
        
        responseModel.sessionDataTask = task;
        
        if(callback) {
            callback(responseModel);
        }
    };
    
    switch (requestModel.requestType) {
            
        case PLHHTTPRequestTypeGET: {
            sessionDataTask = [self.sessionManager GET:urlString parameters:parameters progress:progressBlock success:successBlock failure:failureBlock];
        }
            break;
        case PLHHTTPRequestTypePOST:{
            sessionDataTask = [self.sessionManager POST:urlString parameters:parameters progress:progressBlock success:successBlock failure:failureBlock];
        }
            break;
    }
    
    return sessionDataTask;
}



- (AFHTTPSessionManager *)getCommonSessionManager
{
    NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024 diskCapacity:20 * 1024 * 1024 diskPath:nil];
    [NSURLCache setSharedURLCache:URLCache];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.timeoutIntervalForResource = 20;
    
    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    return sessionManager;
}

#pragma mark - getters and setters
- (AFHTTPSessionManager *)sessionManager
{
    if (_sessionManager == nil) {
        _sessionManager = [self getCommonSessionManager];
        _sessionManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        _sessionManager.requestSerializer = [[AFHTTPRequestSerializer alloc] init];
        _sessionManager.responseSerializer = [[AFJSONResponseSerializer alloc] init];
        
        NSMutableSet *contentTypes = [_sessionManager.responseSerializer.acceptableContentTypes mutableCopy];
        [contentTypes addObject:@"text/plain"];
        
        _sessionManager.responseSerializer.acceptableContentTypes = [contentTypes copy];
    }
    return _sessionManager;
}

- (void)setRequestSerializer:(AFHTTPRequestSerializer <AFURLRequestSerialization> *)requestSerializer {
    NSParameterAssert(requestSerializer);
    
     _sessionManager.requestSerializer = requestSerializer;
}

@end

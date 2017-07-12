//
//  PLHRequestModel.h
//  PLHAFNDemo
//
//  Created by peilinghui on 2017/7/12.
//  Copyright © 2017年 peilinghui. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,PLHHTTPRequestType){
    PLHHTTPRequestTypeGET,
    PLHHTTPRequestTypePOST
};


typedef NS_ENUM(NSUInteger, PLHHTTPServiceType) {
    PLHHTTPServiceTypeVerfication, //验证的服务器
    PLHHTTPServiceTypeBASE  //基础业务的服务器
};

@interface PLHRequestModel : NSObject

//网络请求参数
@property (nonatomic, nonnull, copy) NSString * serverRoot; //网络请求的根地址
@property (nonatomic, nonnull, copy) NSString * actionPath;//发起响应的二级地址
@property (nonatomic, assign) float timeout;  //时间
@property (nonatomic, assign) PLHHTTPRequestType requestType;  //网络请求方式
@property (nonatomic, nonnull, copy) NSString * serviceName;
@property (nonatomic, nullable, copy) NSString *apiVersion;
@property (nonatomic, nullable, copy) NSDictionary *parameters; // 请求参数
@property (nonatomic, assign) PLHHTTPServiceType serviceType;

@end

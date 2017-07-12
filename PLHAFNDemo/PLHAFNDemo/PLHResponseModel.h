//
//  PLHResponseModel.h
//  PLHAFNDemo
//
//  Created by peilinghui on 2017/7/12.
//  Copyright © 2017年 peilinghui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PLHResponseModel : NSObject


@property (nonatomic, strong) NSError *error;

@property (nonatomic, strong) id responseObject;

@property (nonatomic, strong) id dataObject;

@property (nonatomic, strong) NSURLSessionDataTask *sessionDataTask;

- (BOOL)isSuccess;


@end

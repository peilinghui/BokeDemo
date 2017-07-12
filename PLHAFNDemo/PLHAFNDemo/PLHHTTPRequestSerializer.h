//
//  PLHHTTPRequestSerializer.h
//  PLHAFNDemo
//
//  Created by peilinghui on 2017/7/12.
//  Copyright © 2017年 peilinghui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PLHRequestModel.h"
@interface PLHHTTPRequestSerializer : NSObject


+(instancetype)sharedInstance;
-(NSURLRequest *)generateWithRequestWithModel:(PLHRequestModel *)requestModel;
@end

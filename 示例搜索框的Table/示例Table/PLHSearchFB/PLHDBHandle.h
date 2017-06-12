//
//  PLHDBHandle.h
//  示例Table
//
//  Created by peilinghui on 2017/6/9.
//  Copyright © 2017年 peilinghui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PLHDBHandle : NSObject

//根据参数去取数据

+(NSDictionary *)statuesWithParams:(NSDictionary *)params;

//存储数据到沙盒

+(void)saveStatuses:(NSDictionary *)statuses andParam:(NSDictionary *)paramDict;
@end

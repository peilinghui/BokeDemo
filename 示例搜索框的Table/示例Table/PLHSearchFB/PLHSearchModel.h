//
//  PLHSearchModel.h
//  示例Table
//
//  Created by peilinghui on 2017/6/9.
//  Copyright © 2017年 peilinghui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PLHSearchModel : NSObject


@property (nonatomic, copy) NSString * content_name;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end

//
//  PLHSearchModel.m
//  示例Table
//
//  Created by peilinghui on 2017/6/9.
//  Copyright © 2017年 peilinghui. All rights reserved.
//

#import "PLHSearchModel.h"

#define FAST_DirectoryModel_SET_VALUE_FOR_STRING(dictname,value) dictionary[dictname]!= nil &&dictionary[dictname]!=[NSNull null]? dictionary[dictname] : value;

@implementation PLHSearchModel

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.content_name = FAST_DirectoryModel_SET_VALUE_FOR_STRING(@"content_name", @"");
    }
    return self;
}

@end

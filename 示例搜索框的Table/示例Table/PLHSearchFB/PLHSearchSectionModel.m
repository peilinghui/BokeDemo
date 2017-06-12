//
//  PLHSearchSectionModel.m
//  示例Table
//
//  Created by peilinghui on 2017/6/9.
//  Copyright © 2017年 peilinghui. All rights reserved.
//

#import "PLHSearchSectionModel.h"
#import "PLHSearchModel.h"

#define FAST_DirectoryModel_SET_VALUE_FOR_STRING(dictname,value) dictionary[dictname]!= nil &&dictionary[dictname]!=[NSNull null]? dictionary[dictname] : value;

@interface PLHSearchSectionModel ()

@property (nonatomic, strong)NSMutableArray *content_Array;

@end
@implementation PLHSearchSectionModel
-(NSMutableArray *)content_Array
{
    if (_content_Array == nil) {
        _content_Array = [NSMutableArray array];
    }
    return _content_Array;
}


- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.section_id = FAST_DirectoryModel_SET_VALUE_FOR_STRING(@"section_id", @"0");
        self.section_title = FAST_DirectoryModel_SET_VALUE_FOR_STRING(@"section_title", @"");
        NSArray *emp = FAST_DirectoryModel_SET_VALUE_FOR_STRING(@"section_content",@[]);
        if (emp.count > 0) {
            for (NSDictionary *content_dict in emp) {
                PLHSearchModel *model = [[PLHSearchModel alloc] initWithDictionary:content_dict];
                [self.content_Array addObject:model];
            }
            self.section_contentArray = self.content_Array;
        }
    }
    return self;
}

@end

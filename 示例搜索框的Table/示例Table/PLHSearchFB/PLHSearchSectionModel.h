//
//  PLHSearchSectionModel.h
//  示例Table
//
//  Created by peilinghui on 2017/6/9.
//  Copyright © 2017年 peilinghui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PLHSearchSectionModel : NSObject

@property (nonatomic, copy) NSString *section_id;
@property (nonatomic, copy) NSString *section_title;
@property (nonatomic, copy) NSArray *section_contentArray;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end

//
//  NSDictionary+MutableDeepCopy.m
//  mutablestring
//
//  Created by peilinghui on 2017/3/17.
//  Copyright © 2017年 peilinghui. All rights reserved.
//

#import "NSDictionary+MutableDeepCopy.h"

@implementation NSDictionary (MutableDeepCopy)
-(NSMutableDictionary *)mutableDeepCopy
{
    NSMutableDictionary *dict=[[NSMutableDictionary alloc] initWithCapacity:[self count]];
    //新建一个NSMutableDictionary对象，大小为原NSDictionary对象的大小
    NSArray *keys=[self allKeys];
    for(id key in keys)
    {//循环读取复制每一个元素
        id value=[self objectForKey:key];
        id copyValue;
        if ([value respondsToSelector:@selector(mutableDeepCopy)]) {
            //如果key对应的元素可以响应mutableDeepCopy方法(还是NSDictionary)，调用mutableDeepCopy方法复制
            copyValue=[value mutableDeepCopy];
        }else if([value respondsToSelector:@selector(mutableCopy)])
        {
            copyValue=[value mutableCopy];
        }
        if(copyValue==nil)
            copyValue=[value copy];
        [dict setObject:copyValue forKey:key];
        
    }
    return dict;
}

@end

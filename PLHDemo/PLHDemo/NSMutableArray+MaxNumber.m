//
//  NSMutableArray+MaxNumber.m
//  PLHDemo
//
//  Created by peilinghui on 2017/7/4.
//  Copyright © 2017年 user. All rights reserved.
//

#import "NSMutableArray+MaxNumber.h"

@implementation NSMutableArray (MaxNumber)

-(NSInteger)maxNumberOfArray{
    if (self.count >0) {
        int max = [[self objectAtIndex:0]intValue];
        for (int i =0; i <self.count; i++) {
            int num = [[self objectAtIndex:i]intValue];
            
            if (num >max) {
                max = num;
            }
        }
        return max;
        
    }
    return 0;
}
@end

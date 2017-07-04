//
//  Node.m
//  TableViewTreeDemo
//
//  Created by peilinghui on 2017/4/3.
//  Copyright © 2017年 peilinghui. All rights reserved.
//

#import "Node.h"

@implementation Node

-(instancetype)initWithParentId:(int)parentId nodeId:(int)nodeId name:(NSString *)name depth:(int)depth expand:(BOOL)expand{
    
    self = [self init];
    if (self) {
        self.parentId =parentId;
        self.nodeId = nodeId;
        self.name = name;
        self.depth = depth;
        self.expand = expand;
    }

    return self;
}
@end

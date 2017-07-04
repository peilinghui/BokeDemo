//
//  Node.h
//  TableViewTreeDemo
//
//  Created by peilinghui on 2017/4/3.
//  Copyright © 2017年 peilinghui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Node : NSObject

@property(nonatomic, assign)int  parentId;//父节点的id，如果为-1表示该节点为根节点

@property (nonatomic , assign) int nodeId;//本节点的id

@property (nonatomic , strong) NSString *name;//本节点的名称

@property (nonatomic , assign) int depth;//该节点的深度

@property (nonatomic , assign) BOOL expand;//该节点是否处于展开状态


/**
 *快速实例化该对象模型
 */

-(instancetype)initWithParentId:(int)parentId nodeId:(int)nodeId name:(NSString *)name depth:(int)depth expand:(BOOL)expand;

@end

//
//  TreeTableView.m
//  TableViewTreeDemo
//
//  Created by peilinghui on 2017/4/3.
//  Copyright © 2017年 peilinghui. All rights reserved.
//

#import "TreeTableView.h"

#import "Node.h"
@interface TreeTableView()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSArray *data;//传递过来已经组织好的数据（全量数据）

@property(nonatomic,strong)NSMutableArray *tempData;//用于存储数据源（部分数据）
@end

@implementation TreeTableView


-(instancetype)initWithFrame:(CGRect)frame withData:(NSArray *)data{
    
    self = [super initWithFrame:frame
                          style:UITableViewStyleGrouped];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        _data = data;
        _tempData = [self createTempData:data];
    }
    
    return self;
}

/**
 * 初始化数据源
 */
-(NSMutableArray *)createTempData:(NSArray *)data{
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i<data.count; i++) {
        Node *node = [_data objectAtIndex:i];
        if (node.expand) {
            [tempArray addObject:node];
        }
    }
    return tempArray;
}

#pragma mark--UITableView DataSource
#pragma mark -- require

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  _tempData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *NODE_CELL_ID = @"node_cell_id";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NODE_CELL_ID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NODE_CELL_ID];
    }
    
    Node *node = [_tempData objectAtIndex:indexPath.row];
    
    cell.indentationLevel= node.depth;//缩进的级别
    cell.indentationWidth = 30.f;//缩进的距离
    
    cell.textLabel.text = node.name;

    return cell;
    
    
}

#pragma mark -- option
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

#pragma mark --UItableViewDelegate

#pragma mark -option
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //该数据源
    Node *parentNode = [_tempData objectAtIndex:indexPath.row];
    
    if(_treeTableCellDelegate && [_treeTableCellDelegate respondsToSelector:@selector(clickCell:)]){
        [_treeTableCellDelegate clickCell:parentNode];
    }
    
    //当点击上一级的cell时要展开子cell的位置
    NSInteger startPosition = indexPath.row +1;
    NSInteger endPosition = startPosition;
    
    //初始化扩展为no
    BOOL expand = NO;
    
    for (int i = 0; i<_data.count; i++) {
        Node *node = [_data objectAtIndex:i];
        //记录下每个结点的父节点，当id相同的时候调用
        if(node.parentId == parentNode.nodeId){
            node.expand = !node.expand;
            if (node.expand) {
                //如果是可扩展的话把cell插入
                [_tempData insertObject:node atIndex:endPosition];
                expand = YES;
                endPosition++;
            }else{
                //如果是不可扩展的，就把所有的结点移除
                expand = NO;
                endPosition = [self removeAllNodesAtParentNode:parentNode];
                break;
            }
        }
    }
    
    //获得需要修正的indexPath
    NSMutableArray *indexPathArray = [NSMutableArray array];
    for (NSUInteger i =startPosition ; i<endPosition; i++) {
        NSIndexPath *tempIndexPath= [NSIndexPath indexPathForRow:i inSection:0];
        [indexPathArray addObject:tempIndexPath];
    }
    
    //可扩展就插入或者删除相关结点的动画
    if (expand) {
        [self insertRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationNone];
    }else{
        [self deleteRowsAtIndexPaths:indexPathArray withRowAnimation:UITableViewRowAnimationLeft];
    }

}


/**
 *  删除该父节点下的所有子节点（包括孙子节点）
 *
 *  @param parentNode 父节点
 *
 *  @return 该父节点下一个相邻的统一级别的节点的位置
 */
-(NSUInteger)removeAllNodesAtParentNode:(Node *)parentNode{
    NSUInteger startPositon = [_tempData indexOfObject:parentNode];
    NSUInteger endPositon = startPositon;
    for (NSUInteger i = startPositon + 1; i<_tempData.count; i++) {
        Node *node = [_tempData objectAtIndex:i];
        endPositon++;
        if (node.depth <= parentNode.depth) {
            break;
        }
        if (endPositon == _tempData.count -1) {
            endPositon++;
            node.expand = NO;
            break;
        }
        node.expand = NO;
    }
    if (endPositon >startPositon) {
        [_tempData removeObjectsInRange:NSMakeRange(startPositon+1,endPositon-startPositon-1 )];
        
    }
    return endPositon;
}




@end

//
//  ViewController.m
//  TableViewTreeDemo
//
//  Created by peilinghui on 2017/4/3.
//  Copyright © 2017年 peilinghui. All rights reserved.
//

#import "ViewController.h"
#import "Node.h"
#import "TreeTableView.h"

@interface ViewController ()<TreeTableCellDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
}


- (void)initData{
    
//    for (int i = 0; i<5; i++) {
#pragma mark -- 1结点的展开
    Node *big1 = [[Node alloc]initWithParentId:-1 nodeId:0  name:@"1" depth:0 expand:YES];
//    }
    
    Node *middle1 = [[Node alloc]initWithParentId:0 nodeId:1  name:@"1.1" depth:1 expand:NO];
    
    Node *middle2 = [[Node alloc]initWithParentId:0 nodeId:2  name:@"1.2" depth:1 expand:NO];
    
    Node *small1 = [[Node alloc]initWithParentId:1 nodeId:3  name:@"1.1.1" depth:2 expand:NO];
    
     Node *small2 = [[Node alloc]initWithParentId:1 nodeId:4  name:@"1.1.2" depth:2 expand:NO];
    
    Node *small3 = [[Node alloc]initWithParentId:2 nodeId:5  name:@"1.2.1" depth:2 expand:NO];
    
    Node *big2 = [[Node alloc]initWithParentId:-1 nodeId:6  name:@"2" depth:0 expand:YES];
    
    Node *middle21 = [[Node alloc]initWithParentId:6 nodeId:10  name:@"2.1" depth:1 expand:NO];
    
    Node *middle22 = [[Node alloc]initWithParentId:6 nodeId:11 name:@"2.2" depth:1 expand:NO];
    
    Node *small11 = [[Node alloc]initWithParentId:10 nodeId:12  name:@"2.1.1" depth:2 expand:NO];
    
    Node *big3 = [[Node alloc]initWithParentId:-1 nodeId:7  name:@"3" depth:0 expand:YES];
    
    Node *big4 = [[Node alloc]initWithParentId:-1 nodeId:8  name:@"4" depth:0 expand:YES];
    
    Node *big5 = [[Node alloc]initWithParentId:-1 nodeId:9  name:@"5" depth:0 expand:YES];
    
    NSArray *data = [NSArray arrayWithObjects:big1,big2,big3,big4,big5 ,middle1,middle2,small1,small2,small3,middle21,middle22,small11, nil];
    
    
    
    TreeTableView *tableView = [[TreeTableView alloc]initWithFrame:CGRectMake(0, 20, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-10) withData:data];
    tableView.treeTableCellDelegate = self;
    [self.view addSubview:tableView];
    
}



#pragma mark --treeTableCellDelegate

-(void)clickCell:(Node *)node{
    NSLog(@"点击的是cell%@",node.name);
}
@end

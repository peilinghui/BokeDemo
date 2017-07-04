//
//  TreeTableView.h
//  TableViewTreeDemo
//
//  Created by peilinghui on 2017/4/3.
//  Copyright © 2017年 peilinghui. All rights reserved.
//

#import <UIKit/UIKit.h>


@class Node;
@protocol TreeTableCellDelegate <NSObject>

- (void)clickCell:(Node *)node;

@end
@interface TreeTableView : UITableView

@property(nonatomic,weak)id<TreeTableCellDelegate>treeTableCellDelegate;

-(instancetype)initWithFrame:(CGRect)frame withData:(NSArray *)data;

- (NSMutableArray *)createTempData:(NSArray *)data;
@end

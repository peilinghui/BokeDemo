//
//  PLHHistoryTableViewCell.h
//  示例Table
//
//  Created by peilinghui on 2017/6/8.
//  Copyright © 2017年 peilinghui. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PLHHistoryTableViewCell;

@protocol DeleteHistoryCellDelegate <NSObject>

- (void)onDelHistoryCellRecord:(PLHHistoryTableViewCell *)cell;

@end
@interface PLHHistoryTableViewCell : UITableViewCell

@property (nonatomic,strong)UILabel *strLab;
@property (nonatomic,weak)id<DeleteHistoryCellDelegate>delegate;
@property (nonatomic,strong)UIView *lineView;
@property (nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,strong)UIButton *deleteKeyword;
@end

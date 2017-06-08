//
//  PLHHistoryHeaderView.h
//  示例Table
//
//  Created by peilinghui on 2017/6/8.
//  Copyright © 2017年 peilinghui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HistoryDeleteDelegate <NSObject>

- (void)clickhistoryAllDeleteDelegate;

@end

@interface PLHHistoryHeaderView : UIView

@property(nonatomic,weak)id<HistoryDeleteDelegate>delegate;
@end

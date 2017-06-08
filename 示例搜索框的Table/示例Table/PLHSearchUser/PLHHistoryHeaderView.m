//
//  PLHHistoryHeaderView.m
//  示例Table
//
//  Created by peilinghui on 2017/6/8.
//  Copyright © 2017年 peilinghui. All rights reserved.
//

#import "PLHHistoryHeaderView.h"
#import "Masonry.h"

@interface PLHHistoryHeaderView ()


@property (nonatomic, strong) UIView *topSplitLine;
@property (nonatomic, strong) UILabel *headerTitleLabel;
@property (nonatomic,strong) UIButton *deleteKeyword;
@property (nonatomic, strong) UIView *bottomSplitLine;

@end


@implementation PLHHistoryHeaderView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self addComponents]; // 构造主界面
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self layoutComponents]; // 布局主界面
}

#pragma mark - Private Methods

- (void)addComponents {
    
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.deleteKeyword];
    [self addSubview:self.topSplitLine];
    [self addSubview:self.headerTitleLabel];
    [self addSubview:self.bottomSplitLine];
}

- (void)layoutComponents
{
    [self.topSplitLine mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self).with.offset(2);
        make.width.equalTo(self);
        make.height.equalTo(@(1));
        make.left.equalTo(self);
    }];
    
    [self.headerTitleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self).offset(20);
        make.width.equalTo(@(100));
        make.height.equalTo(@(30));
        make.top.equalTo(self).offset(10);
    }];
    [self.deleteKeyword mas_makeConstraints:^(MASConstraintMaker *make){
        make.right.equalTo(self.mas_right).offset(-30);
        make.top.equalTo(self.topSplitLine.mas_top).offset(10);
        make.height.equalTo(@(25));
        make.width.equalTo(@(25));
    }];
    
    [self.bottomSplitLine mas_makeConstraints:^(MASConstraintMaker *make){
        make.bottom.equalTo(self.mas_bottom);
        make.width.equalTo(self);
        make.height.equalTo(@(1));
        make.left.equalTo(self);
    }];
}


#pragma mark - Delegate Methods

#pragma mark - Setter Methods

#pragma mark - Getter Methods

- (UIView *)topSplitLine {
    if (!_topSplitLine) {
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor grayColor];
        _topSplitLine = view;
    }
    return _topSplitLine;
}

- (UILabel *)headerTitleLabel {
    if (!_headerTitleLabel) {
        UILabel *label = [UILabel new];
        label.text = @"搜索历史";
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = [UIColor blackColor];
        
        _headerTitleLabel = label;
    }
    return _headerTitleLabel;
}

- (UIView *)bottomSplitLine {
    if (!_bottomSplitLine) {
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor grayColor];
        _bottomSplitLine = view;
    }
    return _bottomSplitLine;
}

-(UIButton *)deleteKeyword{
    if (!_deleteKeyword) {
        _deleteKeyword = [UIButton new];
        [_deleteKeyword addTarget:self action:@selector(deleteBtnAction) forControlEvents:UIControlEventTouchUpInside];
        [_deleteKeyword setImage:[UIImage imageNamed:@"his_Btn.png"] forState:UIControlStateNormal];
    }
    return _deleteKeyword;
}

#pragma mark - Event Response Methods

- (void)deleteBtnAction {
    if ([_delegate respondsToSelector:@selector(clickhistoryAllDeleteDelegate)]) {
        [_delegate clickhistoryAllDeleteDelegate];
    }
}

#pragma mark - Memory Management Methods

- (void)dealloc {
}

@end

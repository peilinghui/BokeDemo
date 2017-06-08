//
//  PLHHistoryTableViewCell.m
//  示例Table
//
//  Created by peilinghui on 2017/6/8.
//  Copyright © 2017年 peilinghui. All rights reserved.
//

#import "PLHHistoryTableViewCell.h"

@implementation PLHHistoryTableViewCell

-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor colorWithWhite:.9 alpha:1];
    }
    return _lineView;
}

-(UILabel *)strLab{
    if (!_strLab) {
        _strLab = [UILabel new];
        _strLab.textColor = [UIColor colorWithWhite:.5 alpha:1];
        _strLab.textAlignment = NSTextAlignmentLeft;
        _strLab.font = [UIFont systemFontOfSize:14.5];
    }
    return _strLab;
}

-(UIButton *)deleteKeyword{
    if (!_deleteKeyword) {
        _deleteKeyword = [UIButton new];
        [_deleteKeyword addTarget:self action:@selector(deleteKeywordClick) forControlEvents:UIControlEventTouchUpInside];
        _deleteKeyword.contentMode = UIViewContentModeCenter;
        [_deleteKeyword setImage:[UIImage imageNamed:@"search_delete.png"]
                        forState:UIControlStateNormal];
    }
    return _deleteKeyword;
}

-(void)deleteKeywordClick{
    if ([_delegate respondsToSelector:@selector(onDelHistoryCellRecord:)]) {
        [_delegate onDelHistoryCellRecord:self];
    }
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.deleteKeyword];
    [self.contentView addSubview:self.strLab];
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    _deleteKeyword.frame = CGRectMake(self.frame.size.width - self.frame.size.height- 15, 0, self.frame.size.height, self.frame.size.height);
    UIImageView *imgv = [_deleteKeyword viewWithTag:9580];
    imgv.frame = CGRectMake((self.frame.size.height - 20)/2, (self.frame.size.height - 20)/2, 20, 20);
    _strLab.frame = CGRectMake(20, (self.frame.size.height - 30)/2, self.frame.size.width - 60, 30);
    _lineView.frame = CGRectMake(0, self.frame.size.height - 1, self.frame.size.width, 1);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end

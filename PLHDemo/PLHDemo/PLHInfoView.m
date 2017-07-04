//
//  PLHInfoView.m
//  PLHDemo
//
//  Created by peilinghui on 2017/7/3.
//  Copyright © 2017年 user. All rights reserved.
//

#import "PLHInfoView.h"
#import <Masonry/Masonry.h>
@interface  PLHInfoView()


@property (nonatomic, strong) UILabel *titlelb;

@property (nonatomic, strong) UILabel *midlb;

@property (nonatomic, strong) UILabel *leftlb;

@property (nonatomic, strong) UILabel *rightlb;

@end
@implementation PLHInfoView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    self.backgroundColor = [UIColor redColor];
    
    if (self) {
        [self addSubview:self.titlelb];
        self.titlelb.text =@"销售额";
        self.titlelb.textColor = [UIColor blackColor];
        [self.titlelb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(10);
            make.centerX.equalTo(self);
            make.width.equalTo(@(40));
            make.height.equalTo(@(20));
        }];
        
        [self addSubview:self.midlb];
        self.midlb.text = @"116.2万";
        [self.midlb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titlelb.mas_bottom).with.offset(3);
            make.centerX.equalTo(self);
            make.width.equalTo(@(45));
            make.height.equalTo(@(20));
        }];
        
        [self addSubview:self.leftlb];
        self.leftlb.text = @"昨日";
        [self.leftlb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.midlb.mas_bottom).with.offset(5);
            make.leading.equalTo(self).offset(8);
            make.width.equalTo(@30);
            make.height.equalTo(@(20));
        }];
        
        [self addSubview:self.rightlb];
        self.rightlb.text =@"218万";
        [self.rightlb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.midlb.mas_bottom).with.offset(5);
            make.trailing.equalTo(self).offset(-10);
            make.width.equalTo(@35);
            make.height.equalTo(@(20));
        }];

    }
    return self;
}
#pragma mark -- Getters && Setters --


- (UILabel *)titlelb
{
    if (!_titlelb) {
        _titlelb = [[UILabel alloc] initWithFrame:CGRectZero];
        _titlelb.font = [UIFont systemFontOfSize:11];
        _titlelb.textColor = [UIColor blackColor];
        _titlelb.textAlignment = NSTextAlignmentCenter;
    }
    
    return _titlelb;
}

- (UILabel *)midlb
{
    if (!_midlb) {
        _midlb = [[UILabel alloc] initWithFrame:CGRectZero];
        _midlb.font = [UIFont systemFontOfSize:11];
        _midlb.textColor =[UIColor blackColor];
        _midlb.textAlignment = NSTextAlignmentCenter;
        
    }
    
    return _midlb;
}



- (UILabel *)leftlb
{
    if (!_leftlb) {
        _leftlb = [[UILabel alloc] initWithFrame:CGRectZero];
        _leftlb.font = [UIFont systemFontOfSize:11];
        _leftlb.textColor = [UIColor blackColor];
    }
    
    return _leftlb;
}

- (UILabel *)rightlb
{
    if (!_rightlb) {
        _rightlb = [[UILabel alloc] initWithFrame:CGRectZero];
        _rightlb.font = [UIFont systemFontOfSize:11];
        _rightlb.textColor = [UIColor blackColor];
        
    }
    
    return _rightlb;
}


@end

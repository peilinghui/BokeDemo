//
//  PLHSearchCollectionViewCell.m
//  示例Table
//
//  Created by peilinghui on 2017/6/10.
//  Copyright © 2017年 peilinghui. All rights reserved.
//

#import "PLHSearchCollectionViewCell.h"
#import <Masonry.h>
@implementation PLHSearchCollectionViewCell

+ (CGSize) getSizeWithText:(NSString*)text;
{
    NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc] init];
    style.lineBreakMode = NSLineBreakByCharWrapping;
    CGSize size = [text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 24) options: NSStringDrawingUsesLineFragmentOrigin   attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0f],NSParagraphStyleAttributeName:style} context:nil].size;
    return CGSizeMake(size.width+20, 24);
}


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.contentButton];
        [self.maskView mas_makeConstraints:^(MASConstraintMaker *make){
            make.right.equalTo(self.contentView.mas_right);
            make.left.equalTo(self.contentView.mas_left);
            make.top.equalTo(self.contentView.mas_top);
            make.bottom.equalTo(self.contentView.mas_bottom);
        }];
    }
    return self;
}

-(UIButton *)contentButton{
    if (_contentButton) {
        _contentButton = [[UIButton alloc]init];
        _contentButton = [UIButton buttonWithType:UIButtonTypeCustom];
         [_contentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_contentButton.layer setMasksToBounds:YES];
        [_contentButton.layer setCornerRadius:12.0];
        [_contentButton setBackgroundColor:[UIColor colorWithWhite:0.957 alpha:1.000]];
        [_contentButton addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _contentButton;
}
-(void)clickBtn{
    if ([self.selectDelegate respondsToSelector:@selector(selectButttonClick:)]) {
        [self.selectDelegate selectButttonClick:self];
    }
}
@end

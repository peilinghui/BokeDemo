//
//  SelectCollectionReusableView.h
//  示例Table
//
//  Created by peilinghui on 2017/6/9.
//  Copyright © 2017年 peilinghui. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SelectCollectionReusableView;

@protocol UICollectionReusableViewButtonDelegate <NSObject>

-(void)delectData:(SelectCollectionReusableView *)view;

@end


@interface SelectCollectionReusableView : UICollectionReusableView

@property(nonatomic,weak) UIButton *delectButton;
@property (nonatomic,weak)id<UICollectionReusableViewButtonDelegate>delectDelegate;

-(void)setText:(NSString *)text;

-(void)setImage:(NSString *)image;

@end

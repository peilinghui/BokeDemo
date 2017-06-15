//
//  PLHSearchCollectionViewCell.h
//  示例Table
//
//  Created by peilinghui on 2017/6/10.
//  Copyright © 2017年 peilinghui. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PLHSearchCollectionViewCell;
@protocol SelectCollectionCellDelegate <NSObject>

-(void)selectButtonClick:(PLHSearchCollectionViewCell *)cell;

@end
@interface PLHSearchCollectionViewCell : UICollectionViewCell


@property(nonatomic,strong)UIButton *contentButton;
@property(nonatomic,weak)id<SelectCollectionCellDelegate>selectDelegate;

+(CGSize)getSizeWithText:(NSString *)text;
@end

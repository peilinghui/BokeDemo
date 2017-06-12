//
//  SelectCollectionLayout.m
//  示例Table
//
//  Created by peilinghui on 2017/6/9.
//  Copyright © 2017年 peilinghui. All rights reserved.
//

#import "SelectCollectionLayout.h"

@implementation SelectCollectionLayout


-(instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}

-(void)prepareLayout{
    [super prepareLayout];
    
    self.sectionInset = UIEdgeInsetsMake(25, 0, 0, 0);
    self.headerReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width,25 );
    self.minimumInteritemSpacing =15;
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect )rect{
    
    NSMutableArray *attributes = [[super layoutAttributesForElementsInRect:rect]mutableCopy];
    for (int i = 1; i <[attributes count]; i++) {
        //当前的attribute
        UICollectionViewLayoutAttributes *currentLayoutAttributes =attributes[i];
        
        //上一个Attritbute
        UICollectionViewLayoutAttributes *prevLayoutAttritbutes =attributes[i - 1];
        
        if (prevLayoutAttritbutes.indexPath.section == currentLayoutAttributes.indexPath.section) {
            //我们想设置的最大间距
            NSInteger maximumSpacing =15;
            //前一个cell的最右边
            NSInteger origin = CGRectGetMaxX(prevLayoutAttritbutes.frame);
            //如果当前的一个cell的最右边+我们想要的间距+当前cell的宽度依然在contentSize中，我们改变当前cell的原点位置
            //不加这个判断的结果是：UICollectionView只显示一行，原因是下面所有的cell的x值都被加到第一行最后一个元素的后面了
            if ((origin +maximumSpacing +currentLayoutAttributes.frame.size.width) < self.collectionViewContentSize.width) {
                CGRect frame = currentLayoutAttributes.frame;
                frame.origin.x = origin +maximumSpacing;
                currentLayoutAttributes.frame = frame;
            }
            
        }
    }
    return attributes;
}

@end

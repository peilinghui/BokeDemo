//
//  SecondViewController.m
//  FrameAndBoundsDemo
//
//  Created by peilinghui on 2017/4/22.
//  Copyright © 2017年 peilinghui. All rights reserved.
//

#import "SecondViewController.h"

//获取屏幕 宽度、高度
#define SCREEN_FRAME ([UIScreen mainScreen].bounds)
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
@interface SecondViewController ()
@property(nonatomic,strong)UIImageView *imageview;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    
    
    [self.view addSubview:self.scrollView];
    
    
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled=YES;
    self.scrollView.bounces = YES;
    self.scrollView.scrollEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
  
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*2, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [imageView setUserInteractionEnabled:true];
    [imageView setImage:[UIImage imageNamed:@"1"]];

    self.scrollView.contentSize = imageView.frame.size;
    [self.scrollView addSubview:imageView];
    
    
}


#pragma mark--UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"scrollview[contentoffset:%@---frame:%@------bounds:%@",NSStringFromCGPoint(scrollView.contentOffset), NSStringFromCGRect(self.scrollView.frame),NSStringFromCGRect(self.scrollView.bounds));
    NSLog(@"imageview[frame:%@------bounds:%@",NSStringFromCGRect(self.imageview.frame),NSStringFromCGRect(self.imageview.bounds));
}

@end

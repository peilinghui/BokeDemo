//
//  ViewController.m
//  ViewController的生命周期
//
//  Created by peilinghui on 2017/4/10.
//  Copyright © 2017年 peilinghui. All rights reserved.
//

#import "ViewController.h"
#import "ViewControllerB.h"
//获取屏幕 宽度、高度
#define SCREEN_FRAME ([UIScreen mainScreen].bounds)
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface ViewController ()

@end

@implementation ViewController


////加载视图
//-(void)loadView{
//    NSLog(@"第一个页面的loadView");
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(80, SCREEN_HEIGHT-70, 160, 40)];
    [btn addTarget:self action:@selector(showViewController:sender:) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundColor:[UIColor blueColor]];
    [btn setTitle:@"跳转下一个页面"  forState:UIControlStateNormal];
    btn.clipsToBounds = YES;
    btn.layer.cornerRadius = 4;
    [self.view addSubview:btn];
    NSLog(@"第一个页面的viewDidLoad");
}


-(void)showViewController:(UIViewController *)vc sender:(id)sender{
    ViewControllerB *vb=[[ViewControllerB alloc]init];
    [self presentViewController:vb animated:YES completion:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"第一个页面的viewWillAppear");
}

-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"第一个页面的viewDidAppear");
}

-(void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"第一个页面的viewWillDisappear");
}


-(void)viewDidDisappear:(BOOL)animated{
    NSLog(@"第一个页面的viewDidDisappear");
}

-(void)viewDidUnload{
    NSLog(@"第一个页面的viewDidUnload");
}
@end

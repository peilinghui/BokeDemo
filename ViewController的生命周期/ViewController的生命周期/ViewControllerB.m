//
//  ViewControllerB.m
//  ViewController的生命周期
//
//  Created by peilinghui on 2017/4/10.
//  Copyright © 2017年 peilinghui. All rights reserved.
//

#import "ViewControllerB.h"
#import "ViewController.h"
//获取屏幕 宽度、高度
#define SCREEN_FRAME ([UIScreen mainScreen].bounds)
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface ViewControllerB ()

@end

@implementation ViewControllerB

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(80, SCREEN_HEIGHT-70, 160, 40)];
    [btn addTarget:self action:@selector(showViewController:sender:) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundColor:[UIColor brownColor]];
    [btn setTitle:@"回上一个页面"  forState:UIControlStateNormal];
    btn.clipsToBounds = YES;
    btn.layer.cornerRadius = 4;
    [self.view addSubview:btn];
    NSLog(@"第二个页面的viewDidLoad");
}


-(void)showViewController:(UIViewController *)vc sender:(id)sender{
    ViewController *vc1=[[ViewController alloc]init];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"第二个页面的viewWillAppear");
}

-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"第二个页面的viewDidAppear");
}

-(void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"第二个页面的viewWillDisappear");
}


-(void)viewDidDisappear:(BOOL)animated{
    NSLog(@"第二个页面的viewDidDisappear");
}

-(void)viewDidUnload{
    NSLog(@"第二个页面的viewDidUnload");
}

@end

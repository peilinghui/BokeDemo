//
//  PerformSelectorThreadViewController.m
//  PLHPerformDemo
//
//  Created by peilinghui on 2017/4/16.
//  Copyright © 2017年 peilinghui. All rights reserved.
//

#import "PerformSelectorThreadViewController.h"

@interface PerformSelectorThreadViewController ()

@end

@implementation PerformSelectorThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIButton *firstBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 100, 120, 50)];
    [firstBtn setTitle:@"InBackground" forState:UIControlStateNormal];
    [firstBtn setBackgroundColor:[UIColor blueColor]];
    firstBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [firstBtn addTarget:self action:@selector(InBackgroundClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:firstBtn];
    
    
    UIButton *secondBtn = [[UIButton alloc]initWithFrame:CGRectMake(170, 100, 120, 50)];
    [secondBtn setTitle:@"OnMainThread YES" forState:UIControlStateNormal];
    [secondBtn setBackgroundColor:[UIColor blueColor]];
    secondBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [secondBtn addTarget:self action:@selector(OnMainThreadWaitYesClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:secondBtn];
    
    UIButton *thirdBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 180, 120, 50)];
    [thirdBtn setTitle:@"OnMainThread NO" forState:UIControlStateNormal];
    [thirdBtn setBackgroundColor:[UIColor blueColor]];
    thirdBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [thirdBtn addTarget:self action:@selector(OnMainThreadWaitNoClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:thirdBtn];
    
    UIButton *forthBtn = [[UIButton alloc]initWithFrame:CGRectMake(170, 180, 120, 50)];
    [forthBtn setTitle:@"Simple" forState:UIControlStateNormal];
    [forthBtn setBackgroundColor:[UIColor blueColor]];
    forthBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [forthBtn addTarget:self action:@selector(SimpleClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forthBtn];

    UIButton *fifthBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 250, 120, 50)];
    [fifthBtn setTitle:@"Simple delay" forState:UIControlStateNormal];
    [fifthBtn setBackgroundColor:[UIColor redColor]];
    fifthBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [fifthBtn addTarget:self action:@selector(SimpleDelayClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fifthBtn];


}

#pragma mark --Click 事件
-(void)InBackgroundClick{
    [self performSelectorInBackground:@selector(delayMethod) withObject:nil];
    NSLog(@"在NSThread中performselector在后台开始调用");
    sleep(5);
    NSLog(@"在NSThread中performselector在后台结束调用");
}

-(void)OnMainThreadWaitYesClick{
    [self performSelectorOnMainThread:@selector(delayMethod) withObject:nil waitUntilDone:YES];
    NSLog(@"在NSThread中performselector在主线程调用wait为YES开始调用方法");
    sleep(5);
    NSLog(@"在NSThread中performselector在主线程调用wait为YES结束调用方法");
}

-(void)OnMainThreadWaitNoClick{
    [self performSelectorOnMainThread:@selector(delayMethod) withObject:nil waitUntilDone:NO];
    NSLog(@"在NSThread中performselector在主线程调用wait为NO开始调用方法");
    sleep(5);
    NSLog(@"在NSThread中performselector在主线程调用wait为NO结束调用方法");
}

-(void)SimpleClick{
    [self performSelector:@selector(delayMethod) withObject:nil];
    NSLog(@"简单的调用开始");
    sleep(5);
    NSLog(@"简单的调用结束");
}

-(void)SimpleDelayClick{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self performSelector:@selector(delayMethod) withObject:nil];
    });
    NSLog(@"在GCD主线程延时执行selector方法开始调用");
    sleep(5);
    NSLog(@"在GCD主线程延时执行selector方法结束调用");
}

#pragma mark -delayMethod
-(void)delayMethod
{
    NSLog(@"执行selector方法");
}
@end

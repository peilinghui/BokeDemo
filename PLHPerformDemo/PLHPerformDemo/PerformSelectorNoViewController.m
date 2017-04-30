//
//  PerformSelectorNoViewController.m
//  PLHPerformDemo
//
//  Created by peilinghui on 2017/4/16.
//  Copyright © 2017年 peilinghui. All rights reserved.
//

#import "PerformSelectorNoViewController.h"

@interface PerformSelectorNoViewController ()

@end

@implementation PerformSelectorNoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIButton *firstBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 100, 120, 50)];
    [firstBtn setTitle:@"No afterDelay" forState:UIControlStateNormal];
    [firstBtn setBackgroundColor:[UIColor blueColor]];
    firstBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [firstBtn addTarget:self action:@selector(NoAfterDelayClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:firstBtn];
    
    
    UIButton *secondBtn = [[UIButton alloc]initWithFrame:CGRectMake(170, 100, 120, 50)];
    [secondBtn setTitle:@"AfterDelay" forState:UIControlStateNormal];
    [secondBtn setBackgroundColor:[UIColor blueColor]];
    secondBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [secondBtn addTarget:self action:@selector(AfterDelayClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:secondBtn];
    
    UIButton *thirdBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 180, 120, 50)];
    [thirdBtn setTitle:@"AfterDelay Runloop" forState:UIControlStateNormal];
    [thirdBtn setBackgroundColor:[UIColor blueColor]];
    thirdBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [thirdBtn addTarget:self action:@selector(AfterDelayRunloopClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:thirdBtn];
    
    UIButton *forthBtn = [[UIButton alloc]initWithFrame:CGRectMake(170, 180, 120, 50)];
    [forthBtn setTitle:@"dispatch_after" forState:UIControlStateNormal];
    [forthBtn setBackgroundColor:[UIColor blueColor]];
    forthBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [forthBtn addTarget:self action:@selector(dispatchAfterClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forthBtn];

    UIButton *fifthBtn = [[UIButton alloc]initWithFrame:CGRectMake(20, 250, 120, 50)];
    [fifthBtn setTitle:@"RunloopMode" forState:UIControlStateNormal];
    [fifthBtn setBackgroundColor:[UIColor redColor]];
    fifthBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [fifthBtn addTarget:self action:@selector(RunloopModeClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:fifthBtn];
}

#pragma mark --点击
-(void)NoAfterDelayClick{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self performSelector:@selector(delayMethod) withObject:nil];
    });
    NSLog(@"异步全局队列子线程中无延迟调用selector方法开始");
    sleep(5);
    NSLog(@"异步全局队列子线程中无延迟调用selector方法结束");
}


-(void)AfterDelayClick{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self performSelector:@selector(delayMethod) withObject:nil afterDelay:0];
    });
    NSLog(@"异步全局队列中有延迟未开启NSRunLoop中selector方法开始");
    sleep(5);
    NSLog(@"异步全局队列中有延迟未开启NSRunLoop中selector方法开始");
}

-(void)AfterDelayRunloopClick{

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self performSelector:@selector(delayMethod) withObject:nil afterDelay:0];
        
        
        [[NSRunLoop currentRunLoop]run];
        NSLog(@"异步全局队列中有延迟开启NSRunLoop中selector方法开始");
        sleep(5);
        NSLog(@"异步全局队列中有延迟开启NSRunLoop中selector方法开始");
    });
   
}

-(void)dispatchAfterClick{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_global_queue(0,0), ^{
            if ([self respondsToSelector:@selector(delayMethod)]) {
                [self performSelector:@selector(delayMethod) withObject:nil];
            }
        });
        NSLog(@"异步全局队列中判断后调用selector开始");
        sleep(5);
        NSLog(@"异步全局队列中判断后调用selector结束");
    });
}

-(void)RunloopModeClick{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self performSelector:@selector(delayMethod) withObject:nil afterDelay:0 inModes:@[NSDefaultRunLoopMode, UITrackingRunLoopMode]];
    
        });
    NSLog(@"异步全局队列中有延迟开启NSRunLoop中selector方法开始");
    sleep(5);
    NSLog(@"异步全局队列中有延迟开启NSRunLoop中selector方法开始");

}
- (void)delayMethod
{
    NSLog(@"执行延迟方法");
}

@end

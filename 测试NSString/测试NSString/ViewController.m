//
//  ViewController.m
//  测试NSString
//
//  Created by peilinghui on 2017/4/10.
//  Copyright © 2017年 peilinghui. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:3];
    NSMutableString *mutStr1 = [[NSMutableString alloc]initWithString:@"123"];
    NSLog(@"新建mutStr1: %ld", mutStr1.retainCount);
    
    [array addObject:mutStr1];
    NSLog(@"添加一个元素mutStr1: %ld", mutStr1.retainCount);
    [array addObject:mutStr1];
    NSLog(@"添加两个元素后mutStr1: %ld", mutStr1.retainCount);
    [array removeObjectAtIndex:0];
    NSLog(@"移除一个元素后mutStr1: %ld", mutStr1.retainCount);
    
    
    NSString *str1 = @"123";
    NSLog(@"str1: %ld", str1.retainCount);
    NSLog(@"str1: %@", [str1 class]);
    NSLog(@"str1 addr is %p",str1); // 你会发现str1与str2两个指针指向了同一个内存
   
    
    NSString  *str2 = str1;
    NSLog(@"str2:  %ld", str2.retainCount);
    NSLog(@"str2: %@", [str2 class]);
    NSLog(@"str2 addr is %p",str2);
 
    NSString *buffer1 = @"hello world!";
    NSLog(@"buffer1: %ld",[buffer1 retainCount]);
    NSLog(@"buffer1: %@", [buffer1 class]);
    NSLog(@"buffer1 addr is %p",buffer1);
 
    
    NSString *buffer2 = [NSString stringWithFormat:@"hello world!"];
    NSLog(@"buffer2: %ld",[buffer2 retainCount]);
    NSLog(@"buffer2: %@", [buffer2 class]);
    NSLog(@"buffer2 addr is %p",buffer2);
    
    NSString *buffer3 = [NSString stringWithFormat:@"hello"];
    NSLog(@"buffer3: %ld",[buffer3 retainCount]);
    NSLog(@"buffer3: %@", [buffer3 class]);
    NSLog(@"buffer3 addr is %p",buffer3);
    
    NSString *buffer4 = [NSString stringWithString:buffer2];
    NSLog(@"buffer4: %ld",[buffer4 retainCount]);
    NSLog(@"buffer4: %@", [buffer4 class]);
    NSLog(@"buffer4 addr is %p",buffer4);
    
    NSString *buffer5= [NSString stringWithString:buffer3];
    NSLog(@"buffer5: %ld",[buffer5 retainCount]);
    NSLog(@"buffer5: %@", [buffer5 class]);
    NSLog(@"buffer5 addr is %p",buffer5);
   }


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

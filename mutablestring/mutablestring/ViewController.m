//
//  ViewController.m
//  mutablestring
//
//  Created by peilinghui on 2017/3/17.
//  Copyright © 2017年 peilinghui. All rights reserved.
//

#import "ViewController.h"
#import "NSDictionary+MutableDeepCopy.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


        NSMutableArray *arr1=[[NSMutableArray alloc] initWithObjects:@"aa",@"bb",@"cc", nil];
        NSDictionary *dict1=[[NSDictionary alloc] initWithObjectsAndKeys:arr1,@"arr1", nil];
        NSLog(@"%@",dict1);
        NSMutableDictionary *dict2=[dict1 mutableCopy];
        //浅复制
        NSMutableDictionary *dict3=[dict1 mutableDeepCopy];
        //深复制
        [arr1 addObject:@"dd"];
        NSLog(@"%@",dict2);
        NSLog(@"%@",dict3);
        
  
}



@end

//
//  ViewController.m
//  PLHAFNDemo
//
//  Created by peilinghui on 2017/7/11.
//  Copyright © 2017年 peilinghui. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>
#import "PLHLoginService.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self sendGet];
}

-(void)sendGet
{
    
    //如何使用NSURLSession
    // 1.得到session对象
    NSURLSession *session = [NSURLSession sharedSession];
    
    // 2.创建一个task，任务
    //    NSURL *url = [NSURL URLWithString:@"http://。。。/Server/video"];
    //    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    //        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    //        NSLog(@"----%@", dict);
    //    }];
    
    NSURL *url = [NSURL URLWithString:@"http://。。。/Server/login"];
    // 创建一个请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    // 设置请求体
    request.HTTPBody = [@"username=123&pwd=123" dataUsingEncoding:NSUTF8StringEncoding];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //系统的解析方法
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"----%@", dict);
    }];
    // 3.开始任务
    [task resume];

    
    //如何使用AFN
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
     manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //调用AFNHTTPSession中的GET方法
    [manager GET:@"https://www.baidu.com" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    }success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             //请求返回的数据(二进制数据)
             NSLog(@"responseObject(二进制) = %@",responseObject);
             //转化二进制数据
            NSLog(@"responseObject = %@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull   error) {
             NSLog(@"%@",error);  //这里打印错误信息
             
         }];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

//
//  PLHJSCoreViewController.m
//  PLHWebViewDemo
//
//  Created by peilinghui on 2017/5/10.
//  Copyright © 2017年 peilinghui. All rights reserved.
//

#import "PLHJSCoreViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface PLHJSCoreViewController ()<UIWebViewDelegate,JSExport>

@property(nonatomic,strong)JSContext *jsContext;
@property(nonatomic,strong)UIWebView *webView;
@end

@implementation PLHJSCoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.webView.delegate = self;

    NSString* path = [[NSBundle mainBundle] pathForResource:@"JSCoreDemoText" ofType:@"html"];
    NSURL* url = [NSURL fileURLWithPath:path];
    NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
    [self.webView loadRequest:request];
    
    [self.view addSubview:self.webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --UIWebViewDelegate
-(void)webViewDidStartLoad:(UIWebView *)webView{
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
   self.jsContext[@"huihui"] = self;
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
        NSLog(@"异常信息：%@", exceptionValue);
    };

}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}

-(void)call{
    NSLog(@"根据JS的名字回调");
    // 之后在回调js的方法Callback把内容传出去
    JSValue *Callback = self.jsContext[@"Callback"];
    //传值给web端
    [Callback callWithArguments:@[@"唤起本地OC回调完成"]];
}

- (void)getCall:(NSString *)callString{
    NSLog(@"Get:%@", callString);
    // 成功回调js的方法Callback
    JSValue *Callback = self.jsContext[@"alertFunc"];
    [Callback callWithArguments:nil];
    
    //    直接添加提示框
    //    NSString *str = @"alert('OC添加JS提示成功')";
    //    [self.jsContext evaluateScript:str];
    
}

@end

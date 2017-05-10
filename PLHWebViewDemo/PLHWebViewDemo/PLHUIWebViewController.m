//
//  PLHUIWebViewController.m
//  PLHWebViewDemo
//
//  Created by peilinghui on 2017/5/8.
//  Copyright © 2017年 peilinghui. All rights reserved.
//

#import "PLHUIWebViewController.h"
#import <WebKit/WebKit.h>

@interface PLHUIWebViewController ()<UIWebViewDelegate>

@property(nonatomic,strong)UIWebView *webView;
@end

@implementation PLHUIWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    self.webView.delegate = self;
//    NSURL *htmlURL = [[NSBundle mainBundle] URLForResource:@"JSDemo.html" withExtension:nil];
//    NSURLRequest *request = [NSURLRequest requestWithURL:htmlURL];
//        [self.webView loadRequest:request];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
    // 如果不想要webView 的回弹效果
    self.webView.scrollView.bounces = NO;
    // UIWebView 滚动的比较慢，这里设置为正常速度
    self.webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    [self.view addSubview:self.webView];

}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *urlString = [[request URL] absoluteString];
    urlString = [urlString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSArray *urlComps = [urlString componentsSeparatedByString:@"://"];
    NSLog(@"urlString=%@---urlComps=%@",urlString,urlComps);
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    NSURLRequest *request = webView.request;
     NSLog(@"webViewDidStartLoad-url=%@--%@",[request URL],[request HTTPBody]);
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
        NSLog(@"%s", __FUNCTION__);
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
        NSLog(@"%s", __FUNCTION__);
}
#pragma mark - private method
- (void)handleCustomAction:(NSURL *)URL
{
    NSString *host = [URL host];
    if ([host isEqualToString:@"getLocation"]) {
        [self getLocation];
    }
}

- (void)getLocation
{
    // 获取位置信息
    //......
    // 将结果返回给JS
    // 将被调用的JS的函数名和参数写入字符串
    NSString *jsStr = [NSString stringWithFormat:@"setLocation('%@')",@"myNewLocation"];
    //回调JS代码
    [self.webView stringByEvaluatingJavaScriptFromString:jsStr];
}

@end

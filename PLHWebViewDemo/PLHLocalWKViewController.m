//
//  PLHLocalWKViewController.m
//  PLHWebViewDemo
//
//  Created by peilinghui on 2017/5/9.
//  Copyright © 2017年 peilinghui. All rights reserved.
//

#import "PLHLocalWKViewController.h"
#import <WebKit/WebKit.h>
//#import "WKDelegateController.h"
#import "WeakScriptMessageDelegate.h"
@interface PLHLocalWKViewController ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>

@property (nonatomic, strong) WKWebView *webView;
@property(nonatomic,strong)WKUserContentController* userContentController;
@end

@implementation PLHLocalWKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = [WKUserContentController new];
    
  //  [configuration.userContentController addScriptMessageHandler:self name:@"myHandler"];
    
    [configuration.userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:@"myHandler"];
    
    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    preferences.minimumFontSize = 40.0;
    configuration.preferences = preferences;
    

    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;

//        // 1.获取url
//        NSURL *url = [NSURL fileURLWithPath:@"http://localhost/a/mywork.html"];
//        // 2.创建请求
//        NSURLRequest *request=[NSURLRequest requestWithURL:url];
//        // 3.加载请求
//        [self.webView loadRequest:request];
      [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://localhost/a/mywork.html"]]];
    
//    NSURL *url = [NSURL fileURLWithPath:@"/Library/WebServer/Documents/a/mywork.html"];
//    // 加载文件
//    [_webView loadFileURL:url allowingReadAccessToURL:url];
    
    // 最后将webView添加到界面
    [self.view addSubview:_webView];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - < WKNavigationDelegate >

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"did start provisional navigation");
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    
    NSLog(@"did fail provisionna");
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"did commit navigation..");
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    NSLog(@"did finish navigation");
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    
    NSLog(@"dif fail navigation..");
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"receive..");
}

- (void)webView:(WKWebView *)webView
decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse
decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    
    decisionHandler(WKNavigationResponsePolicyAllow);
}

- (void)webView:(WKWebView *)webView
decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction
decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    decisionHandler(WKNavigationActionPolicyAllow);
}

#pragma mark - < WKUIDelegate >

#pragma mark - < WKScriptMessageHandler >

#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    //    message.body  --  Allowed types are NSNumber, NSString, NSDate, NSArray,NSDictionary, and NSNull.
    if ([message.name isEqualToString:@"myHandler"]) {
        NSLog(@"%@",message.body);

    }
}

//- (void)dealloc {
//    NSLog(@"%@", NSStringFromSelector(_cmd));
//}

//- (void)dealloc{
//    
//    [_userContentController removeScriptMessageHandlerForName:@"myHandler"];
//
//}
- (void)dealloc {
    [self.userContentController removeScriptMessageHandlerForName:@"myHandler"];
}


@end

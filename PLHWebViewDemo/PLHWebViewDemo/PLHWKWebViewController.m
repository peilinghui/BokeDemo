//
//  PLHJSViewController.m
//  PLHWebViewDemo
//
//  Created by peilinghui on 2017/5/6.
//  Copyright © 2017年 peilinghui. All rights reserved.
//

#import "PLHWKWebViewController.h"
#import <WebKit/WebKit.h>
#import <Masonry/Masonry.h>
@interface PLHWKWebViewController ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>

@property(nonatomic,strong)WKUserContentController* userContentController;
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;
@end

@implementation PLHWKWebViewController

#pragma mark - lifeCircle
- (void)viewDidLoad {
    [super viewDidLoad];
    
#pragma mark --创建配置类
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
#pragma mark --配置偏好设置
    // 设置偏好设置
    config.preferences = [[WKPreferences alloc] init];
    // 默认为0
    config.preferences.minimumFontSize = 10;
    // 默认认为YES
    config.preferences.javaScriptEnabled = YES;
    // 在iOS上默认为NO，表示不能自动通过窗口打开
    config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
    
#pragma mark --配置web内容处理池,web内容处理池，由于没有属性可以设置，也没有方法可以调用，不用手动创建.
    // web内容处理池
    config.processPool = [[WKProcessPool alloc] init];
    
#pragma mark --配置Js与Web内容交互,WKUserContentController是用于给JS注入对象的，注入对象后，
    //JS端就可以使用：window.webkit.messageHandlers.<name>.postMessage(<messageBody>)
    // 通过JS与webview内容交互
    config.userContentController = [[WKUserContentController alloc] init];
    // 注入JS对象名称AppModel，当JS通过AppModel来调用时，
    // 我们可以在WKScriptMessageHandler代理中接收到
    [config.userContentController addScriptMessageHandler:self name:@"AppModel"];
    
    
#pragma mark --创建WKWebView
    
    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    [self.view addSubview:_webView];
    
#pragma mark --加载本地H5页面
    NSURL *path = [[NSBundle mainBundle] URLForResource:@"JSDemo" withExtension:@"html"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:path]];
    [self.view addSubview:self.webView];
    

    
#pragma mark --配置代理
    // 导航代理
    self.webView.navigationDelegate = self;
    // 与webview UI交互代理
    self.webView.UIDelegate = self;
    
#pragma mrk --添加对WKWebView属性的监听
    // 添加KVO监听
    [self.webView addObserver:self
                   forKeyPath:@"loading"
                      options:NSKeyValueObservingOptionNew
                      context:nil];
    [self.webView addObserver:self
                   forKeyPath:@"title"
                      options:NSKeyValueObservingOptionNew
                      context:nil];
    [self.webView addObserver:self
                   forKeyPath:@"estimatedProgress"
                      options:NSKeyValueObservingOptionNew
                      context:nil];
    
    // 添加进入条
    self.progressView = [[UIProgressView alloc] init];
    self.progressView.frame = self.view.bounds;
    [self.view addSubview:self.progressView];
    self.progressView.backgroundColor = [UIColor redColor];
    
    //    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"后退" style:UIBarButtonItemStyleDone target:self action:@selector(goback)];
    //    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"前进" style:UIBarButtonItemStyleDone target:self action:@selector(gofarward)];
}

//- (void)goback {
//    if ([self.webView canGoBack]) {
//        [self.webView goBack];
//    }
//}
//
//- (void)gofarward {
//    if ([self.webView canGoForward]) {
//        [self.webView goForward];
//    }
//}


- (void)dealloc{
    //这里需要注意，前面增加过的方法一定要remove掉。
    [_userContentController removeScriptMessageHandlerForName:@"sayhello"];
}



#pragma mark --然后我们就可以实现KVO处理方法，在loading完成时，可以注入一些JS到web中
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context {
    if ([keyPath isEqualToString:@"loading"]) {
        NSLog(@"loading");
    } else if ([keyPath isEqualToString:@"title"]) {
        self.title = self.webView.title;
    } else if ([keyPath isEqualToString:@"estimatedProgress"]) {
        NSLog(@"progress: %f", self.webView.estimatedProgress);
        self.progressView.progress = self.webView.estimatedProgress;
    }
    
    // 加载完成
    if (!self.webView.loading) {
        // 手动调用JS代码
        // 每次页面完成都弹出来，大家可以在测试时再打开
        NSString *js = @"callJsAlert()";
        [self.webView evaluateJavaScript:js completionHandler:^(id _Nullable response, NSError * _Nullable error) {
            NSLog(@"response: %@ error: %@", response, error);
            NSLog(@"call js alert by native");
        }];
        
        [UIView animateWithDuration:0.5 animations:^{
            self.progressView.alpha = 0;
        }];
    }
}

#pragma mark --WKUIDelegate

//与JS原生的alert、confirm、prompt交互，将弹出来的实际上是我们原生的窗口，而不是JS的。在得到数据后，由原生传回到JS：
- (void)webViewDidClose:(WKWebView *)webView {
    NSLog(@"%s", __FUNCTION__);
}

//JS调用alert函数时，会触发此代理，所传数据可以通过message拿到，原生得到结果后，回调JS，是在completionHandler中回调
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    NSLog(@"%s", __FUNCTION__);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"alert" message:@"JS调用alert" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    
    [self presentViewController:alert animated:YES completion:NULL];
    NSLog(@"%@", message);
}

//JS 调用confirm函数的时候，会触发此函数，message可以拿到JS端所传的数据，completionHander回调给JS端
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler {
    NSLog(@"%s", __FUNCTION__);
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"confirm" message:@"JS调用confirm" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }]];
    [self presentViewController:alert animated:YES completion:NULL];
    
    NSLog(@"%@", message);
}

//JS 调用TextInputPanelWithPrompt函数的时候，会触发此代理
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler {
    NSLog(@"%s", __FUNCTION__);
    
    NSLog(@"%@", prompt);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"textinput" message:@"JS调用输入框" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.textColor = [UIColor redColor];
    }];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler([[alert.textFields lastObject] text]);
    }]];
    
    [self presentViewController:alert animated:YES completion:NULL];
}


#pragma mark - WKNavigationDelegate
//请求开始前，会先调用此代理方法
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
//    NSString *hostname = navigationAction.request.URL.host.lowercaseString;
//    if (navigationAction.navigationType == WKNavigationTypeLinkActivated
//        && ![hostname containsString:@".baidu.com"]) {
        // 对于跨域，需要手动跳转
    //    [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
        
//        // 不允许web内跳转
//        decisionHandler(WKNavigationActionPolicyCancel);
//    } else {
      //  self.progressView.alpha = 1.0;
        decisionHandler(WKNavigationActionPolicyAllow);
//    }
    
    NSLog(@"%s", __FUNCTION__);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    decisionHandler(WKNavigationResponsePolicyAllow);
    NSLog(@"%s", __FUNCTION__);
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"%s", __FUNCTION__);
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"%s", __FUNCTION__);
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"%s", __FUNCTION__);
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"%s", __FUNCTION__);
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"%s", __FUNCTION__);
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    
}

//对于HTTPS的都会触发此代理，如果不要求验证，传默认就行，如果需要证书验证，与使用ADN进行HTTPS证书验证是一样的
- (void)webView:(WKWebView *)webView :(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *__nullable credential))completionHandler {
    NSLog(@"%s", __FUNCTION__);
    completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, nil);
}

//web内容处理中断时会触发
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    NSLog(@"%s", __FUNCTION__);
}

#pragma mark - <WKScriptMessageHandler>当JS通过AppModel发送数据到iOS端时，会在代理中收到：
- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([message.name isEqualToString:@"AppModel"]) {
        // 打印所传过来的参数，只支持NSNumber, NSString, NSDate, NSArray,
        // NSDictionary, and NSNull类型
        NSLog(@"%@", message.body);
    }
}

@end

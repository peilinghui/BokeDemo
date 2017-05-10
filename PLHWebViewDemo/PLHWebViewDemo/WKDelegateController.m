//
//  WKDelegateController.m
//  PLHWebViewDemo
//
//  Created by peilinghui on 2017/5/6.
//  Copyright © 2017年 peilinghui. All rights reserved.
//

#import "WKDelegateController.h"

@interface WKDelegateController ()

@end

@implementation WKDelegateController


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    if ([self.delegate respondsToSelector:@selector(userContentController:didReceiveScriptMessage:)]) {
        [self.delegate userContentController:userContentController didReceiveScriptMessage:message];
    }
}

@end

//
//  WeakScriptMessageDelegate.m
//  PLHWebViewDemo
//
//  Created by peilinghui on 2017/5/9.
//  Copyright © 2017年 peilinghui. All rights reserved.
//

#import "WeakScriptMessageDelegate.h"

@implementation WeakScriptMessageDelegate


- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate {
    self = [super init];
    if (self) {
        _scriptDelegate = scriptDelegate;
    }
    return self;
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
    [self.scriptDelegate userContentController:userContentController didReceiveScriptMessage:message];
}

@end

//
//  WKDelegateController.h
//  PLHWebViewDemo
//
//  Created by peilinghui on 2017/5/6.
//  Copyright © 2017年 peilinghui. All rights reserved.
//

#import <WebKit/WebKit.h>

@protocol WKDelegate <NSObject>

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message;

@end

@interface WKDelegateController : UIViewController <WKScriptMessageHandler>

@property (weak , nonatomic) id<WKDelegate> delegate;

@end

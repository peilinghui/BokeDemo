//
//  WeakScriptMessageDelegate.h
//  PLHWebViewDemo
//
//  Created by peilinghui on 2017/5/9.
//  Copyright © 2017年 peilinghui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>


@interface WeakScriptMessageDelegate : NSObject<WKScriptMessageHandler>

@property (nonatomic, weak, readonly) id<WKScriptMessageHandler> scriptDelegate;

- (instancetype)initWithDelegate:(id<WKScriptMessageHandler>)scriptDelegate;

@end


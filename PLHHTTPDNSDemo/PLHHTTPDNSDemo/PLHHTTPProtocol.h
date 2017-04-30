//
//  PLHHTTPProtocol.h
//  PLHHTTPDNSDemo
//
//  Created by peilinghui on 2017/4/30.
//  Copyright © 2017年 peilinghui. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol  PLHHTTPProtocolDelegate;

@interface PLHHTTPProtocol : NSURLProtocol

@property(nonatomic, strong,readonly)NSURLAuthenticationChallenge *pendingChallenge;
@end

//
//  PLHHTTPProtocol.m
//  PLHHTTPDNSDemo
//
//  Created by peilinghui on 2017/4/30.
//  Copyright © 2017年 peilinghui. All rights reserved.
//

#import "PLHHTTPProtocol.h"

@interface PLHHTTPProtocol()<NSURLSessionDelegate>

@property(nonatomic,strong,readwrite)NSThread *clientThread;
@property(nonatomic,strong,readwrite)NSArray *modes;
@property(nonatomic,strong ,readwrite)NSURLSessionDataTask *task;
@property(nonatomic,strong)NSString *hostName;
@end

@implementation PLHHTTPProtocol

//自己写的，判断是否是正确的IP地址，用正则表达式
+(BOOL)isIpAddress:(NSString *)host{
    NSString *urlRegEx = @"^([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])$";
    
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCH %@",
                            urlRegEx];
    
    return [urlTest evaluateWithObject:host];
}



#pragma mark --NSURLProtocol 方法的覆写

#pragma --拦截
//可以通过该方法的返回值来筛选request是否需要被NSURLProtocol做拦截处理。拦截http请求
+(BOOL)canInitWithRequest:(NSURLRequest *)request{
    NSString *urlScheme = request.URL.scheme;
    //不考虑大小写，比较字符串
    if ([urlScheme caseInsensitiveCompare:@"http"] != NSOrderedSame) {
        return  YES;
    }
    
    NSString *urlHost = request.URL.host;
    if ([self isIpAddress:urlHost]) {
        return  NO;
    }
    
    return  NO;
}

//在该方法中，我们可以对request进行规范化。例如修改头部信息等。最后返回一个处理后的request实例。
+(NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request{
    return request;
}

//在得到了需要的请求对象之后，就可以初始化一个 NSURLProtocol 对象了：
- (id)initWithRequest:(NSURLRequest *)request cachedResponse:(NSCachedURLResponse *)cachedResponse client:(id <NSURLProtocolClient>)client {
    return [super initWithRequest:request cachedResponse:cachedResponse client:client];
}
#pragma --转发
//该方法会创建一个NSURLProtocol实例，这里每一个网络请求都会创建一个新的实例
//-(id)initWithRequest:(NSURLRequest *)request cachedResponse:(NSCachedURLResponse *)cachedResponse client:(id<NSURLProtocolClient>)client{
//    
//}

//转发的核心方法startLoading。在该方法中，我们把处理过的request重新发送出去。至于发送的形式，可以是基于NSURLConnection，NSURLSession甚至CFNetwork。
-(void)startLoading{
    NSMutableURLRequest *recursiveRequest;
    NSMutableArray *calculatedModes;
    NSString *currentMode;
    
    //把mode加入到RunLoopMode中
    calculatedModes = [NSMutableArray array];
    [calculatedModes addObject:NSDefaultRunLoopMode];
    currentMode = [[NSRunLoop currentRunLoop]currentMode];
    
    if ((currentMode!=nil) && ! [currentMode isEqualToString:NSDefaultRunLoopMode]) {
        [calculatedModes addObject:currentMode];
    }
    self.modes = calculatedModes;
    
    recursiveRequest = [[self request]mutableCopy];
    
    NSString *host = recursiveRequest.URL.host;
    NSString *scheme = recursiveRequest.URL.scheme;
    self.hostName = host;
   
    //子线程中
    __typeof(self)__weak wself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        
            if ([scheme caseInsensitiveCompare:@"http"] == NSOrderedSame){
                NSURLComponents  *components = [[NSURLComponents alloc]initWithURL:self.request.URL resolvingAgainstBaseURL:NO];
                recursiveRequest.URL = components.URL;
        }
        assert(recursiveRequest != nil);
        
        [recursiveRequest setValue:wself.hostName forHTTPHeaderField:@"Host"];
        
        wself.clientThread = [NSThread currentThread];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]delegate:self delegateQueue:nil];
        
        wself.task = [session dataTaskWithRequest:recursiveRequest];
        [wself.task resume];
        
    });
}

//网络请求结束
- (void)stopLoading{
    if (self.task != nil) {
        [self.task cancel];
        self.task = nil;
    }
    self.hostName = nil;
}


#pragma mark --转发 NSURLSession delegate callbacks
//使用NSURLSession发送的网络请求，那么在NSURLSession的回调方法中，我们做相应的处理即可。并且我们也可以对这些返回，进行定制化处理。

-(void)URLSession:(NSURLSession *)session task:(nonnull NSURLSessionTask *)task willPerformHTTPRedirection:(nonnull NSHTTPURLResponse *)response newRequest:(nonnull NSURLRequest *)request completionHandler:(nonnull void (^)(NSURLRequest * _Nullable))completionHandler{
    NSMutableURLRequest *redirectRequest;
    
    redirectRequest = [request mutableCopy];
    [[self client]URLProtocol:self wasRedirectedToRequest:redirectRequest redirectResponse:response];
    [self.task cancel];
    
    [[self client]URLProtocol:self didFailWithError:[NSError errorWithDomain:NSCocoaErrorDomain code:NSUserCancelledError userInfo:nil]];
}

-(void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler{
    SecTrustRef trust = challenge.protectionSpace.serverTrust;
    SecTrustResultType result;
    NSURLCredential *cred;
    
    OSStatus statues = SecTrustEvaluate(trust, &result);
    
    NSInteger retryCount =1;
    NSInteger retainCount = 0;
    
    while (statues == errSecSuccess && retryCount >=0) {
        if (result == kSecTrustResultProceed || result ==kSecTrustResultUnspecified) {
            cred = [NSURLCredential credentialForTrust:trust];
            
            completionHandler(NSURLSessionAuthChallengeUseCredential,cred);
            return;
        }else if (result == kSecTrustResultRecoverableTrustFailure){
            retryCount--;
            
            CFIndex numCerts = SecTrustGetCertificateCount(trust);
            NSMutableArray *certs = [NSMutableArray arrayWithCapacity:numCerts];
            for (CFIndex idx = 0; idx <numCerts; ++idx) {
                SecCertificateRef cert = SecTrustGetCertificateAtIndex(trust, idx);
                [certs addObject:CFBridgingRelease(cert)];
            }
            
            SecPolicyRef policy = SecPolicyCreateSSL(true, (__bridge CFStringRef)self.hostName);
            OSStatus err = SecTrustCreateWithCertificates((__bridge CFTypeRef _Nonnull)(certs), policy, &trust);
            retryCount ++;
            CFRelease(policy);
            
            [certs removeAllObjects];
            certs = nil;
            
            if (err != noErr) {
                NSLog(@"Error creating trust:%d",err);
                break;
            }
            statues = SecTrustEvaluate(trust, &result);
        }
    }
    completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge,nil);
}

-(void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(NSError *)error{
    
}

-(void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session{
    
}

//刚接收到Response信息
-(void)URLSession:(NSURLSession *)session dataTask:(nonnull NSURLSessionDataTask *)dataTask didReceiveResponse:(nonnull NSURLResponse *)response completionHandler:(nonnull void (^)(NSURLSessionResponseDisposition))completionHandler{
    NSURLCacheStoragePolicy cacheStoragePolicy;
    NSInteger statusCode;
    
    if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
        cacheStoragePolicy = [((NSHTTPURLResponse *)response) statusCode];
    }else{
        assert(NO);
        cacheStoragePolicy = NSURLCacheStorageNotAllowed;
        statusCode = 42;
    }
    
    [[self client ]URLProtocol:self didReceiveResponse:response cacheStoragePolicy:cacheStoragePolicy];
    
    completionHandler(NSURLSessionResponseAllow);
}

-(void)URLSession:(NSURLSession *)session dataTask:(nonnull NSURLSessionDataTask *)dataTask didReceiveData:(nonnull NSData *)data{
    
    [[self client]URLProtocol:self didLoadData:data];
}

-(void)URLSession:(NSURLSession *)session dataTask:(nonnull NSURLSessionDataTask *)dataTask willCacheResponse:(nonnull NSCachedURLResponse *)proposedResponse completionHandler:(nonnull void (^)(NSCachedURLResponse * _Nullable))completionHandler{
    completionHandler(proposedResponse);
}

-(void)URLSession:(NSURLSession *)session task:(nonnull NSURLSessionTask *)task didCompleteWithError:(nullable NSError *)error{
    if (error == nil) {
        [[self client]URLProtocolDidFinishLoading:self];
    }else{
        [[self client]URLProtocol:self didFailWithError:error];
    }
}

//为指定的请求启动验证
- (void)URLProtocol:(NSURLProtocol *)protocol didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge{
    
}

//为指定的请求取消验证
- (void)URLProtocol:(NSURLProtocol *)protocol didCancelAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge{
    
}

@end


//
//  RongCloudTool.h
//  RongCloudDemo
//
//  Created by peilinghui on 2018/9/26.
//  Copyright © 2018 jrdd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RongCloudTool : NSObject

/**
 *  工具类单例
 */
+ (JRongCloudTool *)sharedTool;

#pragma mark - 登录融云API

/**
 *  连接融云
 *
 *  @param token 服务器端返回的登录token
 */
- (void)connectWithToken:(NSString *)token;

/**
 *  连接融云
 *
 *  @param token     服务器端返回的登录token
 *  @param userModel 用户数据模型
 */
- (void)connectWithToken:(NSString *)token userModel:(JRongCloudUserModel *)userModel;

/**
 *  连接融云
 *
 *  @param token          服务器端返回的登录token
 *  @param userModel      用户数据模型
 *  @param success        成功回调
 *  @param error          失败回调
 *  @param tokenIncorrect token失效
 */
- (void)connectWithToken:(NSString *)token
               userModel:(JRongCloudUserModel *)userModel
                 success:(void (^)(NSString *userId))success
                   error:(void (^)(RCConnectErrorCode status))error
          tokenIncorrect:(void (^)())tokenIncorrect;

/**
 *  断开连接
 */
- (void)rongCloudLogOut;


#pragma mark - 业务API

/**
 *  创建新的聊天控制器
 *
 *  @param userModel  聊天对象用户模型
 *  @param completion 成功回调
 */
- (void)addPrivateConversationVieController:(JRongCloudUserModel *)userModel
                                 completion:(void (^)(RCConversationViewController *conversationVC))
completion;

/**
 *  更新登录用户的融云信息
 *
 *  @param userModel 修改当前用户的数据模型
 */
- (void)refreshUserInfo:(JRongCloudUserModel *)userModel;

/**
 *  是否建立连接
 */
- (BOOL)isConnecting;


@end

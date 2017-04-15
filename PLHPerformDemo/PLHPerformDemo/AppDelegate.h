//
//  AppDelegate.h
//  PLHPerformDemo
//
//  Created by peilinghui on 2017/4/15.
//  Copyright © 2017年 peilinghui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootTableViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) RootTableViewController *rootVC;

@end


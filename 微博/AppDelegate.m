//
//  AppDelegate.m
//  微博
//
//  Created by Lixin Zhou on 2016/12/21.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "AppDelegate.h"
#import "ZLXMainViewController.h"
#import "ZLXNewFeatureController.h"
#import "ZLXOAuthController.h"
#import "ZLXAccountTool.h"
#import "ZLXNewFeature.h"
#import "ZLXComposeController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    ZLXOAuthController *OAuthVC = [[ZLXOAuthController alloc] init];
    /** 取出账号*/
    ZLXAccount *account = [ZLXAccountTool TakeoutAccount];
    //判断版本新特性
    if (account) {
        [ZLXNewFeature Judgeversionnumber];
    }else{
        self.window.rootViewController = OAuthVC;
    }
//    ZLXComposeController *compose = [[ZLXComposeController alloc] init];
//    self.window.rootViewController = compose;
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            case AFNetworkReachabilityStatusNotReachable:
                [SVProgressHUD showWithStatus:@"网络异常，请检查后重试"];
                break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                [SVProgressHUD showWithStatus:@"当前使用的是WIFI环境"];
                NSLog(@"当前使用的是WIFI");
                break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
                [SVProgressHUD showWithStatus:@"当前使用的是手机网络，请注意流量的变化"];
                break;
        }
    }];
    //开始监控
    [manager stopMonitoring];
    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void) applicationDidReceiveMemoryWarning:(UIApplication *)application{
    //清除缓存
    [[SDImageCache sharedImageCache] clearMemory];
    //停止所有下载
    [[SDWebImageManager sharedManager] cancelAll];
}
@end

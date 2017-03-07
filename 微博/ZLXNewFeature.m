//
//  ZLXNewFeature.m
//  微博
//
//  Created by Lixin Zhou on 2016/12/23.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXNewFeature.h"
#import "ZLXMainViewController.h"
#import "ZLXNewFeatureController.h"
@implementation ZLXNewFeature
+ (void) Judgeversionnumber{
    NSString *versionKey = @"CFBundleVersion";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults objectForKey:versionKey];
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[versionKey];
    if ([currentVersion isEqualToString:lastVersion]) {
        [UIApplication sharedApplication].keyWindow.rootViewController = [[ZLXMainViewController alloc] init];
    }else{
        [UIApplication sharedApplication].keyWindow.rootViewController = [[ZLXNewFeatureController alloc]init];
        [defaults setObject:currentVersion forKey:versionKey];
        [defaults synchronize];
    }
}
@end

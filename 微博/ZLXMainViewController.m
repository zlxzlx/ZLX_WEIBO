//
//  ZLXMainViewController.m
//  微博
//
//  Created by Lixin Zhou on 2016/12/21.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXMainViewController.h"
#import "ZLXHomeController.h"
#import "ZLXMessageController.h"
#import "ZLXDiscoverController.h"
#import "ZLXProfileController.h"
#import "UIImage+ZLX.h"
#import "ZLXMainTabBar.h"
#import "ZLXNavigationController.h"
#import "ZLXUserTool.h"
#import "ZLXUnderCount.h"
#import "ZLXAccountTool.h"
#import "ZLXAccount.h"
@interface ZLXMainViewController ()
@property (nonatomic,weak) ZLXHomeController *home;
@end

@implementation ZLXMainViewController
+ (void) initialize{
    /** 默认状态*/
    NSMutableDictionary *Mdic = [NSMutableDictionary dictionary];
    Mdic[NSForegroundColorAttributeName] = [UIColor grayColor];
    Mdic[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    /** 选中状态*/
    NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    mdic[NSForegroundColorAttributeName] = [UIColor orangeColor];
    mdic[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    UITabBarItem *Item = [UITabBarItem appearance];
    [Item setTitleTextAttributes:Mdic forState:UIControlStateNormal];
    [Item setTitleTextAttributes:mdic forState:UIControlStateSelected];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupChildViewController];
    /** 替换系统tabBar*/
    [self setValue:[[ZLXMainTabBar alloc] init] forKey:@"tabBar"];
//    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(getUnreadCount) userInfo:nil repeats:YES];
}
- (void) getUnreadCount{
    ZLXUnderCount *parameter = [[ZLXUnderCount alloc] init];
    parameter.access_token = [ZLXAccountTool TakeoutAccount].access_token;
    parameter.uid = [NSString stringWithFormat:@"%lld",[ZLXAccountTool TakeoutAccount].uid];
    [ZLXUserTool unreadCountWithParamter:parameter success:^(ZLXUnderCountResult *result) {
        if (result.status == 0) {
            self.home.tabBarItem.badgeValue = nil;
        }else{
            self.home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%zd",result.status];
        }
    } failure:^(NSError *error) {
    }];
}
- (void) setupChildViewController{
    /** 首页*/
    ZLXHomeController *Home = [[ZLXHomeController alloc] init];
    [self setupChildViewControllerWithimageName:@"tabbar_home" selectedName:@"tabbar_home_selected" ChildViewController:Home titles:@"首页"];
    self.home = Home;
    /** 消息*/
    ZLXMessageController *Message = [[ZLXMessageController alloc] init];
    [self setupChildViewControllerWithimageName:@"tabbar_message_center" selectedName:@"tabbar_message_center_selected" ChildViewController:Message titles:@"消息"];
    /** 发现 设置tableview的样式*/
    ZLXDiscoverController *Discover = [[ZLXDiscoverController alloc] init];
    [self setupChildViewControllerWithimageName:@"tabbar_discover" selectedName:@"tabbar_discover_selected" ChildViewController:Discover titles:@"发现"];
    /** 我*/
    ZLXProfileController *Profile = [[ZLXProfileController alloc] init];
    [self setupChildViewControllerWithimageName:@"tabbar_profile" selectedName:@"tabbar_profile_selected" ChildViewController:Profile titles:@"我"];
}
- (void) setupChildViewControllerWithimageName:(NSString *) imageName selectedName:(NSString *)selectedName ChildViewController:(UIViewController *) ChildViewController titles:(NSString *) titles{
    ChildViewController.tabBarItem.title = titles;
    ChildViewController.tabBarItem.image = [UIImage imageWithName:imageName];
    ChildViewController.tabBarItem.selectedImage = [UIImage imageWithName:selectedName];
    ZLXNavigationController *Nav = [[ZLXNavigationController alloc] initWithRootViewController:ChildViewController];
    [self addChildViewController:Nav];
}
@end

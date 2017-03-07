//
//  ZLXNavigationController.m
//  微博
//
//  Created by Lixin Zhou on 2016/12/22.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXNavigationController.h"

@interface ZLXNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation ZLXNavigationController
+ (void) load{
    /** 设置导航栏标题属性*/
    UINavigationBar *bar = [UINavigationBar appearance];
    NSMutableDictionary *Mdic = [NSMutableDictionary dictionary];
    Mdic[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    [bar setTitleTextAttributes:Mdic];
    //设置文字属性
    UIBarButtonItem *Item = [UIBarButtonItem appearance];
    /** 默认状态*/
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:18];
    textAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [Item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    /** 不能被点中状态*/
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [Item setTitleTextAttributes:dic forState:UIControlStateDisabled];
//    [Item setBackgroundImage:[UIImage imageWithName:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    /** 高亮状态*/
    NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    mdic[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    mdic[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    [Item setTitleTextAttributes:mdic forState:UIControlStateHighlighted];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    [self.view addGestureRecognizer:pan];
    pan.delegate = self;
    self.interactivePopGestureRecognizer.enabled = NO;
}
//控制手势什么时候触发，只有非根控制器的时候才会触发手势
- (BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    return self.childViewControllers.count > 1;
}
- (void) pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count > 0) {
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem initWithImage:@"navigationbar_back" HeightImage:@"navigationbar_back_highlighted" target:self action:@selector(back)];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}
- (void) back{
    [self popViewControllerAnimated:YES];
}
@end

//
//  ZLXMainTabBar.m
//  微博
//
//  Created by Lixin Zhou on 2016/12/22.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXMainTabBar.h"
#import "ZLXComposeController.h"
#import "ZLXNavigationController.h"
@interface ZLXMainTabBar ()
@property (nonatomic,weak) UIButton *plusButton;
@property (nonatomic,weak) UIControl *previousButton;
@end
@implementation ZLXMainTabBar
- (instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIButton *plusButton = [[UIButton alloc] init];
        self.plusButton = plusButton;
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        plusButton.width = plusButton.currentBackgroundImage.size.width;
        plusButton.height = plusButton.currentBackgroundImage.size.height;
        [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        [plusButton addTarget:self action:@selector(ClickBtn) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:plusButton];
    }
    return self;
}
- (void) ClickBtn{
    ZLXComposeController *compse = [[ZLXComposeController alloc] init];
    ZLXNavigationController *Nav = [[ZLXNavigationController alloc] initWithRootViewController:compse];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:Nav animated:YES completion:nil];
}
- (void) layoutSubviews{
    [super layoutSubviews];
    self.plusButton.center = CGPointMake(self.width / 2, self.height / 2);
    /** 调整内部view的frame*/
    CGFloat buttonX = 0;
    CGFloat buttonY = 0;
    CGFloat buttonW = self.width / 5;
    CGFloat buttonH = self.height;
    NSInteger index = 0;
    /** 遍历子view*/
    for (UIControl *button in self.subviews) {
        if (![button isKindOfClass:NSClassFromString(@"UITabBarButton")])continue;
        if (index == 0 && self.previousButton == nil) {
            self.previousButton = button;
        }
        buttonX = index * buttonW;
        if (index > 1) {
            buttonX = buttonW * (index + 1);
        }
        index ++;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        [button addTarget:self action:@selector(buttonClick:)forControlEvents:UIControlEventTouchUpInside];
    }
}
- (void) buttonClick:(UIControl *)tabBarButton{
    if (self.previousButton == tabBarButton) {
        /** 发送通知*/
        [[NSNotificationCenter defaultCenter] postNotificationName:ZLXTabBarButtonDidRepeatClickNotification object:nil];
    }
    self.previousButton = tabBarButton;
}

@end

//
//  UIBarButtonItem+ZLX.m
//  微博
//
//  Created by Lixin Zhou on 2016/12/22.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "UIBarButtonItem+ZLX.h"

@implementation UIBarButtonItem (ZLX)
+ (UIBarButtonItem *) initWithImage:(NSString *)Image HeightImage:(NSString *)HeightImage target:(id)target action:(SEL)action{
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:Image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:HeightImage] forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    UIView *btnView = [[UIView alloc] init];
    btnView.frame = button.bounds;
    [btnView addSubview:button];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btnView];
    return item;
}
@end

//
//  ZLXCommonItem.m
//  微博
//
//  Created by Lixin Zhou on 2017/1/16.
//  Copyright © 2017年 Lixin Zhou. All rights reserved.
//

#import "ZLXCommonItem.h"

@implementation ZLXCommonItem
+ (instancetype) itemWithTitle:(NSString *)title icon:(NSString *)icon{
    ZLXCommonItem *item = [[self alloc] init];
    item.title = title;
    item.icon = icon;
    return item;
}
+ (instancetype) itemWithTitle:(NSString *)title{
    return [self itemWithTitle:title icon:nil];
}
@end

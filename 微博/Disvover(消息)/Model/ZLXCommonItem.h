//
//  ZLXCommonItem.h
//  微博
//
//  Created by Lixin Zhou on 2017/1/16.
//  Copyright © 2017年 Lixin Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZLXCommonItem : NSObject
/** 图标*/
@property (nonatomic,copy) NSString *icon;
/** 标题*/
@property (nonatomic,copy) NSString *title;
/** 子标题*/
@property (nonatomic,copy) NSString *subtitle;
/** 右边的数字显示标记*/
@property (nonatomic,copy) NSString *badgeValue;
/** 点击cell需要跳转的控制器*/
@property (nonatomic,assign) Class destVcClass;
/** block用copy*/
@property (nonatomic,copy) void(^operation)();
+ (instancetype) itemWithTitle:(NSString *) title icon:(NSString *) icon;
+ (instancetype) itemWithTitle:(NSString *) title;
@end

//
//  UIView+ZLX.h
//  真有趣
//
//  Created by Lixin Zhou on 16/8/30.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZLX)
@property (nonatomic,assign) CGSize size;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) CGFloat x;
@property (nonatomic,assign) CGFloat y;
@property (nonatomic,assign) CGFloat centerx;
@property (nonatomic,assign) CGFloat centery;
//@property (assign, nonatomic) CGSize size;
//@property CGFloat right;
/*
 在分类中声明@property ，只会生成方法的声明，没有实现，也不会生成_下划线的成员变量
 所以需要实现方法，重写getter和set方法；
 
 */
+ (instancetype) ZLX_ViewFromXib;
@end

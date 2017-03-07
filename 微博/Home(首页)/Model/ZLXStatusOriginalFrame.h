//
//  ZLXStatusOriginalFrame.h
//  微博
//
//  Created by Lixin Zhou on 2016/12/28.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZLXStatus;
@interface ZLXStatusOriginalFrame : NSObject
/** 昵称*/
@property (nonatomic,assign) CGRect nameFrame;
/** 正文*/
@property (nonatomic,assign) CGRect textFrame;
/** 来源*/
@property (nonatomic,assign) CGRect sourceFrame;
/** 时间*/
@property (nonatomic,assign) CGRect timeFame;
/** 头像*/
@property (nonatomic,assign) CGRect iconFrame;
/** 自己的frame*/
@property (nonatomic,assign) CGRect frame;
/** 模型*/
@property (nonatomic,strong) ZLXStatus *originalStatus;
/** VIP的frame*/
@property (nonatomic,assign) CGRect vipFrame;
/** 配图*/
@property (nonatomic,assign) CGRect photoFrame;
/** 判断是否加载配图*/
@property (nonatomic,assign) BOOL isLoad;
/** 位置信息*/
@property (nonatomic,assign) CGRect locationFrame;
@end

//
//  ZLXUser.h
//  微博
//
//  Created by Lixin Zhou on 2016/12/23.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZLXUser : NSObject
/** 昵称*/
@property (nonatomic,copy) NSString *name;
/** 头像*/
@property (nonatomic,copy) NSString *profile_image_url;
/** 会员类型*/
@property (nonatomic,assign) int mbtype;
/** 会员等级*/
@property (nonatomic,assign) int mbrank;
/** 是否为会员*/
@property (nonatomic,assign,getter = isvip) BOOL vip;
/** 位置信息*/
@property (nonatomic,copy) NSString *location;
+ (instancetype) userWithDict:(NSDictionary *) dict;
@end

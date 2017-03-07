//
//  ZLXUnderCountResult.h
//  微博
//
//  Created by Lixin Zhou on 2016/12/28.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZLXUnderCountResult : NSObject
/**
 返回值字段	字段类型	字段说明
 status	int	新微博未读数
 follower	int	新粉丝数
 cmt	int	新评论数
 dm	int	新私信数
 mention_status	int	新提及我的微博数
 mention_cmt	int	新提及我的评论数
 group	int	微群消息未读数
 private_group	int	私有微群消息未读数
 notice	int	新通知未读数
 invite	int	新邀请未读数
 badge	int	新勋章数
 photo	int	相册消息未读数*/
/** 新微博的未读数*/
@property (nonatomic,assign) int status;
/** 新粉丝数*/
@property (nonatomic,assign) int follower;
/** 新评论数*/
@property (nonatomic,assign) int cmt;
/** 新提及我的微博数*/
@property (nonatomic,assign) int mention_status;
/** 新提及我的评论数*/
@property (nonatomic,assign) int mention_cmt;
/** 新私信数*/
@property (nonatomic,assign) int dm;
@end

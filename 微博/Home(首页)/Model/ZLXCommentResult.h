//
//  ZLXCommentResult.h
//  微博
//
//  Created by Lixin Zhou on 2017/1/19.
//  Copyright © 2017年 Lixin Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZLXCommentResult : NSObject
@property (nonatomic,strong) NSArray *comments;
/** 评论总数*/
@property (nonatomic,assign) int total_number;
@end

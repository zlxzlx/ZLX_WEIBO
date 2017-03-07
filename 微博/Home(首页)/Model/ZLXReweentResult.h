//
//  ZLXReweentResult.h
//  微博
//
//  Created by Lixin Zhou on 2017/1/20.
//  Copyright © 2017年 Lixin Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZLXReweentResult : NSObject
/** 返回的数据*/
@property (nonatomic,strong) NSArray *reposts;
/** 评论总数*/
@property (nonatomic,assign) int total_number;
@end

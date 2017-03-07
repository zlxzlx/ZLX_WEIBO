//
//  ZLXLink.h
//  微博
//
//  Created by Lixin Zhou on 2017/1/14.
//  Copyright © 2017年 Lixin Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZLXLink : NSObject
/** 文字*/
@property (nonatomic,copy) NSString *text;
/** 范围*/
@property (nonatomic,assign) NSRange range;
/** 矩形框*/
@property (nonatomic,strong) NSArray *rects;
@end

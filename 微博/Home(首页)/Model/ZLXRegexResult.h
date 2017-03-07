//
//  ZLXRegexResult.h
//  微博
//
//  Created by Lixin Zhou on 2017/1/12.
//  Copyright © 2017年 Lixin Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZLXRegexResult : NSObject
/**
 *  匹配到的字符串
 */
@property (nonatomic, copy) NSString *string;
/**
 *  匹配到的范围
 */
@property (nonatomic, assign) NSRange range;

/**
 *  这个结果是否为表情
 */
@property (nonatomic, assign, getter = isEmotion) BOOL emotion;
@end

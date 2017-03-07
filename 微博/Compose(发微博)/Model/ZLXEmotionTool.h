//
//  ZLXEmotionTool.h
//  微博
//
//  Created by Lixin Zhou on 2017/1/9.
//  Copyright © 2017年 Lixin Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZLXEmotionModel;
@interface ZLXEmotionTool : NSObject
+ (NSArray *)defaultEmotions;
+ (NSArray *)emojiEmotions;
+ (NSArray *)lxhEmotions;
+ (NSArray *)recentEmotions;
+ (void) addRecentEmotion:(ZLXEmotionModel *) emotion;
/**
 *  根据表情的文字描述找出对应的表情对象
 */
+ (ZLXEmotionModel *)emotionWithDesc:(NSString *)desc;
@end

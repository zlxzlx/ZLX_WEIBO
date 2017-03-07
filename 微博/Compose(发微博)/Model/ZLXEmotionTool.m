//
//  ZLXEmotionTool.m
//  微博
//
//  Created by Lixin Zhou on 2017/1/9.
//  Copyright © 2017年 Lixin Zhou. All rights reserved.
//

#import "ZLXEmotionTool.h"
#import "ZLXEmotionModel.h"
#define ZLXRecentFilepath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"Emotions.data"]
/** 默认表情 */
static NSArray *_defaultEmotions;
/** emoji表情 */
static NSArray *_emojiEmotions;
/** 浪小花表情 */
static NSArray *_lxhEmotions;
/** 最近使用*/
static NSMutableArray *_recentEmotions;
@implementation ZLXEmotionTool

+ (NSArray *)defaultEmotions
{
    if (!_defaultEmotions) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        _defaultEmotions = [ZLXEmotionModel mj_objectArrayWithFile:plist];
        [_defaultEmotions makeObjectsPerformSelector:@selector(setDirectory:) withObject:@"EmotionIcons/default"];
    }
    return _defaultEmotions;
}
+ (NSArray *)emojiEmotions
{
    if (!_emojiEmotions) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        _emojiEmotions = [ZLXEmotionModel mj_objectArrayWithFile:plist];
        [_emojiEmotions makeObjectsPerformSelector:@selector(setDirectory:) withObject:@"EmotionIcons/emoji"];
    }
    return _emojiEmotions;
}
+ (NSArray *)lxhEmotions
{
    if (!_lxhEmotions) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        _lxhEmotions = [ZLXEmotionModel mj_objectArrayWithFile:plist];
        [_lxhEmotions makeObjectsPerformSelector:@selector(setDirectory:) withObject:@"EmotionIcons/lxh"];
        //        for (ZLXEmotionModel *emotion in self.lxhEmotions) {
        //            emotion.directory = @"EmotionIcons/lxh";
        //        }
    }
    return _lxhEmotions;
}
+ (NSMutableArray *)recentEmotions
{
    if (!_recentEmotions) {
        // 去沙盒中加载最近使用的表情数据
        _recentEmotions = [NSKeyedUnarchiver unarchiveObjectWithFile:ZLXRecentFilepath];
        if (!_recentEmotions) { // 沙盒中没有任何数据
            _recentEmotions = [NSMutableArray array];
        }
    }
    return _recentEmotions;
}
+ (void) addRecentEmotion:(ZLXEmotionModel *)emotion{
    //加载最近的表情数据
    [self recentEmotions];
    // 删除之前的表情
    [_recentEmotions removeObject:emotion];
    //添加最近的表情
    [_recentEmotions insertObject:emotion atIndex:0];
    [NSKeyedArchiver archiveRootObject:_recentEmotions toFile:ZLXRecentFilepath];
}
+ (ZLXEmotionModel *)emotionWithDesc:(NSString *)desc
{
    if (!desc) return nil;
    __block ZLXEmotionModel *foundEmotion = nil;
    // 从默认表情中找
    [[self defaultEmotions] enumerateObjectsUsingBlock:^(ZLXEmotionModel *emotion, NSUInteger idx, BOOL *stop) {
        if ([desc isEqualToString:emotion.chs] || [desc isEqualToString:emotion.cht]) {
            foundEmotion = emotion;
            *stop = YES;
        }
    }];

    if (foundEmotion) return foundEmotion;
    // 从浪小花表情中查找
    [[self lxhEmotions] enumerateObjectsUsingBlock:^(ZLXEmotionModel *emotion, NSUInteger idx, BOOL *stop) {
        if ([desc isEqualToString:emotion.chs] || [desc isEqualToString:emotion.cht]) {
            foundEmotion = emotion;
            *stop = YES;
        }
    }];
    return foundEmotion;
}
@end

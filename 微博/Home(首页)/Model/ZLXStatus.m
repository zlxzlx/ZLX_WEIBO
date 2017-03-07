//
//  ZLXStatus.m
//  微博
//
//  Created by Lixin Zhou on 2016/12/23.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//
#import "ZLXStatus.h"
#import "ZLXUser.h"
#import "ZLXPicture.h"
#import "NSDate+MJ.h"
#import <RegexKitLite.h>
#import "ZLXRegexResult.h"
#import "ZLXEmotionAttachment.h"
#import "ZLXEmotionTool.h"
#import "ZLXEmotionAttachment.h"
#import "ZLXEmotionTool.h"
@implementation ZLXStatus
+ (NSDictionary *) mj_objectClassInArray{
    return @{@"pic_urls":[ZLXPicture class]};
}
- (NSString *)created_at{
    // 日期格式字符串
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM d HH:mm:ss Z yyyy";
    //设置格式本地化
    fmt.locale = [NSLocale localeWithLocaleIdentifier:@"en_us"];
    NSDate *created_at = [fmt dateFromString:_created_at];
    if ([created_at isThisYear]) { // 今年
        if ([created_at isToday]) { // 今天
            // 计算跟当前时间差距
            NSDateComponents *cmp = [created_at deltaWithNow];
            if (cmp.hour >= 1) {
                return [NSString stringWithFormat:@"%ld小时之前",cmp.hour];
            }else if (cmp.minute > 1){
                return [NSString stringWithFormat:@"%ld分钟之前",cmp.minute];
            }else{
                return @"刚刚";
            }
        }else if ([created_at isYesterday]){ // 昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return  [fmt stringFromDate:created_at];
        }else{ // 前天
            fmt.dateFormat = @"MM-dd HH:mm";
            return  [fmt stringFromDate:created_at];
        }
    }else{ // 不是今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:created_at];
    }
    return _created_at;
}
- (void) setSource:(NSString *)source{
    _source = [source copy];
    NSRange range = [source rangeOfString:@">"];
    source = [source substringFromIndex:range.location + range.length];
    range = [source rangeOfString:@"<"];
    source = [source substringToIndex:range.location];
    source = [NSString stringWithFormat:@"来自 %@",source];
    _source = source;
}
/** 根据字符串计算出所有匹配结果*/
- (NSArray *) rerexResultWithText:(NSString *) text{
    /** 可变数组*/
    NSMutableArray *regexResults = [NSMutableArray array];
    //解析普通文本的表情
    //匹配表情
    NSString *emotionRegex = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
    [text enumerateStringsMatchedByRegex:emotionRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        ZLXRegexResult *rr = [[ZLXRegexResult alloc] init];
        rr.string = *capturedStrings;
        rr.range = *capturedRanges;
        rr.emotion = YES;
        [regexResults addObject:rr];
    }];
    //普通字符串
    [text enumerateStringsSeparatedByRegex:emotionRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        ZLXRegexResult *rr1 = [[ZLXRegexResult alloc] init];
        rr1.string = *capturedStrings;
        rr1.range = *capturedRanges;
        rr1.emotion = NO;
        [regexResults addObject:rr1];
    }];
    /** 排序*/
    [regexResults sortUsingComparator:^NSComparisonResult(ZLXRegexResult *rr1   , ZLXRegexResult *rr2) {
        if (rr1.range.location < rr2.range.location) {
            return NSOrderedAscending;
        }else if(rr1.range.location > rr2.range.location){
            return NSOrderedDescending;
        }else{
            return NSOrderedSame;
        }
    }];
    return regexResults;
}
- (void) setText:(NSString *)text{
    _text = text;
    /** 匹配*/
    NSArray *regexResults = [self rerexResultWithText:text];
    /** 根据匹配结果拼接对应的图片表情和普通文本*/
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    /** 遍历*/
    [regexResults enumerateObjectsUsingBlock:^(ZLXRegexResult *result, NSUInteger idx, BOOL * _Nonnull stop) {
        if (result.isEmotion) {//表情
            //创建附件对象
            ZLXEmotionAttachment *attchment = [[ZLXEmotionAttachment alloc] init];
            attchment.emotion = [ZLXEmotionTool emotionWithDesc:result.string];
            NSAttributedString *substr = [NSAttributedString attributedStringWithAttachment:attchment];
            attchment.bounds = CGRectMake(0, -3, [UIFont systemFontOfSize:ZLXStatusTextFont].lineHeight, [UIFont systemFontOfSize:ZLXStatusTextFont].lineHeight);
            [attributedText appendAttributedString:substr];
        }else{//非表情
            NSMutableAttributedString *substr = [[NSMutableAttributedString alloc] initWithString:result.string];
            /** ##*/
            NSString *trendRegex = @"#[a-zA-Z0-9\\u4e00-\\u9fa5]+#";
            [result.string enumerateStringsMatchedByRegex:trendRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
                [substr addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:*capturedRanges];
                [substr addAttribute:@"link" value:*capturedStrings range:*capturedRanges];
            }];
            // 匹配@提到
            NSString *mentionRegex = @"@[a-zA-Z0-9\\u4e00-\\u9fa5\\-_]+ ?";
            [result.string enumerateStringsMatchedByRegex:mentionRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
                [substr addAttribute:NSForegroundColorAttributeName value:[UIColor purpleColor] range:*capturedRanges];
                [substr addAttribute:@"link" value:*capturedStrings range:*capturedRanges];
            }];
            // 匹配超链接
            NSString *httpRegex = @"http(s)?://([a-zA-Z|\\d]+\\.)+[a-zA-Z|\\d]+(/[a-zA-Z|\\d|\\-|\\+|_./?%&=]*)?";
            [result.string enumerateStringsMatchedByRegex:httpRegex usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
                [substr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:92 / 255.0 green:138 / 255.0 blue:191 / 255.0 alpha:1.0] range:*capturedRanges];
                [substr addAttribute:@"link" value:*capturedStrings range:*capturedRanges];
            }];
            [attributedText appendAttributedString:substr];
        }
    }];
          /** 设置富文本字体大小*/
     [attributedText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:ZLXStatusTextFont] range:NSMakeRange(0, attributedText.length)];
    self.attributedText = attributedText;
}
@end

//
//  ZLXEmotionModel.m
//  微博
//
//  Created by Lixin Zhou on 2017/1/5.
//  Copyright © 2017年 Lixin Zhou. All rights reserved.
//

#import "ZLXEmotionModel.h"
#import "NSString+Emoji.h"
@implementation ZLXEmotionModel
- (NSString *) description{
    return [NSString stringWithFormat:@"%@ - %@ - %@", self.chs, self.png, self.code];
}
- (void) setCode:(NSString *)code{
    _code = [code copy];
    if (code == nil) return;
    self.emoji = [NSString emojiWithStringCode:code];
}
/** 归档*/
- (instancetype) initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.chs = [aDecoder decodeObjectForKey:@"chs"];
        self.png = [aDecoder decodeObjectForKey:@"png"];
        self.code = [aDecoder decodeObjectForKey:@"code"];
        self.directory = [aDecoder decodeObjectForKey:@"directory"];
        self.cht = [aDecoder decodeObjectForKey:@"chs"];
    }
    return self;
}
/** 解档*/
- (void) encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.chs forKey:@"chs"];
    [aCoder encodeObject:self.png forKey:@"png"];
    [aCoder encodeObject:self.code forKey:@"code"];
    [aCoder encodeObject:self.directory forKey:@"directory"];
    [aCoder encodeObject:self.cht forKey:@"cht"];
//    NSLog(@"qqqqqqq%@",self.directory);
}
- (BOOL)isEqual:(ZLXEmotionModel *)otherEmotion
{
    if (self.code) { // emoji表情
        return [self.code isEqualToString:otherEmotion.code];
    } else { // 图片表情
        return [self.png isEqualToString:otherEmotion.png] && [self.chs isEqualToString:otherEmotion.chs];
    }
}
@end

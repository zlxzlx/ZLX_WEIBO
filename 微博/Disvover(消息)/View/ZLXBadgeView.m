//
//  ZLXBadgeView.m
//  微博
//
//  Created by Lixin Zhou on 2017/1/17.
//  Copyright © 2017年 Lixin Zhou. All rights reserved.
//

#import "ZLXBadgeView.h"

@implementation ZLXBadgeView

- (instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setBackgroundImage:[UIImage resizedImage:@"main_badge"] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:10];
        self.height = self.currentBackgroundImage.size.height;
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}
- (void) setBadgeValue:(NSString *)badgeValue{
    _badgeValue = [badgeValue copy];
    [self setTitle:badgeValue forState:UIControlStateNormal];
    CGSize maxSzie = CGSizeMake(MAXFLOAT, MAXFLOAT);
    CGSize badgeValueSize = [self TextSize:badgeValue font:10 maxSize:maxSzie];
    CGFloat bgw = self.currentBackgroundImage.size.width;
    if (bgw > badgeValueSize.width) {
        self.width = bgw;
    }else{
        self.width = badgeValueSize.width + 10;
    }
}
- (CGSize) TextSize:(NSString *) text font:(CGFloat) font maxSize:(CGSize) maxSize{
    CGSize nameSize = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    return nameSize;
}
+ (instancetype) badgeView{
    return [[self alloc] init];
}
@end

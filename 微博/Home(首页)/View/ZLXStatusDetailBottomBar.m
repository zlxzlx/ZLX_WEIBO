//
//  ZLXStatusDetailBottomBar.m
//  微博
//
//  Created by Lixin Zhou on 2017/1/18.
//  Copyright © 2017年 Lixin Zhou. All rights reserved.
//

#import "ZLXStatusDetailBottomBar.h"

@interface ZLXStatusDetailBottomBar ()
@property (nonatomic,weak) UIButton *praiseBtn;
@property (nonatomic,weak) UIButton *shareBtn;
@property (nonatomic,weak) UIButton *commentBtn;
@property (nonatomic,strong) NSMutableArray *Btns;
@end
@implementation ZLXStatusDetailBottomBar
- (NSMutableArray *) Btns{
    if (_Btns == nil) {
        _Btns = [NSMutableArray array];
    }
    return _Btns;
}
- (instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:218 / 255.0 green:218 / 255.0 blue:218 / 255.0 alpha:1.0];
     self.shareBtn = [self addButtonWithImage:@"timeline_icon_retweet" Highlight:nil title:@"转发"];
     self.praiseBtn = [self addButtonWithImage:@"timeline_icon_unlike" Highlight:nil title:@"赞"];
     self.commentBtn = [self addButtonWithImage:@"statusdetail_icon_comment" Highlight:nil title:@"评论"];
        [self.Btns addObject:self.shareBtn];
        [self.Btns addObject:self.praiseBtn];
        [self.Btns addObject:self.commentBtn];
    }
    return self;
}
- (UIButton *) addButtonWithImage:(NSString *)imageName Highlight:(NSString *) HighlightName title:(NSString *) title{
    UIButton *button = [[UIButton alloc] init];
    button.backgroundColor = [UIColor purpleColor];
    [self addSubview:button];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:HighlightName] forState:UIControlStateHighlighted];
    return button;
}
+ (instancetype) initWithStatusDetailBottomBar{
    return [[self alloc] init];
}
- (void) layoutSubviews{
    [super layoutSubviews];
    NSInteger count = self.subviews.count;
    CGFloat buttonY = 5;
    CGFloat margin = 10;
    CGFloat buttonW = (self.width -(count + 1) * margin)/ count;
    CGFloat buttonH = self.height - 10;
//    for (UIButton *button in self.subviews) {
//        button.x = i * buttonW;
//        button.width = buttonW;
//        button.height = buttonH;
//        button.y = buttonY;
//        i ++;
//    }
    for (NSInteger i = 0; i < count; i ++) {
        UIButton *button = self.Btns[i];
        button.x = margin + i * (buttonW + margin);
        button.width = buttonW;
        button.height = buttonH;
        button.y = buttonY;
    }
}

@end

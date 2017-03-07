//
//  ZLXEmotionToolBar.m
//  微博
//
//  Created by Lixin Zhou on 2017/1/5.
//  Copyright © 2017年 Lixin Zhou. All rights reserved.
//

#import "ZLXEmotionToolBar.h"

@interface ZLXEmotionToolBar ()
@property (nonatomic,weak) UIButton *seletedButton;
@end
@implementation ZLXEmotionToolBar

- (instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        /** 添加工具栏的4个按钮*/
        // 1.添加4个按钮
        [self addButtonWithtitle:@"最近" type:ZLXEmotionTypeRecent];
        [self addButtonWithtitle:@"默认" type:ZLXEmotionTypeDefault];
        [self addButtonWithtitle:@"Emoji" type:ZLXEmotionTypeEmoji];
        [self addButtonWithtitle:@"浪小花" type:ZLXEmotionTypeLxh];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectedDidEmotion:) name:ZLXEmotionDidSelectedNotification object:nil];
    }
    return self;
}
- (void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void) selectedDidEmotion:(NSNotification *)note{
    if (self.seletedButton.tag == ZLXEmotionTypeRecent) {
        [self clickButton:self.seletedButton];
    }
}
- (void) layoutSubviews{
    [super layoutSubviews];
    /** 工具栏的子view*/
    NSInteger count = self.subviews.count;
    CGFloat buttonW = self.width / count;
    for (NSInteger i = 0; i < count; i ++) {
        UIButton *button = self.subviews[i];
        button.tag = i;
        if (button.tag == 1) {
            [self clickButton:button];
        }
        button.width = buttonW;
        button.height = self.height;
        button.x = i * buttonW;
    }
}
- (void) addButtonWithtitle:(NSString *) title type:(ZLXEmotionType)tag{
    UIButton *button = [[UIButton alloc] init];
    button.tag = tag;
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"compose_emotion_table_right_normal"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"compose_emotion_table_mid_selected"] forState:UIControlStateSelected];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
}
- (void) clickButton:(UIButton *) button{
    self.seletedButton.selected = NO;
    button.selected = YES;
    self.seletedButton = button;
    if ([self.delegate respondsToSelector:@selector(emotionToolbar:didSelectedButton:)]) {
        [self.delegate emotionToolbar:self didSelectedButton:(ZLXEmotionType)button.tag];
    }
}
@end

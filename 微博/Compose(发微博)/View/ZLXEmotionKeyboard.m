//
//  ZLXEmotionKeyboard.m
//  微博
//
//  Created by Lixin Zhou on 2017/1/4.
//  Copyright © 2017年 Lixin Zhou. All rights reserved.
//

#import "ZLXEmotionKeyboard.h"
#import "ZLXEmotionlistView.h"
#import "ZLXEmotionToolBar.h"
#import "ZLXEmotionModel.h"
#import "ZLXEmotionTool.h"
@interface ZLXEmotionKeyboard ()<ZLXEmotionToolBarDelegate>
@property (nonatomic,weak) ZLXEmotionToolBar *toolbar;
@property (nonatomic,weak) ZLXEmotionlistView *listView;
@property (nonatomic,weak) UIButton *seletedButton;

@end
@implementation ZLXEmotionKeyboard

- (instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        /** 工具栏*/
        ZLXEmotionToolBar *toolbar = [[ZLXEmotionToolBar alloc] init];
        toolbar.delegate = self;
        [self addSubview:toolbar];
        self.toolbar = toolbar;
        /** 表情列表*/
        ZLXEmotionlistView *listView = [[ZLXEmotionlistView alloc] init];
        self.listView = listView;
        [self addSubview:listView];
    }
    return self;
}
- (void) layoutSubviews{
    [super layoutSubviews];
    /** 工具栏*/
    self.toolbar.frame = CGRectMake(0, self.bounds.size.height - 30, ZLXScreenW, 30);
    /** 表情键盘*/
    self.listView.x = 0;
    self.listView.y = 0;
    self.listView.width = ZLXScreenW;
    self.listView.height = self.height - self.toolbar.height;
}
+ (instancetype) keyboard{
    return [[self alloc] init];
}
#pragma mark - HMEmotionToolbarDelegate
- (void)emotionToolbar:(ZLXEmotionToolBar *)toolbar didSelectedButton:(ZLXEmotionType)emotionType
{
    switch (emotionType) {
        case ZLXEmotionTypeDefault:// 默认
            self.listView.emotions = [ZLXEmotionTool defaultEmotions];
//            NSLog(@"默认");
            break;
        case ZLXEmotionTypeEmoji: // Emoji
            self.listView.emotions = [ZLXEmotionTool emojiEmotions];
//            NSLog(@"Emoji");
            break;
        case ZLXEmotionTypeLxh: // 浪小花
            self.listView.emotions = [ZLXEmotionTool lxhEmotions];
//            NSLog(@"浪小花");
            break;
        case ZLXEmotionTypeRecent:
//            NSLog(@"点击了最近");
            self.listView.emotions = [ZLXEmotionTool recentEmotions];
            break;
    }
//    NSLog(@"%zd %@", self.listView.emotions.count, [self.listView.emotions firstObject]);
}
@end

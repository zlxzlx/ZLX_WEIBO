//
//  ZLXEmotionGridView.m
//  微博
//
//  Created by Lixin Zhou on 2017/1/5.
//  Copyright © 2017年 Lixin Zhou. All rights reserved.
//

#import "ZLXEmotionGridView.h"
#import "ZLXEmotionModel.h"
#import "ZLXEmotionView.h"
#import "ZLXEmotionPopView.h"
#import "ZLXEmotionTool.h"
@interface ZLXEmotionGridView ()
@property (nonatomic,weak) ZLXEmotionView *emotionView;
@property (nonatomic,strong) UIButton *deleteBtn;
@property (nonatomic,strong) ZLXEmotionPopView *popView;
/** 可变数组*/
@property (nonatomic,strong) NSMutableArray *arrays;
@end
@implementation ZLXEmotionGridView
- (ZLXEmotionPopView *) popView{
    if (_popView == nil) {
        _popView = [ZLXEmotionPopView PopViewFromXib];
    }
    return _popView;
}
- (NSMutableArray *) arrays{
    if (_arrays == nil) {
        _arrays = [NSMutableArray array];
    }
    return _arrays;
}
- (instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        /** 添加删除按钮*/
        UIButton *deleteBtn = [[UIButton alloc] init];
        /** 添加点击事件*/
        [deleteBtn addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
        self.deleteBtn = deleteBtn;
        [deleteBtn setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [deleteBtn setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [self addSubview:deleteBtn];
        /** 添加手势识别器*/
        UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] init];
        [recognizer addTarget:self action:@selector(longPress:)];
        [self addGestureRecognizer:recognizer];
    }
    return self;
}
- (void) longPress:(UILongPressGestureRecognizer *)recognizer{
    NSLog(@"手势长按是否有效？");
    if (recognizer.state == UIGestureRecognizerStateEnded) {
            [self.popView dismiss];
    }else{
        //捕获触摸点
        CGPoint point = [recognizer locationInView:recognizer.view];
        NSLog(@"%f",point.x);
        //检测触摸点落在哪个位置上
        [self.arrays enumerateObjectsUsingBlock:^(ZLXEmotionView *emotionView, NSUInteger idx, BOOL * _Nonnull stop) {
            if (CGRectContainsPoint(emotionView.frame, point) && emotionView.hidden == NO) {
                [self.popView showFromEmotionView:emotionView];
                [self emotionClick:emotionView];
            }
        }];
    }
}
+ (instancetype) view{
    return [[self alloc] init];
}
- (void) setEmotions:(NSArray *)emotions{
    _emotions = emotions;
    //button的个数
    NSInteger count = emotions.count;
    for (NSInteger i = 0; i < count; i ++) {
        ZLXEmotionView *emotionView = [[ZLXEmotionView alloc] init];
        /** 添加按钮的点击事件*/
        [emotionView addTarget:self action:@selector(emotionClick:) forControlEvents:UIControlEventTouchUpInside];
        self.emotionView = emotionView;
        emotionView.tag = i;
        /** 禁止按钮的高亮状态*/
        emotionView.adjustsImageWhenHighlighted = NO;
        ZLXEmotionModel *emotion = emotions[i];
        emotionView.emotion = emotion;
        [self addSubview:emotionView];
        [self.arrays addObject:emotionView];
    }
}
- (void) layoutSubviews{
    [super layoutSubviews];
    CGFloat leftInset = 15;
    CGFloat topInset = 15;
    NSInteger count = self.arrays.count;
    CGFloat buttonW = (self.width - 2 * leftInset) / ZLXmotionMaxCols;
    CGFloat buttonH = (self.height - topInset) / ZLXmotionMaxRows;
    for (int i = 0; i<count; i++) {
        ZLXEmotionView *button = self.arrays[i];
        button.x = leftInset + (i % ZLXmotionMaxCols) * buttonW;
        button.y = topInset + (i / ZLXmotionMaxCols) * buttonH;
        button.width = buttonW;
        button.height = buttonH;
    }
    /** 删除按钮frame*/
    self.deleteBtn.width = buttonW;
    self.deleteBtn.height = buttonH;
    self.deleteBtn.x = self.width - leftInset - self.deleteBtn.width;
    self.deleteBtn.y = self.height - self.deleteBtn.height;
}
#pragma --- 按钮的点击事件
- (void) emotionClick:(ZLXEmotionView *) emotionView{
    /** 添加提示view*/
    [self.popView showFromEmotionView:emotionView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popView dismiss];
    });
    //选中表情
    [self selectedEmotion:emotionView.emotion];
}
- (void) selectedEmotion:(ZLXEmotionModel *) emotion{
    if (emotion == nil) return;
    //保存表情
    [ZLXEmotionTool addRecentEmotion:emotion];
    //发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:ZLXEmotionDidSelectedNotification object:nil userInfo:@{ZLXSelectedEmotion : emotion}];
}
#pragma ----- 删除按钮的点击事件
- (void) delete:(UIButton *) deleteBtn{
    NSLog(@"删除内容");
    [[NSNotificationCenter defaultCenter] postNotificationName:ZLXEmotionDidDeleteNotification object:nil userInfo:nil];
}
@end

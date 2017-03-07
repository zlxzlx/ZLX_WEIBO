//
//  ZLXEmotionPopView.m
//  微博
//
//  Created by Lixin Zhou on 2017/1/6.
//  Copyright © 2017年 Lixin Zhou. All rights reserved.
//

#import "ZLXEmotionPopView.h"
#import "ZLXEmotionModel.h"
#import "ZLXEmotionView.h"
@interface ZLXEmotionPopView ()

@property (weak, nonatomic) IBOutlet ZLXEmotionView *emotionView;

@end
@implementation ZLXEmotionPopView
+ (instancetype) PopViewFromXib{
    return [[[NSBundle mainBundle] loadNibNamed:@"ZLXEmotionPopView" owner:nil options:nil]lastObject];
}
- (void) drawRect:(CGRect)rect{
    [[UIImage imageNamed:@"emoticon_keyboard_magnifier"] drawInRect:rect];
}
//- (void) setEmotion:(ZLXEmotionModel *)emotion{
//    _emotion = emotion;
//    if (emotion.code) {
//        [self.emotionBtn setTitle:emotion.emoji forState:UIControlStateNormal];
//    }else{
//        NSString *icon = [NSString stringWithFormat:@"%@/%@", emotion.directory, emotion.png];
//        UIImage *image = [UIImage imageWithName:icon];
//        [self.emotionBtn setImage:image forState:UIControlStateNormal];
//    }
//}
- (void) showFromEmotionView:(ZLXEmotionView *)FromemotionView{
    //显示表情
    self.emotionView.emotion = FromemotionView.emotion;
    //添加到窗口上
    UIWindow *window = [[[UIApplication sharedApplication]windows]lastObject];
    [window addSubview:self];
    //位置
    CGFloat centerX = FromemotionView.centerx;
    CGFloat centerY = FromemotionView.centery - self.height * 0.5;
    CGPoint center = CGPointMake(centerX, centerY);
    CGPoint Center = [window convertPoint:center fromView:FromemotionView.superview];
    self.center = Center;
}
- (void) dismiss{
    [self removeFromSuperview];
}
@end

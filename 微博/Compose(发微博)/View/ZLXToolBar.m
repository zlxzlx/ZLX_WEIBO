//
//  ZLXToolBar.m
//  微博
//
//  Created by Lixin Zhou on 2016/12/26.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXToolBar.h"

@interface ZLXToolBar ()
@property (nonatomic, weak) UIButton *emotionButton;
@end
@implementation ZLXToolBar

- (instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background_os7"]];
        [self addButtonWithIcon:@"compose_camerabutton_background_os7" heightIcon:@"compose_camerabutton_background_highlighted_os7"tage:ZLXComposeToolbarButtonTypeCamera];
        [self addButtonWithIcon:@"compose_toolbar_picture_os7" heightIcon:@"compose_toolbar_picture_highlighted_os7" tage:ZLXComposeToolbarButtonTypePicture];
        [self addButtonWithIcon:@"compose_mentionbutton_background_os7" heightIcon:@"compose_mentionbutton_background_highlighted_os7"tage:ZLXComposeToolbarButtonTypeMetion];
        [self addButtonWithIcon:@"compose_trendbutton_background_os7" heightIcon:@"compose_trendbutton_background_highlighted_os7"tage:ZLXComposeToolbarButtonTypeTrend];
        [self addButtonWithIcon:@"compose_emoticonbutton_background_os7" heightIcon:@"compose_emoticonbutton_background_highlighted_os7"tage:ZLXComposeToolbarButtonTypeEmotion];
    }
    return self;
}
- (void) addButtonWithIcon:(NSString *)Icon heightIcon:(NSString *)heightIcon tage:(ZLXComposeToolbarButtonType) Type{
    UIButton *button = [[UIButton alloc] init];
    if (Type == ZLXComposeToolbarButtonTypeEmotion) {
        self.emotionButton = button;
    }
    button.tag = Type;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:Icon] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:heightIcon] forState:UIControlStateHighlighted];
    [self addSubview:button];
}
- (void) buttonClick:(UIButton *) button{
    if ([self.delegate respondsToSelector:@selector(composeTool:didClickedButton:)]) {
        [self.delegate composeTool:self didClickedButton:(int)button.tag];
    }
}
- (void) layoutSubviews{
    [super layoutSubviews];
    NSInteger count = self.subviews.count;
    CGFloat buttonW = self.width / count;
    for (NSInteger i = 0; i < count; i ++) {
        UIButton *button = self.subviews[i];
        NSLog(@" button---%zd",self.subviews.count);
        button.width = buttonW;
        button.height = self.height;
        button.x = i * buttonW;
    }
}
- (void) setShowEmtionButton:(BOOL)ShowEmtionButton{
    _ShowEmtionButton = ShowEmtionButton;
    if (ShowEmtionButton) { // 显示表情按钮
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_emoticonbutton_background_os7"] forState:UIControlStateNormal];
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted_os7"] forState:UIControlStateHighlighted];
    } else { // 切换为键盘按钮
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_keyboardbutton_background"] forState:UIControlStateNormal];
        [self.emotionButton setImage:[UIImage imageNamed:@"compose_keyboardbutton_background_highlighted"] forState:UIControlStateHighlighted];
    }
}
@end

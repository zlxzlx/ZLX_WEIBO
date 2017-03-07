//
//  ZLXTextView.m
//  微博
//
//  Created by Lixin Zhou on 2016/12/26.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXTextView.h"

@interface ZLXTextView ()
@property (nonatomic,weak) UILabel *placeholderLabel;

@end
@implementation ZLXTextView
- (instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //添加placeholder
        UILabel *placeholderLabel = [[UILabel alloc] init];
        self.placeholderLabel = placeholderLabel;
        placeholderLabel.numberOfLines = 0;
        /** 设置默认字体*/
        self.font = [UIFont systemFontOfSize:15];
        placeholderLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:placeholderLabel];
        placeholderLabel.backgroundColor = [UIColor clearColor];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(TextDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}
/** 移除通知*/
- (void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void) setAttributedText:(NSAttributedString *)attributedText{
    [super setAttributedText:attributedText];
    [self TextDidChange];
}
/** 监听内容的改变*/
- (void) TextDidChange{
    self.placeholderLabel.hidden = (self.attributedText.length != 0);
}
- (void)setPlaceholder:(NSString *)placeholder{
    _placeholder = [placeholder copy];
    self.placeholderLabel.text = placeholder;
}
- (void) setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor = placeholderColor;
    self.placeholderLabel.textColor = placeholderColor;
}
- (void) setFont:(UIFont *)font{
    [super setFont:font];
    self.placeholderLabel.font = font;
}
- (void) layoutSubviews{
    [super layoutSubviews];
    self.placeholderLabel.x = 5;
    self.placeholderLabel.y = 7.5;
    self.placeholderLabel.width = self.width - 2 * 5;
    CGSize LabelSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
    CGFloat LabelH = [self.placeholderLabel.text boundingRectWithSize:LabelSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil].size.height;
    self.placeholderLabel.height = LabelH;
}
- (void) setText:(NSString *)text{
    [super setText:text];
    [self TextDidChange];
}
@end

//
//  ZLXStatusTopBar.m
//  微博
//
//  Created by Lixin Zhou on 2017/1/18.
//  Copyright © 2017年 Lixin Zhou. All rights reserved.
//

#import "ZLXStatusDetailTopBar.h"
#import "ZLXStatus.h"
@interface ZLXStatusDetailTopBar ()
/** 转发*/
@property (weak, nonatomic) IBOutlet UIButton *reweetBtn;
/** 评论*/
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
/** 赞*/
@property (weak, nonatomic) IBOutlet UIButton *zanBtn;

@property (weak, nonatomic) IBOutlet UIImageView *ArrowView;
- (IBAction)buttonClick:(UIButton *)button;
@property (nonatomic,weak) UIButton *selectedbutton;
@end
@implementation ZLXStatusDetailTopBar

+ (instancetype) initWithXib{
    return [[[NSBundle mainBundle] loadNibNamed:@"ZLXStatusDetailTopBar" owner:nil options:nil]lastObject];
}

- (void) awakeFromNib{
    [super awakeFromNib];
    self.reweetBtn.tag = ZLXStatusDetailTopBarButtonTypeReweet;
    self.commentBtn.tag = ZLXStatusDetailTopBarButtonTypeComment;
}
- (void) drawRect:(CGRect)rect{
    [[UIImage resizedImage:@"statusdetail_comment_top_background"]drawInRect:rect];
}
/** 监听按钮的点击*/
- (IBAction)buttonClick:(UIButton *)button {
    self.selectedButtonType = (ZLXStatusDetailTopBarButtonType)button.tag;
    self.selectedbutton.selected = NO;
    button.selected = YES;
    self.selectedbutton = button;
    /** 控制按钮终点的位置*/
//    [UIView animateWithDuration:0.25 animations:^{
//        self.ArrowView.centerx = button.centerx;
//    }];
    if ([self.delegate respondsToSelector:@selector(topToolbar:didselctedButton:)]) {
        [self.delegate topToolbar:self didselctedButton:(ZLXStatusDetailTopBarButtonType)button.tag];
    }
}
- (void) setDelegate:(id<ZLXStatusDetailTopBarDelegate>)delegate{
    _delegate = delegate;
    [self buttonClick:self.commentBtn];
}
- (void)setStatus:(ZLXStatus *)status
{
    _status = status;
    [self setupBtnTitle:self.reweetBtn count:status.reposts_count defaultTitle:@"转发"];
    [self setupBtnTitle:self.commentBtn count:status.comments_count defaultTitle:@"评论"];
    [self setupBtnTitle:self.zanBtn count:status.attitudes_count defaultTitle:@"赞"];
}
- (void)setupBtnTitle:(UIButton *)button count:(int)count defaultTitle:(NSString *)defaultTitle
{
    if (count >= 10000) { // [10000, 无限大)
        defaultTitle = [NSString stringWithFormat:@"%.1f万 %@", count / 10000.0, defaultTitle];
        // 用空串替换掉所有的.0
        defaultTitle = [defaultTitle stringByReplacingOccurrencesOfString:@".0" withString:@""];
    } else if (count > 0) { // (0, 10000)
        defaultTitle = [NSString stringWithFormat:@"%d %@", count, defaultTitle];
    } else {
        defaultTitle = [NSString stringWithFormat:@"0 %@", defaultTitle];
    }
    [button setTitle:defaultTitle forState:UIControlStateNormal];
#warning 最好同时设置多种状态下的文字
    [button setTitle:defaultTitle forState:UIControlStateSelected];
}
@end

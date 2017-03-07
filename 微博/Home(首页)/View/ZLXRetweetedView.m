//
//  ZLXRetweetedView.m
//  微博
//
//  Created by Lixin Zhou on 2016/12/28.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXRetweetedView.h"
#import "ZLXStatusReweetedFrame.h"
#import "ZLXStatus.h"
#import "ZLXUser.h"
#import "ZLXStatusPhotosView.h"
#import "ZLXStatusLabel.h"
@interface ZLXRetweetedView ()
@property (nonatomic,weak) UILabel *nameLabel;
@property (nonatomic,weak) ZLXStatusLabel *textLabel;
/** 配图*/
@property (nonatomic,weak) ZLXStatusPhotosView *photoView;
@end
@implementation ZLXRetweetedView

- (instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        self.image = [UIImage resizedImage:@"timeline_retweet_background"];
        //昵称
        UILabel *nameLabel = [[UILabel alloc] init];
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        self.nameLabel.textColor = [UIColor colorWithRed:74 / 255.0 green:102 / 255.0 blue:105 / 255.0 alpha:1.0];
        nameLabel.font = [UIFont systemFontOfSize:ZLXStatusNameFont];
        //正文
        ZLXStatusLabel *textLabel = [[ZLXStatusLabel alloc] init];
        [self addSubview:textLabel];
        self.textLabel = textLabel;
        //配图
        ZLXStatusPhotosView *photoView = [[ZLXStatusPhotosView alloc] init];
        [self addSubview:photoView];
        self.photoView = photoView;
    }
    return self;
}
- (void) setReweetedFrame:(ZLXStatusReweetedFrame *)reweetedFrame{
    _reweetedFrame = reweetedFrame;
    self.frame = reweetedFrame.frame;
    //昵称
    self.nameLabel.frame = reweetedFrame.nameFrame;
    self.nameLabel.text = [NSString stringWithFormat:@"@%@",reweetedFrame.retweetedStatus.user.name];
    //正文
    self.textLabel.frame = reweetedFrame.textFrame;
    self.textLabel.attributedText = reweetedFrame.retweetedStatus.attributedText;
    /** 配图*/
    if (reweetedFrame.retweetedStatus.pic_urls.count) {
        self.photoView.frame = reweetedFrame.photoFrame;
        self.photoView.pic_urls = reweetedFrame.retweetedStatus.pic_urls;
        self.photoView.hidden = NO;
    }else{
        self.photoView.hidden = YES;
    }
}
@end

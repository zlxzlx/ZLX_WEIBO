//
//  ZLXStatusOriginalView.m
//  微博
//
//  Created by Lixin Zhou on 2016/12/28.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXStatusOriginalView.h"
#import "ZLXStatusOriginalFrame.h"
#import "ZLXStatus.h"
#import "ZLXUser.h"
#import "ZLXStatusPhotosView.h"
#import "ZLXStatusLabel.h"
@interface ZLXStatusOriginalView ()
@property (nonatomic,weak) UILabel *nameLabel;
@property (nonatomic,weak) ZLXStatusLabel *textLabel;
@property (nonatomic,weak) UILabel *timeLabel;
@property (nonatomic,weak) UILabel *sourceLabel;
@property (nonatomic,weak) UIImageView *iconView;
@property (nonatomic,weak) UIImageView *vipView;
@property (nonatomic,weak) UILabel *locationLabel;
/** 配图*/
@property (nonatomic,weak) ZLXStatusPhotosView *photoView;
@end
@implementation ZLXStatusOriginalView
- (instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //        self.autoresizingMask = UIViewAutoresizingNone;
        //昵称
        UILabel *nameLabel = [[UILabel alloc] init];
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        nameLabel.font = [UIFont systemFontOfSize:ZLXStatusNameFont];
        //正文
        ZLXStatusLabel *textLabel = [[ZLXStatusLabel alloc] init];
        [self addSubview:textLabel];
        self.textLabel = textLabel;
        //时间
        UILabel *timeLabel = [[UILabel alloc] init];
        [timeLabel setTextColor:[UIColor orangeColor]];
        [timeLabel setNeedsDisplay];
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
        timeLabel.font = [UIFont systemFontOfSize:ZLXStatusTimeFont];
        //来源
        UILabel *sourceLabel = [[UILabel alloc] init];
        [sourceLabel setTextColor:[UIColor lightGrayColor]];
        [self addSubview:sourceLabel];
        self.sourceLabel = sourceLabel;
        sourceLabel.font = [UIFont systemFontOfSize:ZLXStatusSourceFont];
        //头像
        UIImageView *iconView = [[UIImageView alloc] init];
        iconView.layer.cornerRadius = 17.5;
        iconView.layer.masksToBounds = YES;
        [self addSubview:iconView];
        self.iconView = iconView;
        //会员图标
        UIImageView *vipView = [[UIImageView alloc] init];
        [self addSubview:vipView];
        self.vipView = vipView;
        vipView.contentMode = UIViewContentModeCenter;
        //配图
        ZLXStatusPhotosView *photoView = [[ZLXStatusPhotosView alloc] init];
        [self addSubview:photoView];
        self.photoView = photoView;
        /** 位置信息*/
        UILabel *locationLabel = [[UILabel alloc] init];
        locationLabel.font = [UIFont systemFontOfSize:13];
        locationLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:locationLabel];
        self.locationLabel = locationLabel;
    }
    return self;
}
- (void) setOriginalFrame:(ZLXStatusOriginalFrame *)originalFrame{
    _originalFrame = originalFrame;
    self.frame = originalFrame.frame;
    [self setNeedsDisplay];
    /** 取出数据*/
    ZLXStatus *status = originalFrame.originalStatus;
    //昵称
    if (status.user.isvip) {
        self.nameLabel.textColor = [UIColor orangeColor];
        self.vipView.frame = originalFrame.vipFrame;
        self.vipView.hidden = NO;
        self.vipView.image = [UIImage imageNamed:[NSString stringWithFormat:@"common_icon_membership_level%d",status.user.mbrank]];
    }else{
        self.nameLabel.textColor = [UIColor blackColor];
        self.vipView.hidden = YES;
    }
    self.nameLabel.frame = originalFrame.nameFrame;
    self.nameLabel.text = status.user.name;
    //正文
    self.textLabel.frame = originalFrame.textFrame;
    self.textLabel.attributedText = status.attributedText;
    //时间
    NSString *time = status.created_at;
    self.timeLabel.text = time;
    CGFloat timeX = CGRectGetMinX(self.nameLabel.frame);
    CGFloat timeY = CGRectGetMaxY(self.nameLabel.frame) + ZLXCellMargin;
    CGSize maxTimeSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
    CGSize timeSize = [self TextSize:time font:ZLXStatusTimeFont maxSize:maxTimeSize];
    self.timeLabel.frame = CGRectMake(timeX, timeY, timeSize.width, timeSize.height);
    //来源
    self.sourceLabel.text = status.source;
    CGFloat sourceX = CGRectGetMaxX(self.timeLabel.frame) + ZLXCellMargin;
    CGFloat sourceY = timeY;
    CGSize sourceMaxSzie = CGSizeMake(MAXFLOAT, MAXFLOAT);
    CGSize sourceSize = [self TextSize:status.source font:ZLXStatusSourceFont maxSize:sourceMaxSzie];
    self.sourceLabel.frame = CGRectMake(sourceX, sourceY, sourceSize.width, sourceSize.height);
    //头像
    self.iconView.frame = originalFrame.iconFrame;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:status.user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default"]];
    /** 配图*/
    if (status.pic_urls.count) {
        self.photoView.frame = originalFrame.photoFrame;
        self.photoView.hidden = NO;
        self.photoView.pic_urls = status.pic_urls;
    }else{
        self.photoView.hidden = YES;
    }
    /** 位置信息*/
    self.locationLabel.frame = originalFrame.locationFrame;
    self.locationLabel.text = [NSString stringWithFormat:@"%@",status.user.location];
}
- (CGSize) TextSize:(NSString *) text font:(CGFloat) font maxSize:(CGSize) maxSize{
    CGSize nameSize = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    return nameSize;
}
@end

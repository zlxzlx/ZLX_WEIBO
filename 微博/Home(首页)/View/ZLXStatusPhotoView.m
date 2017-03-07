//
//  ZLXStatusPhotoView.m
//  微博
//
//  Created by Lixin Zhou on 2016/12/30.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXStatusPhotoView.h"
#import "ZLXPicture.h"

@interface ZLXStatusPhotoView ()
@property (nonatomic,weak) UIImageView *gifView;
@end
@implementation ZLXStatusPhotoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        self.userInteractionEnabled = YES;
        //添加GIF图标
        UIImageView *gifView = [[UIImageView alloc] init];
        gifView.image = [UIImage imageNamed:@"timeline_image_gif"];
        self.gifView = gifView;
        [self addSubview:gifView];
    }
    return self;
}
- (void) setPhoto:(ZLXPicture *)photo{
    _photo = photo;
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    NSString *extension = photo.thumbnail_pic.pathExtension.lowercaseString;
    if ([extension isEqualToString:@"gif"]) {
        self.gifView.hidden = NO;
    }else{
        self.gifView.hidden = YES;
    }
}
- (void) layoutSubviews{
    [super layoutSubviews];
    self.gifView.x = 0;
    self.gifView.y = 0;
    self.gifView.width = 25;
    self.gifView.height = 20;
}
@end

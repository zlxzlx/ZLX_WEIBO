//
//  ZLXStatusPhotosView.m
//  微博
//
//  Created by Lixin Zhou on 2016/12/30.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXStatusPhotosView.h"
#import "ZLXPicture.h"
#import "ZLXStatusPhotoView.h"
#import <MJPhotoBrowser.h>
#import <MJPhoto.h>
@interface ZLXStatusPhotosView ()
@property (nonatomic,weak) ZLXStatusPhotoView *photoView;
@end
@implementation ZLXStatusPhotosView
#define ZLXPhotoMaxNumber 9
#define ZLXStatusPhotomaxCols(photosCount) ((photosCount==4)?2:3)
- (instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        for (NSInteger i = 0; i < ZLXPhotoMaxNumber; i ++) {
            ZLXStatusPhotoView *photoView = [[ZLXStatusPhotoView alloc] init];
            photoView.backgroundColor = [UIColor blackColor];
            self.photoView = photoView;
            [self addSubview:photoView];
            UITapGestureRecognizer *Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPhoto:)];
            [photoView addGestureRecognizer:Tap];
        }
    }
    return self;
}
- (void) clickPhoto:(UITapGestureRecognizer *) tap{
    //创建图片浏览器
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    NSMutableArray *photos = [NSMutableArray array];
    NSInteger count = self.pic_urls.count;
    for (NSInteger i = 0; i < count; i ++) {
        ZLXPicture *pic = self.pic_urls[i];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:pic.bmiddle_pic];
        photo.srcImageView = self.subviews[i];
        [photos addObject:photo];
        browser.currentPhotoIndex = tap.view.tag;
    }
    browser.photos = photos;
    //显示图片浏览器
    [browser show];
}
+ (CGSize) sizeWithPhotosCount:(NSInteger)photosCount{
    //一列最多多少行
    NSInteger maxClos = ZLXStatusPhotomaxCols(photosCount);
    CGFloat photoW = (ZLXScreenW - (maxClos + 1) * ZLXCellMargin) / maxClos;
    CGFloat photoH = photoW;
    //总列数
    NSInteger totalCols = photosCount;
    NSInteger totalRows = (photosCount + maxClos - 1) / maxClos;
    //计算尺寸
    CGFloat photosW = totalCols * photoW + (totalCols - 1) * ZLXCellMargin;
    CGFloat photosH = totalRows * photoH + (totalRows - 1) * ZLXCellMargin;
    return CGSizeMake(photosW, photosH);
}
- (void) setPic_urls:(NSArray *)pic_urls{
    _pic_urls = pic_urls;
    for (NSInteger i = 0; i < pic_urls.count; i ++) {
        ZLXStatusPhotoView *photoView = self.subviews[i];
        photoView.photo = pic_urls[i];
        photoView.hidden = NO;
    }
    for (NSInteger i = pic_urls.count; i < self.subviews.count; i ++) {
        ZLXStatusPhotoView *photoView = self.subviews[i];
        photoView.hidden = YES;
    }
}
- (void) layoutSubviews{
    [super layoutSubviews];
    NSInteger count = self.pic_urls.count;
    NSInteger maxClos = ZLXStatusPhotomaxCols(count);
    for (NSInteger i = 0; i < count; i ++) {
        ZLXStatusPhotoView *photoView = self.subviews[i];
        photoView.width = (ZLXScreenW - (maxClos + 1) * ZLXCellMargin) / maxClos;
        photoView.height = photoView.width;
        photoView.x = (i % maxClos) * (photoView.width + ZLXCellMargin);
        photoView.y = (i / maxClos) * (photoView.height + ZLXCellMargin);
    }
}
@end

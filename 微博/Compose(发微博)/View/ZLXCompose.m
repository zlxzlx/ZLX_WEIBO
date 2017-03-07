//
//  ZLXCompose.m
//  微博
//
//  Created by Lixin Zhou on 2016/12/27.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXCompose.h"

@interface ZLXCompose ()
@property (nonatomic,weak) UIImageView *imageView;
@end
@implementation ZLXCompose
- (void) addImage:(UIImage *)image{
    UIImageView *imageView = [[UIImageView alloc] init];
    self.imageView = imageView;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.image = image;
    [self addSubview:imageView];
}
- (void) layoutSubviews{
    [super layoutSubviews];
    NSInteger count = self.subviews.count;
    NSInteger maxColsPerRow = 4;
    CGFloat margin = 10;
    CGFloat imageViewW = (self.width - (maxColsPerRow + 1) * margin) / maxColsPerRow;
    CGFloat imageViewH = imageViewW;
    for (NSInteger i = 0; i < count;i ++) {
        NSInteger row = i / maxColsPerRow;
        NSInteger col = i % maxColsPerRow;
        UIImageView *imageView = self.subviews[i];
        imageView.width = imageViewW;
        imageView.height = imageViewH;
        imageView.x = col * (imageViewW + margin) + margin;
        imageView.y = row * (imageViewH + margin);
    }
}
- (NSArray *) images{
    NSMutableArray *array = [NSMutableArray array];
    for (UIImageView *imageView in self.subviews) {
        [array addObject:imageView.image];
    }
    return array;
}
@end

//
//  ZLXNewFeatureController.m
//  微博
//
//  Created by Lixin Zhou on 2016/12/22.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXNewFeatureController.h"
#import "ZLXMainViewController.h"
@interface ZLXNewFeatureController ()<UIScrollViewDelegate>
@property (nonatomic,weak) UIScrollView *NewFeature;
@property (nonatomic,weak) UIPageControl *pageControl;
@property (nonatomic,weak) UIButton *shareButton;
@end

@implementation ZLXNewFeatureController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupScrollview];
    [self setupPageControl];
}
- (void) setupScrollview{
    UIScrollView *NewFeature = [[UIScrollView alloc] init];
    NewFeature.bounces = NO;
    self.NewFeature = NewFeature;
    NewFeature.delegate = self;
    NewFeature.showsHorizontalScrollIndicator = NO;
    NewFeature.pagingEnabled = YES;
    NewFeature.frame = self.view.bounds;
    [self.view addSubview:NewFeature];
    NewFeature.contentSize = CGSizeMake(self.view.width * 4, 0);
    /** 添加图片*/
    NSInteger i = 0;
    for (i = 0; i < 4; i ++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.userInteractionEnabled = YES;
        [NewFeature addSubview:imageView];
        imageView.width = NewFeature.width;
        imageView.height = NewFeature.height;
        imageView.x = imageView.width * i;
        imageView.y = 0;
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"new_feature_%zd",i + 1]];
        if (i == 3) {
            [self setupBtn:imageView];
        }
    }
}
- (void) setupBtn:(UIImageView *) imageView{
    UIButton *Btn = [[UIButton alloc] init];
    Btn.backgroundColor = [UIColor redColor];
    [imageView addSubview:Btn];
    [Btn setTitle:@"开始微博" forState:UIControlStateNormal];
    Btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [Btn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [Btn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    Btn.width = Btn.currentBackgroundImage.size.width;
    Btn.height = Btn.currentBackgroundImage.size.height;
    Btn.centerx = self.view.width * 0.5;
    Btn.centery = self.view.height * 0.80;
    [Btn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    //分享按钮
    UIButton *shareButton = [[UIButton alloc] init];
    [shareButton setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareButton setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    shareButton.selected = YES;
    [shareButton setTitle:@"分享给大家" forState:UIControlStateNormal];
    shareButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [imageView addSubview:shareButton];
    shareButton.width = 150;
    shareButton.height = 35;
    shareButton.centerx = self.view.width * 0.5;
    shareButton.centery = self.view.height * 0.7;
    [shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(check) forControlEvents:UIControlEventTouchUpInside];
    self.shareButton = shareButton;
    shareButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -5);
    shareButton.imageEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
}
- (void) check{
    self.shareButton.selected = !self.shareButton.selected;
}
- (void) clickBtn{
    ZLXMainViewController *MainVC = [[ZLXMainViewController alloc] init];
    self.view.window.rootViewController = MainVC;
}
- (void)setupPageControl{
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    self.pageControl = pageControl;
    pageControl.numberOfPages = 4;
    pageControl.centerx = self.view.width * 0.5;
    pageControl.centery = self.view.height * 0.9;
    [self.view addSubview:pageControl];
    pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
}
- (void) scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset = scrollView.contentOffset.x + scrollView.width / 2;
    NSInteger index = offset / scrollView.width;
    self.pageControl.currentPage = index;
}
@end

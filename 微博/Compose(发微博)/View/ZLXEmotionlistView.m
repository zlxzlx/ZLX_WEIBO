//
//  ZLXEmotionlistView.m
//  微博
//
//  Created by Lixin Zhou on 2017/1/4.
//  Copyright © 2017年 Lixin Zhou. All rights reserved.
//

#import "ZLXEmotionlistView.h"
#import "ZLXEmotionGridView.h"
/** 表情的最大行数*/
#define ZLXEmotionMaxRows 3
/** 表情的最大列数*/
#define ZLXEmotionMaxCols 7
/** 每一页最多显示的表情数*/
#define ZLXEmotionMaxCountPerPage (ZLXEmotionMaxRows * ZLXEmotionMaxCols - 1)
@interface ZLXEmotionlistView ()<UIScrollViewDelegate>
/** 表情键盘*/
@property (nonatomic,weak) UIScrollView *scrollView;
/** pagecontroller*/
@property (nonatomic,weak) UIPageControl *pageControl;
@end
@implementation ZLXEmotionlistView

- (instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        /** 表情键盘view*/
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.delegate = self;
        self.scrollView = scrollView;
        scrollView.pagingEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.bounces = NO;
        [self addSubview:scrollView];
        /** pagecontroller*/
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.hidesForSinglePage = YES;
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKey:@"_currentPageImage"];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKey:@"_pageImage"];
        pageControl.backgroundColor = [UIColor darkGrayColor];
        [self addSubview:pageControl];
        self.pageControl = pageControl;
    }
    return self;
}
- (void) setEmotions:(NSArray *)emotions{
    _emotions = emotions;
      [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //设置总页数
    NSInteger totalPages = (emotions.count + 10) / ZLXEmotionMaxCountPerPage;
    self.pageControl.numberOfPages = totalPages;
    self.pageControl.currentPage = 0;
    self.scrollView.contentSize = CGSizeMake(self.pageControl.numberOfPages * self.scrollView.width, 0);
    //显示多少页表情
    for (NSInteger i = 0; i < self.pageControl.numberOfPages; i ++) {
        ZLXEmotionGridView *gridView = [ZLXEmotionGridView view];
#warning 越界判断处理
        NSInteger loc = i * ZLXEmotionMaxCountPerPage;
        NSInteger len = ZLXEmotionMaxCountPerPage;
        if (loc + len > emotions.count) {
            len = emotions.count - loc;
        }
        NSRange range = NSMakeRange(loc, len);
        NSArray *array = [emotions subarrayWithRange:range];
        gridView.emotions = array;
        [self.scrollView addSubview:gridView];
    }
    [self setNeedsLayout];
    self.scrollView.contentOffset = CGPointZero;
}
- (void) layoutSubviews{
    [super layoutSubviews];
    /** 表情键盘view*/
    self.scrollView.x = 0;
    self.scrollView.y = 0;
    self.scrollView.width = self.width;
    self.scrollView.height = self.height - 35;
    /** pagecontroller*/
    self.pageControl.x = 0;
    self.pageControl.y = self.height - 35;
    self.pageControl.width = self.width;
    self.pageControl.height = 35;
    /** 设置gridView的frame*/
    for (NSInteger i = 0; i < self.pageControl.numberOfPages; i ++) {
        ZLXEmotionGridView *gridView = self.scrollView.subviews[i];
        gridView.width = self.scrollView.width;
        gridView.height = self.scrollView.height;
        gridView.x = i * gridView.width;
    }
}
- (void) scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset = scrollView.contentOffset.x;
    NSInteger index = offset / scrollView.width + 0.5;
    self.pageControl.currentPage = index;
}
@end

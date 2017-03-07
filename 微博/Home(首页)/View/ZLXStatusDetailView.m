//
//  ZLXStatusDetailView.m
//  微博
//
//  Created by Lixin Zhou on 2016/12/28.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXStatusDetailView.h"
#import "ZLXStatusOriginalView.h"
#import "ZLXRetweetedView.h"
#import "ZLXStatusDetailFrame.h"
#import "ZLXStatusOriginalFrame.h"
#import "ZLXStatusReweetedFrame.h"
@interface ZLXStatusDetailView ()
@property (nonatomic,weak) ZLXStatusOriginalView *originalView;
@property (nonatomic,weak) ZLXRetweetedView *retweetedView;
@end

@implementation ZLXStatusDetailView
- (instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        ZLXStatusOriginalView *originalView = [[ZLXStatusOriginalView alloc] init];
        [self addSubview:originalView];
        self.originalView = originalView;
        ZLXRetweetedView *retweetedView = [[ZLXRetweetedView alloc] init];
        [self addSubview:retweetedView];
        self.retweetedView = retweetedView;
    }
    return self;
}
- (void) setDetailFrame:(ZLXStatusDetailFrame *)DetailFrame{
    _DetailFrame = DetailFrame;
    self.frame = DetailFrame.frame;
    //原创微博的frame
    self.originalView.originalFrame = DetailFrame.originalFrame;
    //转发微博的frame
    self.retweetedView.reweetedFrame = DetailFrame.retweetedFrame;
}
@end

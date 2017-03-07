//
//  ZLXStatusDetailFrame.m
//  微博
//
//  Created by Lixin Zhou on 2016/12/28.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXStatusDetailFrame.h"
#import "ZLXStatusOriginalFrame.h"
#import "ZLXStatusReweetedFrame.h"
#import "ZLXStatus.h"
@implementation ZLXStatusDetailFrame
- (void) setDetailStatus:(ZLXStatus *)detailStatus{
    _detailStatus = detailStatus;
    //计算原创微博的frame
    ZLXStatusOriginalFrame *originalFrame = [[ZLXStatusOriginalFrame alloc] init];
    originalFrame.originalStatus = detailStatus;
    self.originalFrame = originalFrame;
    //计算转发微博的frame
    CGFloat h = 0;
    if (detailStatus.retweeted_status){
        ZLXStatusReweetedFrame *retweetedFrame = [[ZLXStatusReweetedFrame alloc] init];
        retweetedFrame.retweetedStatus = detailStatus.retweeted_status;
        //计算转发微博的Y值
        CGRect f = retweetedFrame.frame;
        f.origin.y = CGRectGetMaxY(originalFrame.frame);
        retweetedFrame.frame = f;
        self.retweetedFrame = retweetedFrame;
        h = CGRectGetMaxY(retweetedFrame.frame);
    }else{
        h = CGRectGetMaxY(originalFrame.frame);
    }
    CGFloat X = 0;
    CGFloat Y = ZLXCellMargin;
    CGFloat W = ZLXScreenW;
    self.frame = CGRectMake(X, Y, W, h);
}
@end

//
//  ZLXStatusFrame.m
//  微博
//
//  Created by Lixin Zhou on 2016/12/28.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXStatusFrame.h"
#import "ZLXStatusDetailFrame.h"
//#import ""
@implementation ZLXStatusFrame
- (void) setStatus:(ZLXStatus *)status{
    _status = status;
    [self setupDetailFrame];
    [self setupToolbarFrame];
    self.cellHeight = CGRectGetMaxY(self.toolbarFrame) + ZLXCellMargin;
}
/** 计算具体内容，包括转发*/
- (void) setupDetailFrame{
    ZLXStatusDetailFrame *detailFrame = [[ZLXStatusDetailFrame alloc] init];
    detailFrame.detailStatus = self.status;
    self.detailFrame = detailFrame;
}
/** 计算底部工具栏*/
- (void) setupToolbarFrame{
    CGFloat toolbarX = 0;
    CGFloat toolbarY = CGRectGetMaxY(self.detailFrame.frame);
    CGFloat toolbarW = ZLXScreenW;
    CGFloat toolbarH = 35;
    self.toolbarFrame = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
}
@end

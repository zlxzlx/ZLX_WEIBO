//
//  ZLXStatusReweetedFrame.m
//  微博
//
//  Created by Lixin Zhou on 2016/12/28.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXStatusReweetedFrame.h"
#import "ZLXStatus.h"
#import "ZLXUser.h"
#import "ZLXStatusPhotosView.h"
@implementation ZLXStatusReweetedFrame
- (void) setRetweetedStatus:(ZLXStatus *)retweetedStatus{
    _retweetedStatus = retweetedStatus;
    //昵称
    CGFloat nameX = ZLXCellMargin;
    CGFloat nameY = ZLXCellMargin;
    CGSize nameMaxSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
    NSString *name = [NSString stringWithFormat:@"@%@",retweetedStatus.user.name];
    CGSize nameSzie = [self TextSize:name font:ZLXStatusNameFont maxSize:nameMaxSize];
    self.nameFrame = CGRectMake(nameX, nameY, nameSzie.width, nameSzie.height);
    //正文
    CGFloat textX = nameX;
    CGFloat textY = CGRectGetMaxY(self.nameFrame) + ZLXCellMargin;
    CGSize textMaxSize = CGSizeMake(ZLXScreenW - 2 * ZLXCellMargin, MAXFLOAT);
    CGSize textSize = [self TextSize:retweetedStatus.text font:ZLXStatusTextFont maxSize:textMaxSize];
    self.textFrame = CGRectMake(textX, textY, textSize.width, textSize.height);
    CGFloat H = 0;
    /** 配图*/
    if (retweetedStatus.pic_urls.count) {
        CGFloat photoX = ZLXCellMargin;
        CGFloat photoY = CGRectGetMaxY(self.textFrame) + ZLXCellMargin;
        CGSize photoSize = [ZLXStatusPhotosView sizeWithPhotosCount:retweetedStatus.pic_urls.count];
        self.photoFrame = CGRectMake(photoX, photoY, photoSize.width, photoSize.height);
        H = CGRectGetMaxY(self.photoFrame) + ZLXCellMargin;
    }else{
        H = CGRectGetMaxY(self.textFrame) + ZLXCellMargin;
    }
    //自己
    CGFloat X = 0;
    CGFloat Y = 0;
    CGFloat W = ZLXScreenW;
    self.frame = CGRectMake(X, Y, W, H);
}
- (CGSize) TextSize:(NSString *) text font:(CGFloat) font maxSize:(CGSize) maxSize{
    CGSize nameSize = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    return nameSize;
}
@end

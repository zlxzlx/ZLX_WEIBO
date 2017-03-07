//
//  ZLXStatusOriginalFrame.m
//  微博
//
//  Created by Lixin Zhou on 2016/12/28.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXStatusOriginalFrame.h"
#import "ZLXStatus.h"
#import "ZLXUser.h"
#import "ZLXStatusPhotosView.h"
@implementation ZLXStatusOriginalFrame
- (void) setOriginalStatus:(ZLXStatus *)originalStatus{
    _originalStatus = originalStatus;
    //头像
    CGFloat iconX = ZLXCellMargin;
    CGFloat iconY = ZLXCellMargin;
    CGFloat iconW = 35;
    CGFloat iconH = 35;
    self.iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    //昵称
    CGFloat nameX = CGRectGetMaxX(self.iconFrame) + ZLXCellMargin;
    CGFloat nameY = iconY;
    CGSize maxSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
    CGSize nameSize = [self TextSize:originalStatus.user.name font:ZLXStatusNameFont maxSize:maxSize];
    self.nameFrame = CGRectMake(nameX, nameY, nameSize.width, nameSize.height);
    CGSize locationMaxSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
    CGSize locationSize = [self TextSize:originalStatus.user.location font:13 maxSize:locationMaxSize];
    CGFloat locationX = 0;
    CGFloat locationY = 10;
    if (originalStatus.user.isvip) {
        CGFloat vipW = nameSize.height;
        CGFloat vipH = vipW;
        CGFloat vipX = CGRectGetMaxX(self.nameFrame) + ZLXCellMargin;
        CGFloat vipY = ZLXCellMargin;
        self.vipFrame = CGRectMake(vipX, vipY, vipW, vipH);
        locationX = CGRectGetMaxX(self.vipFrame) + ZLXCellMargin;
    }else{
        locationX = CGRectGetMaxX(self.nameFrame) + ZLXCellMargin;
    }
    /**位置信息 */
    self.locationFrame = CGRectMake(locationX, locationY, locationSize.width, locationSize.height);
    //正文
    CGFloat textX = ZLXCellMargin;
    CGFloat textY = CGRectGetMaxY(self.iconFrame) + ZLXCellMargin;
    CGFloat maxW = ZLXScreenW - 2 * textX;
    CGSize maxtxteSize = CGSizeMake(maxW, MAXFLOAT);
    CGSize textSize = [self TextSize:originalStatus.text font:ZLXStatusTextFont maxSize:maxtxteSize];
    self.textFrame = CGRectMake(textX, textY, textSize.width, textSize.height);
    CGFloat H = 0;
    /** 配图*/
    if (originalStatus.pic_urls.count) {
        CGFloat photosX = ZLXCellMargin;
        CGFloat photosY = CGRectGetMaxY(self.textFrame) + ZLXCellMargin;
        CGSize photoSize = [ZLXStatusPhotosView sizeWithPhotosCount:originalStatus.pic_urls.count];
        self.photoFrame = CGRectMake(photosX, photosY, photoSize.width, photoSize.height);
        H = CGRectGetMaxY(self.photoFrame) + ZLXCellMargin;
    }else {
        H = CGRectGetMaxY(self.textFrame) + ZLXCellMargin;
    } 
    /** 自己的frame*/
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

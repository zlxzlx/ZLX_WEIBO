//
//  ZLXHeader.h
//  微博
//
//  Created by Lixin Zhou on 2016/12/22.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#ifndef ZLXHeader_h
#define ZLXHeader_h
#import "UIView+ZLX.h"
#import "ZLXConst.h"
#import "UIBarButtonItem+ZLX.h"
#import "UIImage+ZLX.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "MBProgressHUD.h"
#import <MJExtension.h>
#import <SDImageCache.h>
#import <SDWebImageManager.h>
#import "ZLXHttpTool.h"
#import "UIImageView+WebCache.h"
#import <MJRefresh.h>
#define ZLXScreenW [UIScreen mainScreen].bounds.size.width
#define ZLXScreenH [UIScreen mainScreen].bounds.size.height
//cell的参数
#define ZLXCellMargin 10
#define ZLXStatusNameFont 14
#define ZLXStatusTimeFont 12
#define ZLXStatusSourceFont 12
#define ZLXStatusTextFont 15
/** 表情按钮选中通知*/
#define ZLXEmotionDidSelectedNotification @"ZLXEmotionDidSelectedNotification"
#define ZLXSelectedEmotion @"ZLXSelectedEmotion"
/** 删除表情通知*/
#define ZLXEmotionDidDeleteNotification @"ZLXEmotionDidDeleteNotification"
// 颜色
#define ZLXColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
// 随机色
#define ZLXRandomColor ZLXColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
#define ZLXmotionMaxRows 3
// 表情的最大列数
#define ZLXmotionMaxCols 7
// 每页最多显示多少个表情
#define ZLXmotionMaxCountPerPage (ZLXEmotionMaxRows * ZLXEmotionMaxCols - 1)
// 转发微博正文字体
#define ZLXStatusHighTextColor ZLXColor(88, 161, 253)
// 富文本字体
#define ZLXStatusRichTextFont [UIFont systemFontOfSize:13]
// 原创微博正文字体
#define ZLXStatusOrginalTextFont [UIFont systemFontOfSize:14]
//富文本出现的连接
#define ZLXLinkText @"ZLXLinkText"
//点击超链接的通知
#define ZLXLinkDidSelectedNotification @"ZLXLinkDidSelectedNotification"
#define ZLXLinkText @"ZLXLinkText"
#endif

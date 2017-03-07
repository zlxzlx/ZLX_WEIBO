//
//  ZLXEmotionPopView.h
//  微博
//
//  Created by Lixin Zhou on 2017/1/6.
//  Copyright © 2017年 Lixin Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZLXEmotionView;
@interface ZLXEmotionPopView : UIView
/** 显示表情弹出控件*/
+ (instancetype) PopViewFromXib;
/** 从哪个表情弹出*/
- (void) showFromEmotionView:(ZLXEmotionView *) FromemotionView;
- (void) dismiss;
@end

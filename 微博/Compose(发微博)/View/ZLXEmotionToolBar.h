//
//  ZLXEmotionToolBar.h
//  微博
//
//  Created by Lixin Zhou on 2017/1/5.
//  Copyright © 2017年 Lixin Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZLXEmotionToolBar;

typedef enum {
    ZLXEmotionTypeRecent, // 最近
    ZLXEmotionTypeDefault, // 默认
    ZLXEmotionTypeEmoji, // Emoji
    ZLXEmotionTypeLxh // 浪小花
} ZLXEmotionType;
@protocol ZLXEmotionToolBarDelegate <NSObject>
- (void)emotionToolbar:(ZLXEmotionToolBar *)toolbar didSelectedButton:(ZLXEmotionType)emotionType;
@end
@interface ZLXEmotionToolBar : UIView
@property (nonatomic,weak)  id <ZLXEmotionToolBarDelegate> delegate;
@end

//
//  ZLXEmotionTextView.h
//  微博
//
//  Created by Lixin Zhou on 2017/1/10.
//  Copyright © 2017年 Lixin Zhou. All rights reserved.
//

#import "ZLXTextView.h"
@class ZLXEmotionModel;
@interface ZLXEmotionTextView : ZLXTextView
/** 拼接表情*/
- (void) appendEmotion:(ZLXEmotionModel *)emotion;
/**
 *  具体的文字内容
 */
- (NSString *) realText;
@end

//
//  ZLXEmotionAttachment.h
//  微博
//
//  Created by Lixin Zhou on 2017/1/12.
//  Copyright © 2017年 Lixin Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZLXEmotionModel;
@interface ZLXEmotionAttachment : NSTextAttachment
@property (nonatomic,strong) ZLXEmotionModel *emotion;
@end

//
//  ZLXEmotionAttachment.m
//  微博
//
//  Created by Lixin Zhou on 2017/1/12.
//  Copyright © 2017年 Lixin Zhou. All rights reserved.
//

#import "ZLXEmotionAttachment.h"
#import "ZLXEmotionModel.h"
@implementation ZLXEmotionAttachment
- (void) setEmotion:(ZLXEmotionModel *)emotion{
    _emotion = emotion;
    self.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@/%@", emotion.directory, emotion.png]];
//    self.bounds
    
}
@end

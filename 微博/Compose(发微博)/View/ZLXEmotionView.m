//
//  ZLXEmotionView.m
//  微博
//
//  Created by Lixin Zhou on 2017/1/6.
//  Copyright © 2017年 Lixin Zhou. All rights reserved.
//

#import "ZLXEmotionView.h"
#import "ZLXEmotionModel.h"

@implementation ZLXEmotionView
- (void) setEmotion:(ZLXEmotionModel *)emotion{
    _emotion = emotion;
    if (emotion.code) {
        self.titleLabel.font = [UIFont systemFontOfSize:27];
        [self setTitle:emotion.emoji forState:UIControlStateNormal];
    }else{
        NSString *icon = [NSString stringWithFormat:@"%@/%@", emotion.directory, emotion.png];
        UIImage *image = [UIImage imageWithName:icon];
        [self setImage:image forState:UIControlStateNormal];
    }
}
@end

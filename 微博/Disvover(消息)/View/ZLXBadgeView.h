//
//  ZLXBadgeView.h
//  微博
//
//  Created by Lixin Zhou on 2017/1/17.
//  Copyright © 2017年 Lixin Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLXBadgeView : UIButton
@property(nonatomic,copy) NSString *badgeValue;
+ (instancetype) badgeView;
@end

//
//  ZLXStatusToolBar.h
//  微博
//
//  Created by Lixin Zhou on 2016/12/28.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZLXStatus;
@interface ZLXStatusToolBar : UIView
+ (instancetype) StatusToolBarWithView;
@property (nonatomic,strong) ZLXStatus *status;
@end

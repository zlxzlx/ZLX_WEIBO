//
//  ZLXStatusReweetedFrame.h
//  微博
//
//  Created by Lixin Zhou on 2016/12/28.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZLXStatus;

@interface ZLXStatusReweetedFrame : NSObject
@property (nonatomic,assign) CGRect nameFrame;
@property (nonatomic,assign) CGRect textFrame;
@property (nonatomic,assign) CGRect frame;
@property (nonatomic,strong) ZLXStatus *retweetedStatus;
/** 配图*/
@property (nonatomic,assign) CGRect photoFrame;
@end

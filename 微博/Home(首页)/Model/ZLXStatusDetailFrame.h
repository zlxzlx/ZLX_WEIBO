//
//  ZLXStatusDetailFrame.h
//  微博
//
//  Created by Lixin Zhou on 2016/12/28.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZLXStatusOriginalFrame,ZLXStatusReweetedFrame,ZLXStatus;
@interface ZLXStatusDetailFrame : NSObject
@property (nonatomic,strong) ZLXStatusOriginalFrame *originalFrame;
@property (nonatomic,strong) ZLXStatusReweetedFrame *retweetedFrame;
@property (nonatomic,assign) CGRect frame;
/** 微博数据*/
@property (nonatomic,strong) ZLXStatus *detailStatus;
@end

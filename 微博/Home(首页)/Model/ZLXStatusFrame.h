//
//  ZLXStatusFrame.h
//  微博
//
//  Created by Lixin Zhou on 2016/12/28.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZLXStatus,ZLXStatusDetailFrame;
@interface ZLXStatusFrame : NSObject
/** 
子控件的frame
 */
@property (nonatomic,assign) CGRect toolbarFrame;
@property (nonatomic,strong) ZLXStatusDetailFrame *detailFrame;
/** 
 数据
 */
@property (nonatomic,strong) ZLXStatus *status;
/** cell的高度*/
@property (nonatomic,assign) CGFloat cellHeight;
@end

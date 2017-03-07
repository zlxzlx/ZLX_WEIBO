//
//  ZLXStatusPhotosView.h
//  微博
//
//  Created by Lixin Zhou on 2016/12/30.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLXStatusPhotosView : UIView
+ (CGSize) sizeWithPhotosCount:(NSInteger) photosCount;
@property (nonatomic,strong) NSArray *pic_urls;
@end

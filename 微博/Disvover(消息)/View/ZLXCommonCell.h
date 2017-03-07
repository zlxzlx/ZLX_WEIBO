//
//  ZLXCommonCell.h
//  微博
//
//  Created by Lixin Zhou on 2017/1/16.
//  Copyright © 2017年 Lixin Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZLXCommonItem;
@interface ZLXCommonCell : UITableViewCell
@property (nonatomic,strong) ZLXCommonItem *item;
- (void) setIndexPath:(NSIndexPath *)indexPath numberOfRowsInSection:(NSInteger) numbers;
+ (instancetype) cellWithTableView:(UITableView *) tabbleView;
@end

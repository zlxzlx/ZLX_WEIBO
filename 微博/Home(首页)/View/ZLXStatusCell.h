//
//  ZLXStatusCell.h
//  微博
//
//  Created by Lixin Zhou on 2016/12/28.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZLXStatusFrame;
@interface ZLXStatusCell : UITableViewCell
+ (instancetype) cellWithTableview:(UITableView *) tableView;
@property (nonatomic,strong) ZLXStatusFrame *statusFrame;
@end

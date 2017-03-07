//
//  ZLXStatusCell.m
//  微博
//
//  Created by Lixin Zhou on 2016/12/28.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXStatusCell.h"
#import "ZLXStatusDetailView.h"
#import "ZLXStatusToolBar.h"
#import "ZLXStatusDetailFrame.h"
#import "ZLXStatusFrame.h"
@interface ZLXStatusCell ()
@property (nonatomic,weak) ZLXStatusDetailView *DetailView;
@property (nonatomic,weak) ZLXStatusToolBar *ToolBar;
@end
@implementation ZLXStatusCell

+ (instancetype) cellWithTableview:(UITableView *)tableView{
    static NSString *cellID = @"cellID";
    id cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}
- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupDetailView];
        [self setupToolBar];
    }
    return  self;
}
- (void) setupDetailView{
    ZLXStatusDetailView *DetailView = [[ZLXStatusDetailView alloc] init];
    [self.contentView addSubview:DetailView];
    self.DetailView = DetailView;
}
- (void) setupToolBar{
    ZLXStatusToolBar *ToolBar = [ZLXStatusToolBar StatusToolBarWithView];
    [self.contentView addSubview:ToolBar];
    self.ToolBar = ToolBar;
}
- (void) setStatusFrame:(ZLXStatusFrame *)statusFrame{
    _statusFrame = statusFrame;
    self.DetailView.DetailFrame = statusFrame.detailFrame;
    self.ToolBar.frame = statusFrame.toolbarFrame;
    self.ToolBar.status = statusFrame.status;
}
@end

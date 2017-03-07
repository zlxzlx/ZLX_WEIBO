//
//  ZLXDiscoverController.m
//  微博
//
//  Created by Lixin Zhou on 2016/12/22.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXCommonController.h"
#import "ZLXCommonItem.h"
#import "ZLXCommonGroup.h"
#import "ZLXCommonCell.h"
@interface ZLXCommonController ()
@end

@implementation ZLXCommonController
- (NSMutableArray *) groups{
    if (_groups == nil) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor colorWithRed:211 / 255.0 green:211 / 255.0 blue:211 / 255.0 alpha:1.0];
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //初始化数据
}
- (instancetype) init{
    return [self initWithStyle:UITableViewStyleGrouped];
}
#pragma mark - Table view data source
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return self.groups.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ZLXCommonGroup *group = self.groups[section];
    return group.items.count;
}
- (void) scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.navigationController.view endEditing:YES];
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZLXCommonCell *cell = [ZLXCommonCell cellWithTableView:tableView];
    /** 取出模型
     */
    ZLXCommonGroup *group = self.groups[indexPath.section];
    cell.item = group.items[indexPath.row];
    [cell setIndexPath:indexPath numberOfRowsInSection:group.items.count];
    return cell;
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZLXCommonGroup *group = self.groups[indexPath.section];
    ZLXCommonItem *item = group.items[indexPath.row];
    if (item.operation) {
        item.operation();
    }
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 52;
}
@end

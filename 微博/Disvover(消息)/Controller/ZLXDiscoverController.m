//
//  ZLXDiscoverController.m
//  微博
//
//  Created by Lixin Zhou on 2016/12/22.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXDiscoverController.h"
#import "ZLXTextField.h"
#import "ZLXCommonItem.h"
#import "ZLXCommonGroup.h"
#import "ZLXCommonCell.h"
#import "ZLXCommonArrowItem.h"
#import "ZLXCommonSwitch.h"
#import "ZLXCommonLabelItem.h"
@interface ZLXDiscoverController ()
@property (nonatomic,weak) ZLXTextField *searchBar;
@property (nonatomic,weak) UIView *headerView;
@end

@implementation ZLXDiscoverController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发现";
    /** 添加搜索框
     */
    ZLXTextField *searchBar = [[ZLXTextField alloc] init];
    self.searchBar = searchBar;
    self.navigationItem.titleView = searchBar;
    self.tableView.backgroundColor = [UIColor colorWithRed:211 / 255.0 green:211 / 255.0 blue:211 / 255.0 alpha:1.0];
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //初始化数据
    [self setupGroup];
}
- (void) setupGroup{
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
}
- (void)setupGroup0{
    ZLXCommonGroup *group0 = [ZLXCommonGroup group];
    [self.groups addObject:group0];
    ZLXCommonArrowItem *hotStatus = [ZLXCommonArrowItem itemWithTitle:@"热门微博" icon:@"hot_status"];
    hotStatus.subtitle = @"笑话，娱乐";
    hotStatus.operation = ^{
        UITableViewController *vc = [[UITableViewController alloc] init];
        vc.view.backgroundColor = [UIColor purpleColor];
        [self.navigationController pushViewController:vc animated:YES];
    };
    ZLXCommonArrowItem *findPeople = [ZLXCommonArrowItem itemWithTitle:@"找人" icon:@"find_people"];
    findPeople.subtitle = @"名人，有意思的人尽在这里";
    group0.items = @[hotStatus,findPeople];
}
- (void) setupGroup1{
    ZLXCommonGroup *group1 = [ZLXCommonGroup group];
    [self.groups addObject:group1];
    ZLXCommonItem *game = [ZLXCommonItem itemWithTitle:@"游戏中心" icon:@"game_center"];
    game.badgeValue = @"10";
    ZLXCommonItem *periphery = [ZLXCommonItem itemWithTitle:@"周边" icon:@"near"];
    ZLXCommonItem *application = [ZLXCommonItem itemWithTitle:@"应用" icon:@"app"];
    group1.items = @[game,periphery,application];
}
- (void) setupGroup2{
    ZLXCommonGroup *group2 = [ZLXCommonGroup group];
    [self.groups addObject:group2];
    ZLXCommonSwitch *move = [ZLXCommonSwitch itemWithTitle:@"电影" icon:@"movie"];
    ZLXCommonLabelItem *music = [ZLXCommonLabelItem itemWithTitle:@"音乐" icon:@"movie-1"];
    ZLXCommonSwitch *video = [ZLXCommonSwitch itemWithTitle:@"视频" icon:@"video"];
    ZLXCommonItem *near = [ZLXCommonItem itemWithTitle:@"附近" icon:@"near"];
    ZLXCommonArrowItem *more = [ZLXCommonArrowItem itemWithTitle:@"更多" icon:@"more"];
    more.badgeValue = @"10000";
    more.operation = ^{
        UIViewController *vc = [[UIViewController alloc] init];
        vc.title = @"热门微博";
        vc.view.backgroundColor = [UIColor redColor];
        [self.navigationController pushViewController:vc animated:YES];
    };
    group2.items = @[move,music,video,near,more];
}
@end

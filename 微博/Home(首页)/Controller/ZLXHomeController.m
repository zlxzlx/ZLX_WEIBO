//
//  ZLXHomeController.m
//  微博
//
//  Created by Lixin Zhou on 2016/12/22.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXHomeController.h"
#import "ZLXAccountTool.h"
#import "ZLXAccount.h"
#import "ZLXStatus.h"
#import "ZLXUser.h"
#import "ZLXPicture.h"
#import "ZLXStatusResult.h"
#import "ZLXParameter.h"
#import "ZLXStatusDataTool.h"
#import "ZLXUserInfoResult.h"
#import "ZLXUserParameter.h"
#import "ZLXUserTool.h"
#import "ZLXStatusCell.h"
#import "ZLXStatusFrame.h"
#import <SafariServices/SafariServices.h>
#import "ZLXStatusDetailViewController.h"
#import "ZLXStatusDetailFrame.h"
@interface ZLXHomeController ()<SFSafariViewControllerDelegate>
@property (nonatomic,strong) NSMutableArray *statusFrames;
@end

@implementation ZLXHomeController
- (NSMutableArray *) statusFrames{
    if (_statusFrames == nil) {
        _statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RefreshData) name:ZLXTabBarButtonDidRepeatClickNotification object:nil];
    [self setupTabelViewData];
    [self setupUserInfo];
    [self setupNavigationBar];
    /** 注册点击超链接的通知*/
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LinkClick:) name:ZLXLinkDidSelectedNotification object:nil];
}
- (void) LinkClick:(NSNotification *) note{
    NSString *link = note.userInfo[ZLXLinkText];
    if ([link hasPrefix:@"http"]) {
        SFSafariViewController *safarVC = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:link]];
        safarVC.navigationItem.title = @"网页浏览";
        safarVC.hidesBottomBarWhenPushed = YES;
        safarVC.delegate = self;
        safarVC.view.backgroundColor = [UIColor whiteColor];
        [self.navigationController pushViewController:safarVC animated:YES];
    }else{
        
        
    }
}
- (void) setupNavigationBar{
    UIButton *leftBtn = [[UIButton alloc] init];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_more"] forState:UIControlStateNormal];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] forState:UIControlStateHighlighted];
    [leftBtn sizeToFit];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    UIButton *rightBtn = [[UIButton alloc] init];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_pop"] forState:UIControlStateNormal];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"navigationbar_pop_highlighted"] forState:UIControlStateHighlighted];
    [rightBtn sizeToFit];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}
- (void) setupTabelViewData{
    self.tableView.backgroundColor = [UIColor colorWithRed:211 / 255.0 green:211 / 255.0 blue:211 / 255.0 alpha:1.0];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadNewData];
    }];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
- (void) click{
    NSLog(@"点击了");
}
- (void) RefreshData{
    if (self.tableView.window == nil) return;
    if (self.tableView.scrollsToTop == NO) return;
    [self.tableView.mj_header beginRefreshing];
}
- (void) loadNewData{
    ZLXParameter *parameter = [[ZLXParameter alloc] init];
    parameter.access_token = [ZLXAccountTool TakeoutAccount].access_token;
    ZLXStatusFrame *firstStatusFrame = [self.statusFrames firstObject];
    ZLXStatus *firststatus = firstStatusFrame.status;
    if (firststatus) {
        parameter.since_id = @([firststatus.idstr longLongValue]);
    }
    //加载微博数据
    [ZLXStatusDataTool  HomeStatusesWithParam:parameter success:^(ZLXStatusResult *result) {
        NSArray *newStatus = result.statuses;
        /** 将微博数组转成视图数组*/
       NSArray *newFrames = [self statusFramesWithStatuses:newStatus];
        NSRange range = NSMakeRange(0, newFrames.count);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statusFrames insertObjects:newFrames atIndexes:indexSet];
        [self showNewStatusesCount:newFrames.count];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self showNewStatusesCount:403];
        NSLog(@"%@",error);
    }];
}
/** 根据微博数据，转成frame数组*/
- (NSArray *) statusFramesWithStatuses:(NSArray *) statuses{
    /** 将数据模型转成视图模型*/
    NSMutableArray *frames = [NSMutableArray array];
    for (ZLXStatus *status in statuses) {
        ZLXStatusFrame *frame = [[ZLXStatusFrame alloc] init];
        frame.status = status;
        [frames addObject:frame];
    }
    return frames;
}
- (void) loadMoreData{
    ZLXParameter *parameter = [[ZLXParameter alloc] init];
    parameter.access_token = [ZLXAccountTool TakeoutAccount].access_token;
    ZLXStatusFrame *lastStatusFrame = [self.statusFrames lastObject];
    ZLXStatus *lastStatus = lastStatusFrame.status;
    if (lastStatus) {
        parameter.max_id = @([lastStatus.idstr longLongValue] - 1);
    }
    //加载数据
    [ZLXStatusDataTool HomeStatusesWithParam:parameter success:^(ZLXStatusResult *result) {
        NSArray *array = result.statuses;
        NSArray *oldFrames = [self statusFramesWithStatuses:array];
        [self.statusFrames addObjectsFromArray:oldFrames];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        if (array.count == 0) {
            [SVProgressHUD showImage:nil status:@"没有更多数据了"];
        }
    } failure:^(NSError *error) {
        
    }];
//    [ZLXStatusDataTool HomeStatusesWithParam:<#(ZLXParameter *)#> success:<#^(ZLXStatusResult *result)success#> failure:<#^(NSError *error)failure#>]
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statusFrames.count;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZLXStatusCell *cell = [ZLXStatusCell cellWithTableview:tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ZLXStatusFrame *statusFrame = self.statusFrames[indexPath.row];
    cell.statusFrame = statusFrame;
    return cell;
}
/** 刷新数字提示Label*/
- (void) showNewStatusesCount:(NSInteger) count{
    UILabel *label = [[UILabel alloc] init];
    if (count) {
        label.text = [NSString stringWithFormat:@"已经加载了%zd条微博",count];
        label.textColor = [UIColor whiteColor];
    }else{
        label.text = @"没有更多微博数据";
        label.textColor = [UIColor whiteColor];
    }
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor orangeColor];
    label.width = ZLXScreenW;
    label.height = 35;
    label.x = 0;
    label.y = CGRectGetMaxY(self.navigationController.navigationBar.frame) - label.height;
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    //动画平移
    [UIView animateWithDuration:0.25 animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25 delay:2.0 options:UIViewAnimationOptionCurveLinear animations:^{
            //还原
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            label.hidden = YES;
        }];
    }];
}
- (void) setupUserInfo{
 [ZLXUserTool UserInfoWithsuccess:^(ZLXUserInfoResult *result) {
     UIButton *button = [[UIButton alloc] init];
     [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     self.navigationItem.titleView = button;
     [button setTitle:result.name forState:UIControlStateNormal];
     button.titleLabel.font = [UIFont boldSystemFontOfSize:20];
     [button sizeToFit];
 } failure:^(NSError *error) {
 }];
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZLXStatusFrame *frame = self.statusFrames[indexPath.row];
    return frame.cellHeight;
}
- (void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZLXStatusDetailViewController *Detailvc = [[ZLXStatusDetailViewController alloc] init];
    ZLXStatusFrame *statusFrame = self.statusFrames[indexPath.row];
    Detailvc.status = statusFrame.detailFrame.detailStatus;
    [self.navigationController pushViewController:Detailvc animated:YES];
}
- (void) scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [[SDImageCache sharedImageCache]clearMemory];
}
- (void) didReceiveMemoryWarning{

}
@end

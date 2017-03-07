//
//  ZLXDiscoverController.m
//  微博
//
//  Created by Lixin Zhou on 2016/12/22.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXProfileController.h"
#import "ZLXCommonItem.h"
#import "ZLXCommonGroup.h"
#import "ZLXCommonCell.h"
#import "ZLXCommonArrowItem.h"
#import "ZLXCommonSwitch.h"
#import "ZLXCommonLabelItem.h"
#import <UIImageView+WebCache.h>
#import "ZLXAccountTool.h"
@interface ZLXProfileController ()
@end

@implementation ZLXProfileController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我";
    self.tableView.backgroundColor = [UIColor colorWithRed:211 / 255.0 green:211 / 255.0 blue:211 / 255.0 alpha:1.0];
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleDone target:self action:@selector(click)];
    self.navigationItem.rightBarButtonItem = item;
    //初始化数据
    [self setupGroup];
    
}
- (void) click{
    
    
    
}
- (void) setupGroup{
    [self setupGroup0];
    [self setupGroup1];
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
    /** 清除缓存*/
    ZLXCommonItem *clearCache = [ZLXCommonItem itemWithTitle:@"点击清除图片缓存"];
    ZLXCommonItem *account = [ZLXCommonItem itemWithTitle:@"退出账号"];
    account.operation = ^{
        [SVProgressHUD showWithStatus:@"正在从沙盒中删除你所保存的账号信息，请稍后..."];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [ZLXAccountTool deleteAccountInfomation];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD showSuccessWithStatus:@"已成功退出账号"];
            });
        });
//        ;
    };
    group1.items = @[game,periphery,application,clearCache,account];
    //计算整个应用程序的缓存
    /** 获取缓存路径*/
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
//    NSLog(@"%@",caches);
    [caches stringByAppendingPathComponent:@"com.hackemist.SDWebImageCache.default"];
    NSInteger size = [SDImageCache sharedImageCache].getSize;
    NSString *sizeStr = [self CalculateThecache:size];
    clearCache.subtitle = sizeStr;
    [self.tableView reloadData];
    clearCache.operation = ^{
        //清除图片缓存
        [SVProgressHUD showWithStatus:@"正在清除缓存..."];
        [self clearCache:caches];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD showSuccessWithStatus:@"缓存已清除"];
                clearCache.subtitle = @"(0.0M)";
                [self.tableView reloadData];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
            });
        });
    };
}
- (NSString *) CalculateThecache:(NSInteger) size{
   NSString *sizeStr = @"缓存";
    if (size > 1000 * 1000) {
        //MB
        CGFloat sizeF = size / 1000.0 / 1000.0;
        sizeStr = [NSString stringWithFormat:@"%@(%0.1fMB)",sizeStr,sizeF];
    }else if(size > 1000){
        //KB
        CGFloat sizeF = size / 1000.0;
        sizeStr = [NSString stringWithFormat:@"%@(%0.1fKB)",sizeStr,sizeF];
    }else if (size > 0){
        //B
        sizeStr = [NSString stringWithFormat:@"%@(%0.ldB)",sizeStr,size];
    }
    return sizeStr;
}
-(void)clearCache:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
    [[SDImageCache sharedImageCache] cleanDisk];
}
@end

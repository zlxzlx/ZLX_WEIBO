//
//  ZLXMessageController.m
//  微博
//
//  Created by Lixin Zhou on 2016/12/22.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXMessageController.h"
@interface ZLXMessageController ()

@end

@implementation ZLXMessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息";
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"更多" style:UIBarButtonItemStylePlain target:self action:@selector(click)];
    self.navigationItem.rightBarButtonItem = item;
}
- (void) click{
    NSLog(@"点按有效");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}


@end

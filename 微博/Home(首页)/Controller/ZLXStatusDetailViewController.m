//
//  ZLXStatusDetailViewController.m
//  微博
//
//  Created by Lixin Zhou on 2017/1/18.
//  Copyright © 2017年 Lixin Zhou. All rights reserved.
//

#import "ZLXStatusDetailViewController.h"
#import "ZLXStatusDetailFrame.h"
#import "ZLXStatusDetailView.h"
#import "ZLXStatus.h"
#import "ZLXStatusToolBar.h"
#import "ZLXStatusDetailBottomBar.h"
#import "ZLXStatusDetailTopBar.h"
#import "ZLXComments.h"
#import "ZLXStatusDataTool.h"
#import "ZLXCommentParam.h"
#import "ZLXAccountTool.h"
#import "ZLXAccount.h"
#import "ZLXComments.h"
#import "ZLXReweetParam.h"
#import "ZLXReweentResult.h"
@interface ZLXStatusDetailViewController ()<UITableViewDelegate,UITableViewDataSource,ZLXStatusDetailTopBarDelegate>
@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,strong) ZLXStatusDetailTopBar *topBar;
@property (nonatomic,strong) NSMutableArray *ReweentArray;
@property (nonatomic,strong) NSMutableArray *CommentArray;
@end

@implementation ZLXStatusDetailViewController
/** 转发*/
- (NSMutableArray *) ReweentArray{
    if (_ReweentArray == nil) {
        _ReweentArray = [NSMutableArray array];
    }
    return _ReweentArray;
}
/** 评论*/
- (NSMutableArray *) CommentArray{
    if (_CommentArray == nil) {
        _CommentArray = [NSMutableArray array];
    }
    return _CommentArray;
}
- (ZLXStatusDetailTopBar *) topBar{
    if (_topBar == nil) {
        _topBar = [ZLXStatusDetailTopBar initWithXib];
    }
    return _topBar;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"微博正文";
    self.view.backgroundColor = [UIColor purpleColor];
    /** 初始化tableview*/
    [self setupTableView];
    /** 头视图*/
    [self setupHeaderView];
    self.topBar.backgroundColor = [UIColor whiteColor];
    self.topBar.delegate = self;
    self.topBar.status = self.status;
    /** 底部工具栏*/
    [self setupBottomToolBar];
}
- (void) setupBottomToolBar{
    ZLXStatusDetailBottomBar *bottomBar = [ZLXStatusDetailBottomBar initWithStatusDetailBottomBar];
    [self.view addSubview:bottomBar];
    bottomBar.width = self.view.width;
    bottomBar.height = 40;
    bottomBar.x = 0;
    bottomBar.y = self.view.height - bottomBar.height;
}
- (void) setupTableView{
    UITableView *tableView = [[UITableView alloc] init];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.width = self.view.width;
    tableView.height = self.view.height - 40;
    self.tableView = tableView;
    [self.view addSubview:tableView];
    tableView.backgroundColor = [UIColor whiteColor];
}
- (void) setupHeaderView{
    ZLXStatusDetailView *detailView = [[ZLXStatusDetailView alloc] init];
    ZLXStatusDetailFrame *frame = [[ZLXStatusDetailFrame alloc] init];
    frame.detailStatus = self.status;
    detailView.DetailFrame = frame;
    detailView.height = frame.frame.size.height;
    UIView *headerView = [[UIView alloc] init];
    [headerView addSubview:detailView];
    ZLXStatusToolBar *toolBarView = [ZLXStatusToolBar StatusToolBarWithView];
    toolBarView.status = self.status;
    toolBarView.x = [UIScreen mainScreen].bounds.size.width / 2;
    toolBarView.y = CGRectGetMaxY(detailView.frame);
    toolBarView.width = detailView.width - [UIScreen mainScreen].bounds.size.width / 2;
    toolBarView.height = 35;
    [headerView addSubview:toolBarView];
    headerView.height = CGRectGetMaxY(toolBarView.frame);
    self.tableView.tableHeaderView = headerView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - Table view data source
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.topBar.selectedButtonType == ZLXStatusDetailTopBarButtonTypeComment) {//评论
        return self.CommentArray.count;
    }else {
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    if (self.topBar.selectedButtonType == ZLXStatusDetailTopBarButtonTypeComment) {//评论
        ZLXComments *comments = self.CommentArray[indexPath.row];
        cell.textLabel.text = comments.text;
    }else if(self.topBar.selectedButtonType == ZLXStatusDetailTopBarButtonTypeReweet){
 
    }
    return cell;
}
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.topBar;
}
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return self.topBar.height;
}
/** 实现顶部按钮的代理方法*/
- (void) topToolbar:(ZLXStatusDetailTopBar *)toopToolbar didselctedButton:(ZLXStatusDetailTopBarButtonType)buttonType{
    switch (buttonType) {
        case ZLXStatusDetailTopBarButtonTypeComment:
            [self loadComments];
            break;
        case ZLXStatusDetailTopBarButtonTypeReweet:
            [self loadReweents];
            break;
    }
}
/** 加载评论按钮*/
- (void) loadComments{
    /** 加载数据评论数据*/
    NSLog(@"点击了评论按钮");
    ZLXCommentParam *param = [ZLXCommentParam param];
    param.access_token = [ZLXAccountTool TakeoutAccount].access_token;
    param.ID = self.status.idstr;
    ZLXComments *comments = [self.CommentArray firstObject];
    param.since_id = comments.idstr;
    [ZLXStatusDataTool CommentsWithParam:param success:^(ZLXCommentResult *result) {
        self.status.comments_count = result.total_number;
        self.topBar.status = self.status;
    NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, result.comments.count)];
    [self.CommentArray insertObjects:result.comments atIndexes:set];
    [self.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
/** 加载转发按钮*/
- (void) loadReweents{

}
@end

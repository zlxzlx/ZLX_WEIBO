//
//  ZLXOAuthController.m
//  微博
//
//  Created by Lixin Zhou on 2016/12/23.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXOAuthController.h"
#import "ZLXMainViewController.h"
#import "ZLXNewFeatureController.h"
#import "ZLXAccount.h"
#import "ZLXAccountTool.h"
#import "ZLXNewFeature.h"
@interface ZLXOAuthController ()<UIWebViewDelegate>
@end
@implementation ZLXOAuthController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadWebData];
}
- (void) loadWebData{
    UIWebView *webView = [[UIWebView alloc] init];
    webView.delegate = self;
    webView.frame = self.view.bounds;
    [self.view addSubview:webView];
    NSString *strUrl = @"https://api.weibo.com/oauth2/authorize?client_id=234311963&redirect_uri=https://123.sogou.com";
    NSURL *url = [NSURL URLWithString:strUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}
- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    //请求的url路径
    NSString *urlstr = request.URL.absoluteString;
    NSRange range = [urlstr rangeOfString:@"code="];
    if (range.length) {
        NSInteger loc = range.length + range.location;
        NSString *code = [urlstr substringFromIndex:loc];
        [self takeupDataWith:code];
    }
    return YES;
}
- (void) webViewDidStartLoad:(UIWebView *)webView{
    [SVProgressHUD showWithStatus:@"正在加载"];
}
- (void) webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismiss];
}
- (void) takeupDataWith:(NSString *) code{
    //封装请求参数
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"client_id"] = @"234311963";
    dic[@"client_secret"] = @"f493a4b7dd89792309e9afc259cb66fc";
    dic[@"grant_type"] = @"authorization_code";
    dic[@"code"] = code;
    dic[@"redirect_uri"] = @"https://123.sogou.com";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:@"https://api.weibo.com/oauth2/access_token" parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        ZLXAccount *account = [ZLXAccount mj_objectWithKeyValues:responseObject];
        [ZLXAccountTool SaveAccount:account];
        //切换版本新特性
        [ZLXNewFeature Judgeversionnumber];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
    }];
}
@end

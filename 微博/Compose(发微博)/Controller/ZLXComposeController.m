//
//  ZLXComposeController.m
//  微博
//
//  Created by Lixin Zhou on 2016/12/26.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//
#import "ZLXComposeController.h"
#import "ZLXEmotionTextView.h"
#import "ZLXToolBar.h"
#import "ZLXCompose.h"
#import "ZLXAccountTool.h"
#import "ZLXAccount.h"
#import "ZLXEmotionKeyboard.h"
#import "ZLXEmotionModel.h"
#import "ZLXEmotionGridView.h"
#import "ZLXEmotionView.h"
#import "ZLXAccount.h"
#import "ZLXUserTool.h"
@interface ZLXComposeController ()<UITextViewDelegate,ZLXToolBarDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,weak) ZLXEmotionTextView *textView;
@property (nonatomic,weak) UIButton *Rightbutton;
@property (nonatomic,weak) ZLXToolBar *ToolBar;
@property (nonatomic,weak) ZLXCompose *photoView;
@property (nonatomic,strong) ZLXEmotionKeyboard *keyboard;
@end

@implementation ZLXComposeController

- (ZLXEmotionKeyboard *) keyboard{
    if (_keyboard == nil) {
        _keyboard = [ZLXEmotionKeyboard keyboard];
    }
    return _keyboard;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNavBar];
    /**添加输入view */
    [self setupTextView];
    [self setupToolBar];
    /** 图片view*/
    [self setupPhotosView];
    /** 监听键盘*/
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyBoradWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyBoradWillHide:) name:UIKeyboardWillHideNotification object:nil];
    /** 监听通知*/
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ZLX_selectedDidEmotion:) name:ZLXEmotionDidSelectedNotification object:nil];
    /** 键盘删除按钮的通知*/
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteDidEmotion:) name:ZLXEmotionDidDeleteNotification object:nil];
}
- (void) ZLX_selectedDidEmotion:(NSNotification *) notification{
    ZLXEmotionModel *emotion = notification.userInfo[ZLXSelectedEmotion];
//    NSLog(@"%@",emotion);
    /** 拼接表情*/
    [self.textView appendEmotion:emotion];
//    [self textViewDidChange:self.textView];
}
- (void) deleteDidEmotion:(NSNotification *) notification{
//    NSLog(@"删除按钮的通知是否监听到");
    [self.textView deleteBackward];
    
}
/** 键盘即将出现*/
- (void) KeyBoradWillShow:(NSNotification *) notification{
    //键盘弹出需要的时间
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    //动画
    [UIView animateWithDuration:duration animations:^{
        CGRect keyBoardF = [notification.userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
        CGFloat keyBoardH = keyBoardF.size.height;
        self.ToolBar.transform = CGAffineTransformMakeTranslation(0, -keyBoardH);
    }];
}
/** 键盘即将消失*/
- (void) KeyBoradWillHide:(NSNotification *) notificaiton{
    CGFloat duration = [notificaiton.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    //动画
    [UIView animateWithDuration:duration animations:^{
        self.ToolBar.transform = CGAffineTransformIdentity;
    }];
}
- (void) setupNavBar{
    [ZLXUserTool UserInfoWithsuccess:^(ZLXUserInfoResult *result) {
        if (result.name) {
            NSString *prefix = @"发微博";
            NSString *name = result.name;
            UILabel *titleLabel = [[UILabel alloc] init];
            self.navigationItem.titleView = titleLabel;
            NSString *text = [NSString stringWithFormat:@"%@\n%@",prefix,name];
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:text];
            [string addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:20] range:[text rangeOfString:prefix]];
            [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:[text rangeOfString:name]];
            [string addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:[text rangeOfString:prefix]];
            [string addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:[text rangeOfString:name]];
            titleLabel.attributedText = string;
            titleLabel.numberOfLines = 0;
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.width = 100;
            titleLabel.height = 44;
        }else{
            self.title = @"发微博";
        }
    } failure:^(NSError *error) {
    }];
    UIButton *Leftbutton = [[UIButton alloc] init];
    [Leftbutton setTitle:@"取消" forState:UIControlStateNormal];
    Leftbutton.titleLabel.font = [UIFont systemFontOfSize:20];
    [Leftbutton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [Leftbutton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [Leftbutton sizeToFit];
    UIBarButtonItem *Leftitem = [[UIBarButtonItem alloc] initWithCustomView:Leftbutton];
    self.navigationItem.leftBarButtonItem = Leftitem;
    [Leftbutton addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(sendText)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}
- (void) sendText{
    if (self.photoView.images.count) {
        [self sendStatusWithImage];
    }else{
        [self sendStatusWithoutImage];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void) sendStatusWithImage{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"access_token"] = [ZLXAccountTool TakeoutAccount].access_token;
    parameters[@"status"] = self.textView.realText;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        UIImage *image = [self.photoView.images firstObject];
        NSData *data = UIImageJPEGRepresentation(image, 0.35);
        [formData appendPartWithFileData:data name:@"pic" fileName:@"status.jpg" mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD showSuccessWithStatus:@"发送成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [SVProgressHUD showErrorWithStatus:@"发送失败"];
    }];
}
- (void) sendStatusWithoutImage{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"access_token"] = [ZLXAccountTool TakeoutAccount].access_token;
    parameters[@"status"] = self.textView.realText;
    [manager POST:@"https://api.weibo.com/2/statuses/update.json" parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD showSuccessWithStatus:@"发送成功"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"发送失败"];
        NSLog(@"%@",error);
    }];
}
- (void) setupTextView{
    ZLXEmotionTextView *textView = [[ZLXEmotionTextView alloc] init];
    textView.delegate = self;
    textView.alwaysBounceVertical = YES;
    self.textView = textView;
    self.textView.backgroundColor = [UIColor whiteColor];
    textView.x = 0;
    textView.y = 0;
    textView.width = self.view.width;
    textView.height = self.view.height;
    [self.view addSubview:textView];
    //设置站位文字
    textView.placeholder = @"分享新鲜事...";
    textView.placeholderColor = [UIColor lightGrayColor];
}
- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    /** 第一响应者*/
    [self.textView becomeFirstResponder];
}
- (void) composeTool:(ZLXToolBar *)toolbar didClickedButton:(ZLXComposeToolbarButtonType)buttonType{
    switch (buttonType) {
        case ZLXComposeToolbarButtonTypeCamera:
            [self openCamera];//摄像头
            break;
        case ZLXComposeToolbarButtonTypePicture:
            [self openAlbum];//相册
            break;
        case ZLXComposeToolbarButtonTypeMetion:
            NSLog(@"点击的是@");
            break;
        case ZLXComposeToolbarButtonTypeTrend:
            break;
        case ZLXComposeToolbarButtonTypeEmotion:
            [self openEmotion];//表情
            break;
        default:
            break;
    }
}
- (void) cancle{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
/** 设置工具栏*/
- (void) setupToolBar{
    ZLXToolBar *ToolBar = [[ZLXToolBar alloc] init];
    self.ToolBar = ToolBar;
    ToolBar.delegate = self;
    ToolBar.width = self.view.width;
    ToolBar.height = 44;
    ToolBar.y = self.view.height - ToolBar.height;
    [self.view addSubview:ToolBar];
}
- (void) scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}
- (void) openCamera{
    UIImagePickerController *picVC = [[UIImagePickerController alloc] init];
    picVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    picVC.delegate = self;
    [self presentViewController:picVC animated:YES completion:nil];
}
- (void) openAlbum{
    UIImagePickerController *pic = [[UIImagePickerController alloc] init];
    pic.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pic.delegate = self;
    [self presentViewController:pic animated:YES completion:nil];
}
- (void) textViewDidChangeSelection:(UITextView *)textView{
    CGPoint cursorPosition = [textView caretRectForPosition:textView.selectedTextRange.start].origin;
    self.photoView.y = cursorPosition.y + 35;
    if (textView.attributedText.length == 0) {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }else{
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
}
#pragma mark -- 实现代理方法
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    //取出选中的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.photoView addImage:image];
}
- (void) setupPhotosView{
    ZLXCompose *photoView = [[ZLXCompose alloc] init];
    self.photoView = photoView;
    photoView.y = 70;
    photoView.width = self.view.width;
    photoView.height = self.view.height;
    [self.textView addSubview:photoView];
}
- (void) openEmotion{
    if (self.textView.inputView) {
        self.textView.inputView = nil;
        self.ToolBar.ShowEmtionButton = YES;
    }else{
        self.keyboard.bounds = CGRectMake(0, 0, ZLXScreenW, 258);
        self.textView.inputView = self.keyboard;
        self.ToolBar.ShowEmtionButton = NO;
    }
    //关闭键盘
    [self.textView resignFirstResponder];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //打开键盘
        [self.textView becomeFirstResponder];
    });
}
/** 移除通知*/
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end

//
//  ZLXTextField.m
//  微博
//
//  Created by Lixin Zhou on 2016/12/22.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXTextField.h"
@implementation ZLXTextField
- (instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.placeholder = @"热门搜索";
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.width = 300;
        self.height = 35;
        self.background = [UIImage resizedImage:@"searchbar_textfield_background"];
        //设置左边显示放大镜
        UIImageView *leftView = [[UIImageView alloc] init];
        leftView.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        leftView.width = self.height;
        leftView.height = self.height;
        /** UIview的属性*/
        leftView.contentMode = UIViewContentModeCenter;
        //设置左边永远显示
        self.leftView = leftView;
        self.leftViewMode = UITextFieldViewModeAlways;
        //设置右边永远显示清除按钮
        self.clearButtonMode = UITextFieldViewModeAlways;
        self.tintColor = [UIColor purpleColor];
        NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
        attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
        attrs[NSFontAttributeName] = [UIFont systemFontOfSize:13];
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attrs];
//        //监听文本框编辑:代理(不要自己成为自己的代理，一对一) 通知（一对多） ，target
//        [self addTarget:self action:@selector(textBegin) forControlEvents:UIControlEventEditingDidBegin];
//        //结束监听
//        [self addTarget:self action:@selector(textEnd) forControlEvents:UIControlEventEditingDidEnd];
//        //获取TextField中占位文字的label
//        UILabel *placeholderLabel = [self valueForKey:@"placeholderLabel"];
//        placeholderLabel.textColor = [UIColor grayColor];
    }
    return self;
}
////文本框开始编辑的时候调用该方法
//- (void) textBegin{
//    //设置占位文字颜色变成白色
//    UILabel *placeholderLabel = [self valueForKey:@"placeholderLabel"];
//    placeholderLabel.textColor = [UIColor whiteColor];
//    //    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    //    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    //    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:13];
//    //    self.attributedPlaceholder = [[NSAttributedString alloc]initWithString:self.placeholder attributes:attrs];
//}
////结束监听
//- (void) textEnd{
//    //恢复占位文字的颜色
//    UILabel *placeholderLabel = [self valueForKey:@"placeholderLabel"];
//    placeholderLabel.textColor = [UIColor grayColor];
//    //    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    //    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
//    //    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:13];
//    //    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attrs];
//}
@end

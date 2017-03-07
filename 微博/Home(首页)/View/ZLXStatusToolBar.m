//
//  ZLXStatusToolBar.m
//  微博
//
//  Created by Lixin Zhou on 2016/12/28.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXStatusToolBar.h"
#import "ZLXStatus.h"
@interface ZLXStatusToolBar ()
@property (weak, nonatomic) IBOutlet UIButton *LikeBtn;
@property (weak, nonatomic) IBOutlet UIButton *ShareBtn;
@property (weak, nonatomic) IBOutlet UIButton *MessageBtn;

@end
@implementation ZLXStatusToolBar

+ (instancetype) StatusToolBarWithView{
    return [[[NSBundle mainBundle] loadNibNamed:@"ZLXStatusToolBar" owner:nil options:nil]lastObject];
}
- (void) awakeFromNib{
    [super awakeFromNib];
    self.autoresizingMask = UIViewAutoresizingNone;
}
- (void) setStatus:(ZLXStatus *)status{
    _status = status;
    [self.LikeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    if (status.attitudes_count) {
          [self.LikeBtn setTitle:[NSString stringWithFormat:@"%zd",status.attitudes_count] forState:UIControlStateNormal];
    }else{
        [self.LikeBtn setTitle:@"赞" forState:UIControlStateNormal];
    }
    [self.ShareBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    if(status.reposts_count){
        [self.ShareBtn setTitle:[NSString stringWithFormat:@"%zd",status.reposts_count] forState:UIControlStateNormal];
    }else{
        [self.ShareBtn setTitle:@"分享" forState:UIControlStateNormal];
    }
    [self.MessageBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    if (status.comments_count) {
        [self.MessageBtn setTitle:[NSString stringWithFormat:@"%zd",status.comments_count] forState:UIControlStateNormal];
    }else{
    [self.MessageBtn setTitle:@"评论" forState:UIControlStateNormal];
    }
}
@end

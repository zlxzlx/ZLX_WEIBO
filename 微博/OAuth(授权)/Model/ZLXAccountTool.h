//
//  ZLXAccountTool.h
//  微博
//
//  Created by Lixin Zhou on 2016/12/23.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZLXAccount;
@interface ZLXAccountTool : NSObject
/** 保存账号*/
+ (void) SaveAccount:(ZLXAccount *) account;
/** 取出账号*/
+ (ZLXAccount *) TakeoutAccount;
/** 删除账号*/
+ (void) deleteAccountInfomation;
@end

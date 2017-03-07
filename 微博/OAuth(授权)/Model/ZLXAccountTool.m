//
//  ZLXAccountTool.m
//  微博
//
//  Created by Lixin Zhou on 2016/12/23.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXAccountTool.h"

@implementation ZLXAccountTool
/** 保存账号信息*/
+ (void) SaveAccount:(ZLXAccount *)account{
    NSString *document = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingString:@"account.ZLXdata"];
    [NSKeyedArchiver archiveRootObject:account toFile:document];
}
/** 取出账号信息*/
+ (ZLXAccount *) TakeoutAccount{
    NSString *document = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingString:@"account.ZLXdata"];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:document];
}
/** 删除账号*/
+ (void) deleteAccountInfomation{
   NSString *document = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingString:@"account.ZLXdata"];
    NSFileManager *mgr = [NSFileManager defaultManager];
    [mgr removeItemAtPath:document error:nil];
}
@end

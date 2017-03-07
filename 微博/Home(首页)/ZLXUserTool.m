//
//  ZLXUserTool.m
//  微博
//
//  Created by Lixin Zhou on 2016/12/28.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXUserTool.h"
#import "ZLXUserInfoResult.h"
#import <NSObject+MJKeyValue.h>
#import "ZLXAccountTool.h"
#import "ZLXAccount.h"
@implementation ZLXUserTool
+ (void) UserInfoWithsuccess:(void (^)(ZLXUserInfoResult *))success failure:(void (^)(NSError *))failure{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    parameter[@"access_token"] = [ZLXAccountTool TakeoutAccount].access_token;
    parameter[@"uid"] = [NSString stringWithFormat:@"%lld",[ZLXAccountTool TakeoutAccount].uid];
    [ZLXHttpTool GET:@"https://api.weibo.com/2/users/show.json" Parameters:parameter success:^(id responseObject) {
        /** 字典转模型*/
        ZLXUserInfoResult *result = [ZLXUserInfoResult mj_objectWithKeyValues:responseObject];
        if (success) {
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+ (void) unreadCountWithParamter:(ZLXUnderCount *)parameter success:(void (^)(ZLXUnderCountResult *))success failure:(void (^)(NSError *))failure{
    
     [ZLXHttpTool GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" Parameters:parameter.mj_keyValues success:^(id responseObject) {
         /** 字典转模型*/
         ZLXUnderCountResult *result = [ZLXUnderCountResult mj_objectWithKeyValues:responseObject];
         if (success) {
             success(result);
         }
     } failure:^(NSError *error) {
         if (failure) {
             failure(error);
         }
     }];
}
@end

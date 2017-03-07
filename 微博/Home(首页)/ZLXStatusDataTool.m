//
//  ZLXStatusDataTool.m
//  微博
//
//  Created by Lixin Zhou on 2016/12/27.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXStatusDataTool.h"
#import "ZLXStatus.h"
#import "ZLXHomeCacheTool.h"
#import <FMDB.h>
@implementation ZLXStatusDataTool
/** 数据库实例 */
static FMDatabase *_db;

+ (void)initialize
{
    // 1.获得数据库文件的路径
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filename = [doc stringByAppendingPathComponent:@"status.sqlite"];
    // 2.得到数据库
    _db = [FMDatabase databaseWithPath:filename];
    // 3.打开数据库
    if ([_db open]) {
        // 4.创表
        BOOL result = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_home_status (id integer PRIMARY KEY AUTOINCREMENT, access_token text NOT NULL, status_idstr text NOT NULL, status_dict blob NOT NULL);"];
        if (result) {
            NSLog(@"成功创表");
        } else {
            NSLog(@"创表失败");
        }
    }
}
+ (void) HomeStatusesWithParam:(ZLXParameter *)parameter success:(void (^)(ZLXStatusResult *))success failure:(void (^)(NSError *))failure{
    NSArray *cachedHomeStatuses = [self cachedHomeStatusesWithParam:parameter];
    if (cachedHomeStatuses.count != 0) {
        NSLog(@"数据读取成功！！！");
        if (success) {
            ZLXStatusResult *result = [[ZLXStatusResult alloc] init];
            result.statuses = cachedHomeStatuses;
            success(result);
        }
    }else{
        [ZLXHttpTool GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" Parameters:parameter.mj_keyValues success:^(id responseObject) {
            // 新浪返回的字典数组
            NSArray *statusDictArray = responseObject[@"statuses"];
            [self saveHomeStatusDictArray:statusDictArray accessToken:parameter.access_token];
            if (success) {//将结果模型传递出去
                ZLXStatusResult *result = [ZLXStatusResult mj_objectWithKeyValues:responseObject];
                success(result);
            }
        } failure:^(NSError *error) {
            if (failure) {
                failure(error);
            }
        }];
    }
}
+ (NSArray *)cachedHomeStatusesWithParam:(ZLXParameter *)param
{
    // 创建数组缓存微博数据
    NSMutableArray *statuses = [NSMutableArray array];
    // 根据请求参数查询数据
    FMResultSet *resultSet = nil;
    if (param.since_id) {
        resultSet = [_db executeQuery:@"select * from t_home_status where access_token = ? and status_idstr > ? order by status_idstr desc limit ?;", param.access_token, param.since_id, param.count];
    } else if (param.max_id) {
        resultSet = [_db executeQuery:@"select * from t_home_status where access_token = ? AND status_idstr <= ? ORDER BY status_idstr desc limit ?;", param.access_token, param.max_id, param.count];
    } else {
        resultSet = [_db executeQuery:@"select * FROM t_home_status where access_token = ? ORDER BY status_idstr DESC limit ?;", param.access_token, param.count];
    }
    // 遍历查询结果
    while (resultSet.next) {
        NSData *statusDictData = [resultSet objectForColumnName:@"status_dict"];
        NSDictionary *statusDict = [NSKeyedUnarchiver unarchiveObjectWithData:statusDictData];
        // 字典转模型
        ZLXStatus *status = [ZLXStatus mj_objectWithKeyValues:statusDict];
        // 添加模型到数组中
        [statuses addObject:status];
    }
    return statuses;
}
/**
 *  缓存微博字典数组到数据库中
 */
+ (void)saveHomeStatusDictArray:(NSArray *)statusDictArray accessToken:(NSString *)accessToken
{
    for (NSDictionary *statusDict in statusDictArray) {
        // 把statusDict字典对象序列化成NSData二进制数据
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:statusDict];
        [_db executeUpdate:@"INSERT INTO t_home_status (access_token, status_idstr, status_dict) VALUES (?, ?, ?);",
         accessToken, statusDict[@"idstr"], data];
    }
}
+ (void) CommentsWithParam:(ZLXCommentParam *)parameter success:(void (^)(ZLXCommentResult *))success failure:(void (^)(NSError *))failure{
    [ZLXHttpTool GET:@"https://api.weibo.com/2/comments/show.json" Parameters:parameter.mj_keyValues success:^(id responseObject) {
        ZLXCommentResult *result = [ZLXCommentResult mj_objectWithKeyValues:responseObject];
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

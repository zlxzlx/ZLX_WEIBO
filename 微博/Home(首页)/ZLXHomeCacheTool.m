//
//  ZLXHomeCacheTool.m
//  微博
//
//  Created by Lixin Zhou on 2017/2/27.
//  Copyright © 2017年 Lixin Zhou. All rights reserved.
//

#import "ZLXHomeCacheTool.h"
#import <FMDB.h>
@implementation ZLXHomeCacheTool
static FMDatabaseQueue *_queue;
//+ (void) initialize{
//    /** 创建数据库*/
//    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"ZLXTopic.sqlite"];
//    NSLog(@"%@",filePath);
//    _queue = [FMDatabaseQueue databaseQueueWithPath:filePath];
//    [_queue inDatabase:^(FMDatabase *db) {
//        NSString *creatTable = [NSString stringWithFormat:@"create table if not exists t_home_status (id integer primary key autoincrement, access_token text, ZLX_idstr text, status blob);"];
//        BOOL result1 =  [db executeUpdate:creatTable];
//        if (result1) {
//            NSLog(@"创表成功！");
//        }
//    }];
//}
///** 从数据库中取出数据*/
//+ (NSArray *) cachedHomeStatusesWithParam:(ZLXParameter *) param{
//    //创建数据库缓存数据
//    NSMutableArray *statuses = [NSMutableArray array];
//    //根据请求参数查询数据
//    __block  FMResultSet *resultSet = nil;
//    [_queue inDatabase:^(FMDatabase *db) {
//        if (param.since_id) {//当前的ID
//            resultSet = [db executeQuery:@"select * from t_home_status where access_token = ? and ZLX_idstr > ? order by ZLX_idstr desc limit ?;", param.access_token, param.since_id, param.count];
//        } else if (param.max_id) {//最大的ID
//            resultSet = [db executeQuery:@"select * from t_home_status where access_token = ? and ZLX_idstr <= ? order by ZLX_idstr desc limit ?;", param.access_token, param.max_id, param.count];
//        } else {
//            resultSet = [db executeQuery:@"select * from t_home_status where access_token = ? order by ZLX_idstr desc limit ?;", param.access_token, param.count];//容错处理，当用户加载数据的时候防止服务器没有请求到max_id和since_id,数据库中用到的比较多，处理数据的时候。
//        }
//    }];
//    // 遍历查询结果
//    while (resultSet.next) {
//        NSData *statusDictData = [resultSet objectForColumnName:@"status_dict"];
//        NSDictionary *statusDict = [NSKeyedUnarchiver unarchiveObjectWithData:statusDictData];
//        // 字典转模型
//        ZLXStatus *status = [ZLXStatus mj_objectWithKeyValues:statusDict];
//        // 添加模型到数组中
//        [statuses addObject:status];
//        NSData *data = [resultSet objectForColumnName:@"status"];
//        ZLXStatus *status = [NSKeyedUnarchiver unarchiveObjectWithData:data];
//        [statuses addObject:status];
//    }
//    return statuses;
//}
///** 将数据保存到数据库中*/
//+ (void)saveHomeStatusDictArray:(NSArray *)statusArray accessToken:(NSString *)accessToken
//{
//    for (NSDictionary *statusDict in statusArray) {
//        // 把statusDict字典对象序列化成NSData二进制数据
//        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:statusDict];
//        [_queue inDatabase:^(FMDatabase *db) {
//            [db executeUpdate:@"INSERT INTO t_home_status (access_token, ZLX_idstr, status_dict) VALUES (?, ?, ?);",
//             accessToken, statusDict[@"idstr"], data];
//        }];
//    }
////    /** 缓存模型*/
////    for (ZLXStatus *status in statusArray) {
////        [_queue inDatabase:^(FMDatabase *db) {
////           //获取需要存储的数据
////            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:status];
////            //存储数据
////            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
////                [db executeUpdate:@"insert into t_home_status (access_token, ZLX_idstr, status) values (?, ?, ?);",accessToken, status.idstr, data];
////            });
////        }];
////    }
//}
//+ (void)initialize
//{
//    // 1.获得数据库文件的路径
//    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    NSString *filename = [doc stringByAppendingPathComponent:@"status.sqlite"];
//    // 2.得到数据库
//    _db = [FMDatabase databaseWithPath:filename];
//    // 3.打开数据库
//    if ([_db open]) {
//        // 4.创表
//        BOOL result = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_home_status (id integer PRIMARY KEY AUTOINCREMENT, access_token text NOT NULL, status_idstr text NOT NULL, status_dict blob NOT NULL);"];
//        if (result) {
//            NSLog(@"成功创表");
//        } else {
//            NSLog(@"创表失败");
//        }
//    }
//}
@end

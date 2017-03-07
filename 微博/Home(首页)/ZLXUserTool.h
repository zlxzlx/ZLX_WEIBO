//
//  ZLXUserTool.h
//  微博
//
//  Created by Lixin Zhou on 2016/12/28.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
//@class ZLXUserInfoResult,ZLXUnderCount;
#import "ZLXUserInfoResult.h"
#import "ZLXUnderCount.h"
#import "ZLXUnderCountResult.h"
@interface ZLXUserTool : NSObject
+ (void) UserInfoWithsuccess:(void(^)(ZLXUserInfoResult *result))success failure:(void(^)(NSError *error)) failure;
+ (void) unreadCountWithParamter:(ZLXUnderCount *) parameter success:(void(^)(ZLXUnderCountResult *result))success failure:(void(^)(NSError *error)) failure;
@end

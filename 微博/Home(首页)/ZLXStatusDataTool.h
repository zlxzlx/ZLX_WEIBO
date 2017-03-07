//
//  ZLXStatusDataTool.h
//  微博
//
//  Created by Lixin Zhou on 2016/12/27.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZLXStatusResult.h"
#import "ZLXParameter.h"
#import "ZLXCommentParam.h"
#import "ZLXCommentResult.h"
#import "ZLXReweentResult.h"
#import "ZLXReweetParam.h"
@interface ZLXStatusDataTool : NSObject
+ (void) HomeStatusesWithParam:(ZLXParameter *)parameter success:(void(^)(ZLXStatusResult *result))success failure:(void(^)(NSError *error)) failure;
/** 加载评论数据*/
+ (void) CommentsWithParam:(ZLXCommentParam *)parameter success:(void(^)(ZLXCommentResult *result))success failure:(void(^)(NSError *error)) failure;
///** 加载转发数据*/
//+ (void) ReweentsWithParam:(ZLXReweetParam *)parameter success:(void(^)(ZLXReweentResult *result))success failure:(void(^)(NSError *error)) failure;
@end
 

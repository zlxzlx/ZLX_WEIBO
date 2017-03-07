//
//  ZLXReweetParam.m
//  微博
//
//  Created by Lixin Zhou on 2017/1/20.
//  Copyright © 2017年 Lixin Zhou. All rights reserved.
//

#import "ZLXReweetParam.h"

@implementation ZLXReweetParam
+ (instancetype) param{
    return [[self alloc] init];
}
+ (NSDictionary *) mj_replacedKeyFromPropertyName{
    /** ID对应的是服务器返回的id*/
    return @{@"ID":@"id"};
}
@end

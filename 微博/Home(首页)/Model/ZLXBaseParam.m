//
//  HMBaseParam.m
//  黑马微博
//
//  Created by apple on 14-7-11.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "ZLXBaseParam.h"
#import "ZLXAccountTool.h"
#import "ZLXAccount.h"

@implementation ZLXBaseParam
- (instancetype)init
{
    if (self = [super init]) {
        self.access_token = [ZLXAccountTool TakeoutAccount].access_token;
    }
    return self;
}
+ (instancetype)param
{
    return [[self alloc] init];
}
@end

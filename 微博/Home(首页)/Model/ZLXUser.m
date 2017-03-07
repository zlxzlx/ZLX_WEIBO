//
//  ZLXUser.m
//  微博
//
//  Created by Lixin Zhou on 2016/12/23.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXUser.h"

@implementation ZLXUser
+ (instancetype) userWithDict:(NSDictionary *)dict{
    ZLXUser *user = [[self alloc] init];
    user.name = dict[@"name"];
    user.profile_image_url = dict[@"profile_image_url"];
    return user;
}
/** 代表是会员*/
- (BOOL) isvip{
    return self.mbtype > 2;
}

@end

//
//  ZLXAccount.m
//  微博
//
//  Created by Lixin Zhou on 2016/12/23.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXAccount.h"

@implementation ZLXAccount
/** 解档*/
- (instancetype) initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.expires_in = [aDecoder decodeInt64ForKey:@"expires_in"];
        self.remind_in = [aDecoder decodeInt64ForKey:@"remind_in"];
        self.uid = [aDecoder decodeInt64ForKey:@"uid"];
    }
    return self;
}
/** 归档*/
- (void) encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeInt64:self.expires_in forKey:@"expires_in"];
    [aCoder encodeInt64:self.remind_in forKey:@"remind_in"];
    [aCoder encodeInt64:self.uid forKey:@"uid"];
}
@end

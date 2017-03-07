//
//  ZLXStatusResult.m
//  微博
//
//  Created by Lixin Zhou on 2016/12/27.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXStatusResult.h"
#import <MJExtension.h>
#import "ZLXStatus.h"
@implementation ZLXStatusResult
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"statuses":[ZLXStatus class]};
}
//MJCodingImplementation
@end

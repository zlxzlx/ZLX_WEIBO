//
//  ZLXReweentResult.m
//  微博
//
//  Created by Lixin Zhou on 2017/1/20.
//  Copyright © 2017年 Lixin Zhou. All rights reserved.
//

#import "ZLXReweentResult.h"
#import "ZLXStatus.h"
@implementation ZLXReweentResult
+ (NSDictionary *) mj_objectClassInArray{
    return @{@"reposts":[ZLXStatus class]};
}
@end

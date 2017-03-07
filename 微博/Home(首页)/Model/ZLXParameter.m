//
//  ZLXParameter.m
//  微博
//
//  Created by Lixin Zhou on 2016/12/27.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXParameter.h"

@implementation ZLXParameter
- (NSNumber *)count
{
    return _count ? _count : @20;
}/** 容错处理*/
@end

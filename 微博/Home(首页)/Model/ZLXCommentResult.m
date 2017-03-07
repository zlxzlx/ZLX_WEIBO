//
//  ZLXCommentResult.m
//  微博
//
//  Created by Lixin Zhou on 2017/1/19.
//  Copyright © 2017年 Lixin Zhou. All rights reserved.
//

#import "ZLXCommentResult.h"
#import "ZLXComments.h"
@implementation ZLXCommentResult
+ (NSDictionary *) mj_objectClassInArray{
    return @{@"comments":[ZLXComments class]};
}
//MJCodingImplementation
@end

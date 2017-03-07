//
//  ZLXPicture.m
//  微博
//
//  Created by Lixin Zhou on 2016/12/23.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "ZLXPicture.h"

@implementation ZLXPicture
- (NSString *) bmiddle_pic{
    return [self.thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
}
MJCodingImplementation
@end

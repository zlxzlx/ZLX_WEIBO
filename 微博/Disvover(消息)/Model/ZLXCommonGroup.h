//
//  ZLXCommonGroup.h
//  微博
//
//  Created by Lixin Zhou on 2017/1/16.
//  Copyright © 2017年 Lixin Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZLXCommonGroup : NSObject
@property (nonatomic,copy) NSString *footer;
@property (nonatomic,copy) NSString *header;
/** 这组所有行的模型（数组中存放的都是item模型）*/
@property (nonatomic,strong) NSArray *items;
+ (instancetype) group;
@end

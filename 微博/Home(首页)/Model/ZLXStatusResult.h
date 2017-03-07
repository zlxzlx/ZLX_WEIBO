//
//  ZLXStatusResult.h
//  微博
//
//  Created by Lixin Zhou on 2016/12/27.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZLXStatusResult : NSObject
@property (nonatomic,strong) NSArray *statuses;
@property (nonatomic,assign) int total_number;
@end

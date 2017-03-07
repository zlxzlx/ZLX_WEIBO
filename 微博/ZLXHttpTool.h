//
//  ZLXHttpTool.h
//  微博
//
//  Created by Lixin Zhou on 2016/12/23.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZLXHttpTool : NSObject
//+ (void) success:(void(^))
+ (void) GET:(NSString *)URLString Parameters:(id)Parameters success:(void(^)(id responseObject)) success failure:(void (^)(NSError *error))failure; 
@end

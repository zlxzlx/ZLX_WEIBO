//
//  ZLXAccount.h
//  微博
//
//  Created by Lixin Zhou on 2016/12/23.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZLXAccount : NSObject<NSCoding>
@property (nonatomic,copy) NSString *access_token;
@property (nonatomic,assign) long long expires_in;
@property (nonatomic,assign) long long remind_in;
@property (nonatomic,assign) long long uid;
/**
 *  用户昵称
 */
@property (nonatomic, copy) NSString *name;
@end

//
//  ZLXEmotionModel.h
//  微博
//
//  Created by Lixin Zhou on 2017/1/5.
//  Copyright © 2017年 Lixin Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZLXEmotionModel : NSObject<NSCoding>
/** 表情的文字描述 */
@property (nonatomic,copy) NSString *chs;
/** 表情的存放路径 */
@property (nonatomic,copy) NSString *directory;
/** emoji表情的编码 */
@property (nonatomic,copy) NSString *code;
/** 表情的名称*/
@property (nonatomic,copy) NSString *png;
/** emoji字符*/
@property (nonatomic,copy) NSString *emoji;

@property (nonatomic,copy) NSString *cht;

@end

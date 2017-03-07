//
//  ZLXCommentParam.h
//  微博
//
//  Created by Lixin Zhou on 2017/1/19.
//  Copyright © 2017年 Lixin Zhou. All rights reserved.
//

#import "ZLXBaseParam.h"

@interface ZLXCommentParam : ZLXBaseParam
/**
 必选	类型及范围	说明
 access_token	true	string	采用OAuth授权方式为必填参数，OAuth授权后获得。
 id	true	int64	需要查询的微博ID。
 since_id	false	int64	若指定此参数，则返回ID比since_id大的评论（即比since_id时间晚的评论），默认为0。
 max_id	false	int64	若指定此参数，则返回ID小于或等于max_id的评论，默认为0。
 count	false	int	单页返回的记录条数，默认为50。
 page	false	int	返回结果的页码，默认为1。
 filter_by_author	false	int	作者筛选类型，0：全部、1：我关注的人、2：陌生人，默认为0。*/
@property (nonatomic,copy) NSString *ID;
@property (nonatomic,copy) NSString *since_id;
@property (nonatomic,copy) NSString *max_id;
@property (nonatomic,assign) NSNumber *count;
@end

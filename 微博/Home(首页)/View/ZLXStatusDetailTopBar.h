//
//  ZLXStatusTopBar.h
//  微博
//
//  Created by Lixin Zhou on 2017/1/18.
//  Copyright © 2017年 Lixin Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
 ZLXStatusDetailTopBarButtonTypeReweet,
 ZLXStatusDetailTopBarButtonTypeComment
}ZLXStatusDetailTopBarButtonType;
@class ZLXStatusDetailTopBar,ZLXStatus;
@protocol ZLXStatusDetailTopBarDelegate <NSObject>
- (void) topToolbar:(ZLXStatusDetailTopBar *) toopToolbar didselctedButton:(ZLXStatusDetailTopBarButtonType)buttonType;
@end
@interface ZLXStatusDetailTopBar : UIView

+ (instancetype) initWithXib;
@property (nonatomic,weak) id<ZLXStatusDetailTopBarDelegate> delegate;
@property (nonatomic, assign) ZLXStatusDetailTopBarButtonType selectedButtonType;
@property (nonatomic,strong) ZLXStatus *status;
@end

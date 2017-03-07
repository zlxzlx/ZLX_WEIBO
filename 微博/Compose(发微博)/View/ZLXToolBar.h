//
//  ZLXToolBar.h
//  微博
//
//  Created by Lixin Zhou on 2016/12/26.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    ZLXComposeToolbarButtonTypeCamera,
    ZLXComposeToolbarButtonTypePicture,
    ZLXComposeToolbarButtonTypeMetion,
    ZLXComposeToolbarButtonTypeTrend,
    ZLXComposeToolbarButtonTypeEmotion
}ZLXComposeToolbarButtonType;
@class ZLXToolBar;
@protocol ZLXToolBarDelegate <NSObject>

@optional
- (void) composeTool:(ZLXToolBar *) toolbar didClickedButton:(ZLXComposeToolbarButtonType) buttonType;
@end
@interface ZLXToolBar : UIView
@property (nonatomic,weak) id <ZLXToolBarDelegate> delegate;
@property (nonatomic,assign) BOOL ShowEmtionButton;
@end

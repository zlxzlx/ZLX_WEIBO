//
//  UIView+ZLX.m
//  真有趣
//
//  Created by Lixin Zhou on 16/8/30.
//  Copyright © 2016年 Lixin Zhou. All rights reserved.
//

#import "UIView+ZLX.h"

@implementation UIView (ZLX)
- (void) setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (void) setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (void) setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (void) setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (CGFloat) width{
    return self.frame.size.width;
}
- (CGFloat) height{
    return self.frame.size.height;
}
- (CGFloat) x{
    return self.frame.origin.x;
}
- (CGFloat) y{
    return self.frame.origin.y;
}
- (void) setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
- (CGSize) size{
    return self.frame.size;
}
- (void) setCenterx:(CGFloat)centerx{
    
    CGPoint center = self.center;
    center.x = centerx;
    self.center = center;
}
- (void) setCentery:(CGFloat)centery{
    CGPoint center = self.center;
    center.y = centery;
    self.center = center;
    
}
-(CGFloat) centerx{
    return self.center.x;
    
}
- (CGFloat) centery{
    return self.center.y;
    
}
+ (instancetype) ZLX_ViewFromXib{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil]firstObject];
}
- (CGFloat) right
{
    return self.frame.origin.x + self.frame.size.width;
}
@end

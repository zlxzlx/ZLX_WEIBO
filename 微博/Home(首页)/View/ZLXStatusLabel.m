//
//  ZLXStatusLabel.m
//  微博
//
//  Created by Lixin Zhou on 2017/1/14.
//  Copyright © 2017年 Lixin Zhou. All rights reserved.
//

#import "ZLXStatusLabel.h"
#import "ZLXLink.h"
#define ZLXLinkBackgroudTag 10000
@interface ZLXStatusLabel ()
@property (nonatomic,weak) UITextView *textView;
@property (nonatomic,strong) NSMutableArray *links;
@end
@implementation ZLXStatusLabel
- (NSMutableArray *)links{
    if (_links == nil) {
        NSMutableArray *links = [NSMutableArray array];
       [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
           NSString *linkText = attrs[@"link"];
           if (linkText == nil) return;
           //创建一个连接
           ZLXLink *link = [[ZLXLink alloc] init];
           link.text = linkText;
           link.range = range;
           NSMutableArray *rects = [NSMutableArray array];
           //处理矩形框
           self.textView.selectedRange = range;
           NSArray *selectionRects = [self.textView selectionRectsForRange:self.textView.selectedTextRange];
           for (UITextSelectionRect *selectionRect in selectionRects) {
               if (selectionRect.rect.size.width == 0 || selectionRect.rect.size.height == 0) continue;
               [rects addObject:selectionRect];
           }
           link.rects = rects;
           [links addObject:link];
       }];
        self.links = links;
    }
    return _links;
}
- (instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UITextView *textView = [[UITextView alloc] init];
        textView.backgroundColor = [UIColor clearColor];
        textView.textContainerInset = UIEdgeInsetsMake(-2, -5, -2, -5);
//        textView.userInteractionEnabled = NO;
//        textView.editable = NO;
//        textView.textColor = [UIColor redColor];
        textView.scrollEnabled = NO;
        self.textView = textView;
        [self addSubview:textView];

    }
    return self;
}
- (void) layoutSubviews{
    [super layoutSubviews];
    self.textView.frame = self.bounds;
}
- (void) setAttributedText:(NSAttributedString *)attributedText{
    _attributedText = attributedText;
    self.textView.attributedText = attributedText;
    self.links = nil;
}
- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    //查看点击了哪个连接
    ZLXLink *touchingLink = [self touchingLinkWithPoint:point];
    [self showLinkBackGroud:touchingLink];
}
- (void) touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

}
- (void) touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self removeAllLinkBackgroud];
}
- (void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self removeAllLinkBackgroud];
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    ZLXLink *touchingLink = [self touchingLinkWithPoint:point];
    if (touchingLink) {
        //说明手指在某个链接上面抬起来了
        /** 发送通知*/
        [[NSNotificationCenter defaultCenter] postNotificationName:ZLXLinkDidSelectedNotification object:nil userInfo:@{ZLXLinkText:touchingLink.text}];
    }
}
#pragma 连接背景处理
- (ZLXLink *) touchingLinkWithPoint:(CGPoint) point{
    __block ZLXLink *touchingLink = nil;
    [self.links enumerateObjectsUsingBlock:^(ZLXLink *link, NSUInteger idx, BOOL * _Nonnull stop) {
        for (UITextSelectionRect *selectionRect in link.rects) {
            if (CGRectContainsPoint(selectionRect.rect, point)) {
                touchingLink = link;
                break;
            }
        }
    }];
    return touchingLink;
}
- (void) showLinkBackGroud:(ZLXLink *) link{
        for (UITextSelectionRect *selectionRect in link.rects) {
            UIView *bg = [[UIView alloc] init];
            bg.tag = ZLXLinkBackgroudTag;
            bg.layer.cornerRadius = 3;
            bg.frame = selectionRect.rect;
            bg.backgroundColor = [UIColor colorWithRed:213 / 255.0 green:226 / 255.0 blue:255 / 255.0 alpha:1.0];
            [self insertSubview:bg atIndex:0];
//            [self addSubview:bg];
        }
}
- (void) removeAllLinkBackgroud{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (UIView *child in self.subviews) {
            if (child.tag == ZLXLinkBackgroudTag) {
                [child removeFromSuperview];
            }
        }
    });
}
- (UIView *) hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if([self touchingLinkWithPoint:point]){
        return self;
    }else{
        return nil;
    }
}
//- (BOOL) pointInside:(CGPoint)point withEvent:(UIEvent *)event{
//    if ([self touchingLinkWithPoint:point]) {
//        return YES;
//    }else{
//        return NO;
//    }
//}
@end

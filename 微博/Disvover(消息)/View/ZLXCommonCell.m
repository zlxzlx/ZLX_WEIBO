//
//  ZLXCommonCell.m
//  微博
//
//  Created by Lixin Zhou on 2017/1/16.
//  Copyright © 2017年 Lixin Zhou. All rights reserved.
//

#import "ZLXCommonCell.h"
#import "ZLXCommonItem.h"
#import "ZLXCommonArrowItem.h"
#import "ZLXCommonSwitch.h"
#import "ZLXCommonLabelItem.h"
#import "ZLXBadgeView.h"
static NSString *cellID = @"cell";
@interface ZLXCommonCell ()
@property (nonatomic,strong) UIImageView *rightArrow;
@property (nonatomic,strong) UISwitch *Switch;
@property (nonatomic,strong) ZLXBadgeView *badgeView;
@end
@implementation ZLXCommonCell
- (UIImageView *) rightArrow{
    if (_rightArrow == nil) {
        _rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_arrow"]];
    }
    return _rightArrow;
}
- (UISwitch *) Switch{
    if (_Switch == nil) {
        _Switch = [[UISwitch alloc] init];
    }
    return _Switch;
}
- (ZLXBadgeView *) badgeView{
    if (_badgeView == nil) {
        _badgeView = [ZLXBadgeView badgeView];
    }
    return _badgeView;
}
+ (instancetype) cellWithTableView:(UITableView *)tabbleView{
    ZLXCommonCell *cell = [tabbleView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[ZLXCommonCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    return cell;
}
- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        /** 相关初始化设置*/
        self.textLabel.font = [UIFont boldSystemFontOfSize:20];
        self.backgroundColor = [UIColor clearColor];
    }
    return  self;
}
- (void) setItem:(ZLXCommonItem *)item{
    _item = item;
    self.imageView.image = [UIImage imageNamed:item.icon];
    self.textLabel.text = item.title;
    self.detailTextLabel.text = item.subtitle;
    /** 设置右边显示的内容*/
    if (item.badgeValue) {
        self.badgeView.badgeValue = item.badgeValue;
        self.accessoryView = self.badgeView;
    }
    else if ([item isKindOfClass:[ZLXCommonArrowItem class]]) {
        self.accessoryView = self.rightArrow;
    }else if ([item isKindOfClass:[ZLXCommonSwitch class]]){
        UISwitch *Switch = self.Switch;
        [Switch addTarget:self action:@selector(Switch:) forControlEvents:UIControlEventValueChanged];
        self.accessoryView = Switch;
    }else if ([item isKindOfClass:[ZLXCommonLabelItem class]]){
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, 0, 35, 15);
        label.text = @"点击";
        label.font = [UIFont systemFontOfSize:13];
        self.accessoryView = label;
    }else{
        self.accessoryView = nil;
    }
}
- (void) Switch:(id)sender{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
//        NSLog(@"打开开关");
        [[NSNotificationCenter defaultCenter] postNotificationName:@"zlx" object:nil];
    }else {
//        NSLog(@"关闭开关");
    }
}
- (void) layoutSubviews{
    [super layoutSubviews];
    //调整子标题的X
    self.detailTextLabel.x = CGRectGetMaxX(self.textLabel.frame) + 10;
}
- (void) setIndexPath:(NSIndexPath *)indexPath numberOfRowsInSection:(NSInteger)numbers{
    UIImageView *bgView = [[UIImageView alloc] init];
    UIImageView *selectedBgView = [[UIImageView alloc] init];
    if (numbers == 1) {
        bgView.image = [UIImage resizedImage:@"common_card_background"];
        selectedBgView.image = [UIImage resizedImage:@"common_card_background_highlighted"];
    }else if (indexPath.row == 0){
        bgView.image = [UIImage resizedImage:@"common_card_top_background"];
        selectedBgView.image = [UIImage resizedImage:@"common_card_top_background_highlighted"];
    }else if (indexPath.row == numbers - 1){
        bgView.image = [UIImage resizedImage:@"common_card_bottom_background"];
        selectedBgView.image = [UIImage resizedImage:@"common_card_bottom_background_highlighted"];
    }else{
        bgView.image = [UIImage resizedImage:@"common_card_middle_background"];
        selectedBgView.image = [UIImage resizedImage:@"common_card_middle_background_highlighted"];
    }
    self.backgroundView = bgView;
    self.selectedBackgroundView = selectedBgView;
}
@end

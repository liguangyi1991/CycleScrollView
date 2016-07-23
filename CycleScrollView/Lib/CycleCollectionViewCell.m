//
//  CycleCollectionViewCell.m
//  CycleScrollView
//
//  Created by liguangyi on 16/7/20.
//  Copyright © 2016年 liguangyi. All rights reserved.
//

#import "CycleCollectionViewCell.h"
#import "UIView+Frame.h"

@implementation CycleCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupImageView];
        [self setupTitleLable];
//        self.backgroundColor = [UIColor redColor];
    }
    return self;
}
- (void)setupTitleLable
{
    UILabel *titleLable = [UILabel new];
    _titleLable = titleLable;
//    _titleLable.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:titleLable];
}
- (void)setupImageView
{
    UIImageView *imageView = [UIImageView new];
    _imageView = imageView;
    [self.contentView addSubview:imageView];
}

//配置属性
- (void)setTitleLabelBackgroundColor:(UIColor *)titleLabelBackgroundColor
{
    _titleLabelBackgroundColor = titleLabelBackgroundColor;
    _titleLable.backgroundColor = titleLabelBackgroundColor;
}

- (void)setTitleLabelTextColor:(UIColor *)titleLabelTextColor
{
    _titleLabelTextColor = titleLabelTextColor;
    _titleLable.textColor = titleLabelTextColor;
}

- (void)setTitleLabelTextFont:(UIFont *)titleLabelTextFont
{
    _titleLabelTextFont = titleLabelTextFont;
    _titleLable.font = titleLabelTextFont;
}

- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    _titleLable.text = [NSString stringWithFormat:@"   %@", title];
    if (_titleLable.hidden) {
        _titleLable.hidden = NO;
    }
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    if (_onlyDisplayText) {
        _titleLable.frame = self.bounds;
        return;
    }
    _imageView.frame = self.bounds;
    _titleLable.frame = CGRectMake(0, self.height - _titileLableHeight, self.width, _titileLableHeight);
    
}
@end

//
//  CycleCollectionViewCell.h
//  CycleScrollView
//
//  Created by liguangyi on 16/7/20.
//  Copyright © 2016年 liguangyi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CycleCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UILabel *titleLable;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) CGFloat titileLableHeight;

@property (copy, nonatomic) NSString *title;

@property (nonatomic, strong) UIColor *titleLabelTextColor;
@property (nonatomic, strong) UIFont *titleLabelTextFont;
@property (nonatomic, strong) UIColor *titleLabelBackgroundColor;
@property (nonatomic, assign) CGFloat titleLabelHeight;
/** 只展示文字轮播 */
@property (nonatomic, assign) BOOL onlyDisplayText;
@end

//
//  CycleScrollVIew.h
//  CycleScrollView
//
//  Created by liguangyi on 16/7/19.
//  Copyright © 2016年 liguangyi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CycleScrollView;

typedef NS_ENUM(NSInteger,CycleScrollViewPageContolAliment)
{
    SDCycleScrollViewPageContolAlimentRight,//又对齐
    SDCycleScrollViewPageContolAlimentCenter//居中
};
typedef NS_ENUM(NSInteger,CycleScrollViewPageContolStyle)
{
    SDCycleScrollViewPageContolStyleClassic,        // 系统自带经典样式
    SDCycleScrollViewPageContolStyleAnimated,       // 动画效果pagecontrol
    SDCycleScrollViewPageContolStyleNone
};
@protocol CycleScrollViewDelegate
/** 点击图片回调 */
- (void)cycleScrollView:(CycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index;
@end

@interface CycleScrollView : UIView

@property (nonatomic, weak) id<CycleScrollViewDelegate> delegate;

/** block方式监听点击 */
@property (nonatomic, copy) void (^clickItemOperationBlock)(NSInteger currentIndex);

//滚动的collectionView的flowLayout
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
//滚动的collectionView
@property (nonatomic, strong) UICollectionView *colltectionView;

//初始化
+ (instancetype)initCycleScrollViewWithFrame:(CGRect)frame delegate:(id<CycleScrollViewDelegate>)delegate placeholderImage:(UIImage *)placeholderImage;


//滚动视图数据源
//网络图片url数组
@property (nonatomic, strong) NSArray *imageUrlArray;
//每张图片对应的文字数组
@property (nonatomic, strong) NSArray *titleStringArray;

/***********************自定义接口****************************/

/** 占位图，用于网络未加载到图片时 */
@property (nonatomic, strong) UIImage *placeholderImage;

@property (nonatomic, strong) UIImageView *backgroundImageView; // 当imageURLs为空时的背景图

/** 图片滚动方向，默认为水平滚动 */
@property (nonatomic, assign) UICollectionViewScrollDirection scrollDirection;

//自动滚动间隔时间
@property (nonatomic, assign) CGFloat autoScrollTimeInterval;

/** 是否自动滚动,默认Yes */
@property (nonatomic,assign) BOOL autoScroll;

/** 分页控件小圆标大小 */
@property (nonatomic, assign) CGSize pageControlDotSize;

/** pagecontrol 样式，默认为系统经典样式 */
@property (nonatomic, assign) CycleScrollViewPageContolStyle pageControlStyle;

/** 分页控件位置 */
@property (nonatomic, assign) CycleScrollViewPageContolAliment pageControlAliment;

/** 分页控件距离轮播图的底部间距（在默认间距基础上）的偏移量 */
@property (nonatomic, assign) CGFloat pageControlBottomOffset;

/** 分页控件距离轮播图的右边间距（在默认间距基础上）的偏移量 */
@property (nonatomic, assign) CGFloat pageControlRightOffset;

/** 当前分页控件小圆标颜色 (只对系统经典的适用对自定义的不试用)*/
@property (nonatomic, strong) UIColor *currentPageDotColor;

/** 其他分页控件小圆标颜色 */
@property (nonatomic, strong) UIColor *pageDotColor;

/** 当前分页控件小圆标图片 */
@property (nonatomic, strong) UIImage *currentPageDotImage;

/** 其他分页控件小圆标图片 */
@property (nonatomic, strong) UIImage *pageDotImage;

/** 是否显示分页控件 */
@property (nonatomic, assign) BOOL showPageControl;

/** 是否在只有一张图时隐藏pagecontrol，默认为YES */
@property(nonatomic) BOOL hidesForSinglePage;

/** 轮播文字label字体颜色 */
@property (nonatomic, strong) UIColor *titleLabelTextColor;

/** 轮播文字label字体大小 */
@property (nonatomic, strong) UIFont  *titleLabelTextFont;

/** 轮播文字label背景颜色 */
@property (nonatomic, strong) UIColor *titleLabelBackgroundColor;

/** 轮播文字label高度 */
@property (nonatomic, assign) CGFloat titleLabelHeight;

/** 只显示图片不显示lable,默认为NO */
@property (nonatomic, assign) Boolean onlyDisPlayImage;

/** 只展示文字轮播 ,要在设置 titleStringArray 之前设置 */
@property (nonatomic, assign) BOOL onlyDisplayText;
@end

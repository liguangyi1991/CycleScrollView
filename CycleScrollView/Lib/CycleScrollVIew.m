//
//  CycleScrollVIew.m
//  CycleScrollView
//
//  Created by liguangyi on 16/7/19.
//  Copyright © 2016年 liguangyi. All rights reserved.
//

#import "CycleScrollVIew.h"
#import "CycleCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIView+Frame.h"
#import "TAPageControl.h"

NSString  * const cellID = @"cycleCell";
@interface CycleScrollView() <UICollectionViewDelegate,UICollectionViewDataSource>

{
    NSInteger _currentIndex;
}
@property (nonatomic, strong) NSArray *imagePathsGroup;
@property (nonatomic, assign) NSInteger totalItemsCount;//滚动视图的数量
@property (nonatomic, assign) NSInteger tempIndex;//图片下标
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, strong) UIControl *pageControl;

@end
@implementation CycleScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initializationProperty];
        [self setupMainView];
    }
    return self;
}
//初始化实例变量
- (void)initializationProperty
{
    _titleLabelHeight = 30;
    _autoScrollTimeInterval = 2;
    _autoScroll = YES;
    _pageControlDotSize = CGSizeMake(10, 10);
    _pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
//    _currentPageDotColor = [UIColor blueColor];
    _pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    _hidesForSinglePage = YES;
    _titleLabelTextColor = [UIColor whiteColor];
    _titleLabelTextFont= [UIFont systemFontOfSize:14];
    _titleLabelBackgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    _titleLabelHeight = 30;
    _onlyDisPlayImage = NO;


}
//初始化collectionView
- (void)setupMainView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _flowLayout = flowLayout;
    
    UICollectionView *colltectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
    [colltectionView registerClass:[CycleCollectionViewCell class] forCellWithReuseIdentifier:cellID];
    colltectionView.backgroundColor = [UIColor clearColor];
    colltectionView.pagingEnabled = YES;
    colltectionView.showsHorizontalScrollIndicator = NO;
    colltectionView.showsVerticalScrollIndicator = NO;
    colltectionView.delegate = self;
    colltectionView.dataSource = self;
    _colltectionView = colltectionView;
    [self addSubview:colltectionView];

}
+ (instancetype)initCycleScrollViewWithFrame:(CGRect)frame delegate:(id<CycleScrollViewDelegate>)delegate placeholderImage:(UIImage *)placeholderImage
{
    CycleScrollView *cycleScrollView = [[CycleScrollView alloc] initWithFrame:frame];
    cycleScrollView.placeholderImage = placeholderImage;
    cycleScrollView.delegate = delegate;

    return cycleScrollView;
}
#pragma mark - actions

- (void)setupTimer
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.autoScrollTimeInterval target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
    _timer = timer;
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)invalidateTimer
{
    [_timer invalidate];
    _timer = nil;
}
- (void)automaticScroll
{
    if (0 == _totalItemsCount) return;
    _currentIndex = [self currentIndex];
    NSInteger targetIndex = _currentIndex + 1;
    [self scrollToIndex:targetIndex animated:YES];
}
- (void)scrollToIndex:(NSInteger)targetIndex animated:(Boolean)animated
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:targetIndex inSection:0];
    [_colltectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:animated];
}
- (NSInteger)currentIndex
{
    NSInteger index = 0;
    if (_flowLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        index = _colltectionView.contentOffset.x /self.width;
    }else{
        index = _colltectionView.contentOffset.y /self.height;

    }
    return index;
}

- (void)setUpPageControl
{
    if (_pageControl ) {
        [_pageControl removeFromSuperview];
    }
    if (_imagePathsGroup.count == 0 || self.onlyDisplayText) {
        return;
    }
    if ((_imagePathsGroup.count == 1) && _hidesForSinglePage) return;

    int currentPageAtPageContrll = [self pageControlIndex:[self currentIndex]];
    switch (self.pageControlStyle) {
//            NSLog(@"枚举值%ld",(long)self.pageControlStyle);
        case SDCycleScrollViewPageContolStyleClassic:
        {
            UIPageControl *pageControl = [[UIPageControl alloc] init];
            pageControl.numberOfPages = _imagePathsGroup.count;
            pageControl.currentPage = currentPageAtPageContrll;
            pageControl.currentPageIndicatorTintColor = _currentPageDotColor;
            [self addSubview:pageControl];
            _pageControl = pageControl;
        }
            break;
        case SDCycleScrollViewPageContolStyleAnimated:
        {
            TAPageControl *tapageControl = [[TAPageControl alloc] init];
            tapageControl.currentPage = currentPageAtPageContrll;
            tapageControl.numberOfPages = _imagePathsGroup.count;
            tapageControl.dotColor = self.currentPageDotColor;
//            tapageControl.dotColor = [UIColor blueColor];
//            tapageControl.backgroundColor = [UIColor blueColor];

            [self addSubview:tapageControl];
            _pageControl = tapageControl;
        }
            break;
        default:
            break;
    }

    
}

-(int)pageControlIndex:(NSInteger)index
{
    return (int)index % _totalItemsCount;
}
#pragma mark -  properties
- (void)setAutoScroll:(BOOL)autoScroll
{
    _autoScroll = autoScroll;
    [self invalidateTimer];
    if(_autoScroll)
    {
        [self setupTimer];
    }
}

- (void)setAutoScrollTimeInterval:(CGFloat)autoScrollTimeInterval
{
    _autoScrollTimeInterval = autoScrollTimeInterval;
    [self setAutoScroll:YES];
    
}
- (void)setImagePathsGroup:(NSArray *)imagePathsGroup
{
    _imagePathsGroup = imagePathsGroup;
        _totalItemsCount = self.imagePathsGroup.count + 2;

    if (imagePathsGroup.count == 1) {
        _colltectionView.scrollEnabled = NO;
    }else{
        _colltectionView.scrollEnabled = YES;
        [self setAutoScroll:_autoScroll];

    }
    [self setUpPageControl];
    [_colltectionView reloadData];
    
}

- (void)setImageUrlArray:(NSArray *)imageUrlArray
{
    _imageUrlArray = imageUrlArray;
    NSMutableArray *tempArray = [NSMutableArray array];
    [_imageUrlArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *tempString;
        if ([obj isKindOfClass:[NSString class]]) {
            tempString = obj;
        }else if ([obj isKindOfClass:[NSURL class]])
        {
            NSURL *tempURL = (NSURL *)obj;
            tempString = [tempURL absoluteString];
        }
        if (tempString) {
            [tempArray addObject:tempString];
        }
    }];
    self.imagePathsGroup = [tempArray copy];
}

- (void)setPageControlStyle:(CycleScrollViewPageContolStyle)pageControlStyle
{
    _pageControlStyle = pageControlStyle;
    [self setUpPageControl];

}

- (void)setCurrentPageDotColor:(UIColor *)currentPageDotColor
{
    _currentPageDotColor = currentPageDotColor;
    if ([_pageControl isKindOfClass:[TAPageControl class]]) {
        ((TAPageControl *)_pageControl).dotColor = currentPageDotColor;
    }else{
        ((UIPageControl *)_pageControl).currentPageIndicatorTintColor = currentPageDotColor;
    }
    
}

- (void)setPageDotColor:(UIColor *)pageDotColor
{
    _pageDotColor = pageDotColor;
    
    if ([self.pageControl isKindOfClass:[UIPageControl class]]) {
        UIPageControl *pageControl = (UIPageControl *)_pageControl;
        pageControl.pageIndicatorTintColor = pageDotColor;
    }
}

- (void)setCurrentPageDotImage:(UIImage *)currentPageDotImage
{
    _currentPageDotImage = currentPageDotImage;
    
    if (self.pageControlStyle != SDCycleScrollViewPageContolStyleAnimated) {
        self.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    }
    
    [self setCustomPageControlDotImage:currentPageDotImage isCurrentPageDot:YES];
}

- (void)setPageDotImage:(UIImage *)pageDotImage
{
    _pageDotImage = pageDotImage;
    
    if (self.pageControlStyle != SDCycleScrollViewPageContolStyleAnimated) {
        self.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    }
    
    [self setCustomPageControlDotImage:pageDotImage isCurrentPageDot:NO];
}
- (void)setCustomPageControlDotImage:(UIImage *)image isCurrentPageDot:(BOOL)isCurrentPageDot
{
    if (!image || !self.pageControl) return;
    
    if ([self.pageControl isKindOfClass:[TAPageControl class]]) {
        TAPageControl *pageControl = (TAPageControl *)_pageControl;
        if (isCurrentPageDot) {
            pageControl.currentDotImage = image;
        } else {
            pageControl.dotImage = image;
        }
    }
}

- (void)setShowPageControl:(BOOL)showPageControl
{
    _showPageControl = showPageControl;
    
    _pageControl.hidden = !showPageControl;
}
- (void)setHidesForSinglePage:(BOOL)hidesForSinglePage
{
    _hidesForSinglePage = hidesForSinglePage;
    [self setUpPageControl];
}

- (void)setScrollDirection:(UICollectionViewScrollDirection)scrollDirection
{
    _scrollDirection = scrollDirection;
    _colltectionView.bounces = NO;
    _flowLayout.scrollDirection = scrollDirection;
}

- (void)setPlaceholderImage:(UIImage *)placeholderImage
{
    _placeholderImage = placeholderImage;
    
    if (!self.backgroundImageView) {
        UIImageView *bgImageView = [UIImageView new];
        bgImageView.contentMode = UIViewContentModeScaleToFill;
        [self insertSubview:bgImageView belowSubview:self.colltectionView];
        self.backgroundImageView = bgImageView;
    }
    
    self.backgroundImageView.image = placeholderImage;
}
-(void)setTitleStringArray:(NSArray *)titleStringArray
{
    _titleStringArray = titleStringArray;
    if (self.onlyDisplayText) {
        NSMutableArray *temp = [NSMutableArray new];
        for (int i = 0; i < _titleStringArray.count; i++) {
            [temp addObject:@""];
        }
        self.backgroundColor = [UIColor clearColor];
        self.imageUrlArray = [temp copy];
    }
}
#pragma mark -  layout
- (void)layoutSubviews
{
    [super layoutSubviews];
    _flowLayout.itemSize = self.frame.size;
    _colltectionView.frame = self.bounds;
    if (_currentIndex == 0 ) {
        [self scrollToIndex:1 animated:NO];
        _currentIndex = 1;
    }
    CGSize size = CGSizeZero;
    if ([_pageControl isKindOfClass:[TAPageControl class]]) {
        size = [(TAPageControl *)_pageControl sizeForNumberOfPages:_imagePathsGroup.count];
    }else
    {
        size = CGSizeMake(self.imagePathsGroup.count * self.pageControlDotSize.width * 1.5, self.pageControlDotSize.height);
    }
    CGFloat x = (self.width - size.width) * 0.5;
    if(_pageControlAliment == SDCycleScrollViewPageContolAlimentRight)
    {
        x= (self.width - size.width) - 10;
    }
    CGFloat y = self.colltectionView.height - size.height - 10;
    CGRect pageControlFrame = CGRectMake(x, y, size.width, size.height);
    pageControlFrame.origin.y -= self.pageControlBottomOffset;
    pageControlFrame.origin.x -= self.pageControlRightOffset;
    _pageControl.frame = pageControlFrame;
    
}

- (void)updateConstraints
{
    [super updateConstraints];
}
#pragma mark -  UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _totalItemsCount;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CycleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    if(indexPath.row == 0)
    {
        _tempIndex = _totalItemsCount - 3;
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:self.imagePathsGroup[_totalItemsCount - 3]] placeholderImage:self.placeholderImage];
    }else if(indexPath.row == _totalItemsCount - 1)
    {
        _tempIndex = 0;
    }else{
        _tempIndex = indexPath.row - 1;
    }
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:self.imagePathsGroup[_tempIndex]] placeholderImage:nil];
    if (!_onlyDisPlayImage) {
        cell.titileLableHeight = self.titleLabelHeight;
        cell.title = self.titleStringArray[_tempIndex];
        cell.titleLabelTextColor = self.titleLabelTextColor;
        cell.titleLabelTextFont = self.titleLabelTextFont;
        cell.titleLabelBackgroundColor = self.titleLabelBackgroundColor;
        cell.onlyDisplayText = _onlyDisplayText;

    }

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    [self.delegate cycleScrollView:self didSelectItemAtIndex:[self pageControlIndex:indexPath.row]];
//    NSLog(@"点击第%d",[self pageControlIndex:indexPath.row]);
//    if (self.clickItemOperationBlock) {
//        self.clickItemOperationBlock([self pageControlIndex:indexPath.row]]);
//    }
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    if(_scrollDirection == UICollectionViewScrollDirectionHorizontal)
    {
        if(_colltectionView.contentOffset.x >=  _flowLayout.itemSize.width * (_totalItemsCount - 1))
        {
            [self scrollToIndex:1 animated:NO];
            _currentIndex = 1;
            return;
        }
        if (_colltectionView.contentOffset.x <=  0) {
            [self scrollToIndex:_totalItemsCount - 2 animated:NO];
            _currentIndex = _totalItemsCount - 2;
            return;
        }
    }else{
        NSLog(@"偏移量%f",_colltectionView.contentOffset.y);

        if(_colltectionView.contentOffset.y >=  _flowLayout.itemSize.height * (_totalItemsCount - 1))
        {
            [self scrollToIndex:1 animated:NO];
            _currentIndex = 1;
            return;
        }
        if (_colltectionView.contentOffset.y <=  0) {
            [self scrollToIndex:_totalItemsCount - 2 animated:NO];
            _currentIndex = _totalItemsCount - 2;
            return;
        }
    }

    if([_pageControl isKindOfClass:[UIPageControl class]])
    {
        ((UIPageControl *)_pageControl).currentPage = [self pageControlIndex:[self currentIndex]] - 1;

    }else{
        ((TAPageControl *)self.pageControl).currentPage = ([self pageControlIndex:[self currentIndex]] - 1) < 0 ? 0 :
        ([self pageControlIndex:[self currentIndex]] - 1);

    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (_autoScroll) {
        [self invalidateTimer];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (_autoScroll) {
        [self setupTimer];
    }
}
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
    // Do your action here
    return NO;
}
@end

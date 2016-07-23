# CycleScrollView
### 支持pod导入
pod 'CycleScrollView','~> 1.0.0'

           
### 用法
```
    - (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *imagesURLStrings = @[
                                  @"http://upload.lairen.com/boUser/mobile_banner/20160721073110_banner_h.jpg",
                                  @"http://upload.lairen.com/boUser/mobile_banner/20160721104808_banner_h.jpg",
                                  @"http://upload.lairen.com/boUser/mobile_banner/20160722062839_banner_h.jpg"
                                  ];

    // 图片对应的文字配文字
    NSArray *titles = @[@"希望大家多多下载",
                        @"广泛传播",
                        @"有问题联系我1452167012@qq.com"
                        ];
    
    CycleScrollView *cycleScrollView = [CycleScrollView initCycleScrollViewWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 200) delegate:self placeholderImage:nil];
    cycleScrollView.onlyDisplayText = NO;//是否只展示文字
    cycleScrollView.hidesForSinglePage= NO;//当只有一页的时候是否隐藏pageControl
    cycleScrollView.titleStringArray = titles;//图片对应的文字配文字
    cycleScrollView.imageUrlArray = imagesURLStrings;//设置图片链接数组
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;//设置轮播图为系统经典模式
    cycleScrollView.pageDotColor = [UIColor blueColor];//设置不是当前分页控件小图标的颜色
    cycleScrollView.currentPageDotImage = IMAGE(@"1");//设置分页控件当前选中图标的背景图片
    cycleScrollView.pageDotImage = IMAGE(@"2");//设置分页控件当非前选中图标的背景图片
    cycleScrollView.autoScrollTimeInterval = 4;//设置循环滚动的时长
    cycleScrollView.autoScroll = YES;//设置是不是自动循环滚动
    cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;//设置滚动方向
    cycleScrollView.showPageControl = YES;//是不是显示分页控件
    [self.view addSubview:cycleScrollView];
    
    // Do any additional setup after loading the view, typically from a nib.
}
```
### 更多属性设置
```

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
```


    
 ---------------------------------------------------------------------------------------------------------------
![](https://github.com/liguangyi1991/CycleScrollView/blob/master/CycleScrollView/1.gif)



//
//  ViewController.m
//  CycleScrollView
//
//  Created by liguangyi on 16/7/19.
//  Copyright © 2016年 liguangyi. All rights reserved.
//

#import "ViewController.h"
#import "CycleScrollView.h"
//定义UIImage对象
#define IMAGE(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]
@interface ViewController ()<CycleScrollViewDelegate>

@end

@implementation ViewController

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)cycleScrollView:(CycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"点击第%ld",index);
}

@end

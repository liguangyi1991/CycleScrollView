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
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                  ];
    //    NSArray *imagesURLStrings = @[
    //                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg"
    
    //                                  ];
    // 图片配文字
    NSArray *titles = @[@"感谢您的支持，如果下载的",
                        @"如果代码在使用过程中出现问题",
                        @"您可以发邮件到gsdios@126.com",
                        @"感谢您的支持"
                        ];
    
    CycleScrollView *cycleScrollView = [CycleScrollView initCycleScrollViewWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 200) delegate:self placeholderImage:nil];
    cycleScrollView.onlyDisplayText = NO;
    
    cycleScrollView.hidesForSinglePage= NO;
    cycleScrollView.titleStringArray = titles;
    cycleScrollView.imageUrlArray = imagesURLStrings;
    cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    cycleScrollView.pageDotColor = [UIColor blueColor];
    cycleScrollView.currentPageDotImage = IMAGE(@"1");
    cycleScrollView.pageDotImage = IMAGE(@"2");
    cycleScrollView.autoScrollTimeInterval = 4;
    cycleScrollView.autoScroll = YES;
    cycleScrollView.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    cycleScrollView.showPageControl = YES;
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

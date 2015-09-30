//
//  LeadUIViewController.m
//  AnchorTransform
//
//  Created by renhe.cn on 15/9/30.
//  Copyright © 2015年 renhe.cn. All rights reserved.
//

#import "LeadUIViewController.h"
#import "NaviPageVC.h"
#pragma mark - 宏定义

#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH [UIScreen mainScreen].bounds.size.height

#define PageCount 6

#define anchorPointX 0.5
#define anchorPointY 2.5

#define btnH 35
#define btnW 140

@interface LeadUIViewController ()<UIScrollViewDelegate>

// 旋转视图数组
@property (nonatomic, strong) NSArray *rotateViews;
// 背景视图
@property (nonatomic, strong) UIView *backgroundView;
// 容器视图
@property (nonatomic, strong) UIView *contentView;

// 滑动视图
@property (nonatomic, strong) UIScrollView *scrollView;

// 指示器
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation LeadUIViewController

#pragma mark - 懒加载
// 旋转视图集合
- (NSArray *)rotateViews{
    if (!_rotateViews) {
        NSMutableArray *tempViewArray = [[NSMutableArray alloc]initWithCapacity:PageCount];
        // 统一设置
        for (int i = 0; i < PageCount; i++) {
            UIView *tempView = [[UIView alloc]init];
            // 注意设置anchorPoint和frame的顺序
            // 设置anchorPoint的时候会重绘
            tempView.layer.anchorPoint = CGPointMake(anchorPointX, anchorPointY);
            tempView.frame = self.view.bounds;
            
            // 取消触摸
            tempView.userInteractionEnabled = NO;
            
            // 临时测试设置颜色
            tempView.backgroundColor = [NaviPageVC randomColor];
            
            // 添加到数组中
            [tempViewArray addObject:tempView];
        }
        
        // 对非第一张显示的进行旋转
        for (int i = 1; i < tempViewArray.count; i++) {
            UIView *tempView = [tempViewArray objectAtIndex:i];
            // 旋转
            float rotateAngle = i * ((2 * M_PI) / PageCount);
            tempView.layer.transform = CATransform3DMakeRotation(rotateAngle, 0, 0, 1);
        }
        
        // 在最后一张上添加按钮
        UIView *btnView = [tempViewArray lastObject];
        UIButton *nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(screenW / 2  - btnW / 2, screenH - 121, btnW, btnH)];
        [nextBtn addTarget:self action:@selector(goMainVC) forControlEvents:UIControlEventTouchUpInside];
        nextBtn.backgroundColor = [UIColor redColor];
        
        [btnView addSubview:nextBtn];
       
        
        _rotateViews = [tempViewArray copy];
    }
    return _rotateViews;
}

// 背景视图
- (UIView *)backgroundView{
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc]init];
        _backgroundView.frame = self.view.bounds;
        _backgroundView.backgroundColor = [UIColor grayColor];
        // 取消触摸
        _backgroundView.userInteractionEnabled = NO;
    }
    return _backgroundView;
}

// 内容视图
- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
        _contentView.layer.anchorPoint = CGPointMake(anchorPointX, anchorPointY);
        _contentView.frame = self.view.bounds;
        _contentView.backgroundColor = [UIColor clearColor];
        // 取消触摸
        _contentView.userInteractionEnabled = NO;
        
    }
    return _contentView;
}

// 滑动视图
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        
        _scrollView.frame = self.view.bounds;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.delegate = self;
        
        // 设置滑动的范围
        _scrollView.contentSize = CGSizeMake(PageCount * screenW, screenH);

    }
    return _scrollView;
}

// 指示器
- (UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]init];
        _pageControl.frame = CGRectMake(screenW / 2 - 50, screenH - 20, 100, 20);
        _pageControl.numberOfPages = PageCount;
        _pageControl.currentPage = 0;
        _pageControl.pageIndicatorTintColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    }
    return _pageControl;
}
#pragma  mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    
}
- (void)configUI{
    // 注意子视图的添加顺序
    [self.view addSubview:self.backgroundView];
    [self.view addSubview:self.scrollView];
    
    // 添加视图集合
    for (UIView *view in self.rotateViews) {
        [self.contentView addSubview:view];
    }
    
    [self.view addSubview:self.contentView];
    // 指示器在最上层
    [self.view insertSubview:self.pageControl aboveSubview:self.contentView];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UIScrollDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    float offsetX = scrollView.contentOffset.x;
    // 设置指示器指示页
    int pageIndex = offsetX / screenW;
    self.pageControl.currentPage = pageIndex;

    // 旋转
    float rotatePI = (2 * M_PI) / PageCount;
    // 注意这里用负数,逆时针旋转
    float rotateScale = -offsetX / screenW;
    float rotateAngle = rotateScale * rotatePI;
    self.contentView.layer.transform = CATransform3DMakeRotation(rotateAngle, 0, 0, 1);
    
}
- (void)goMainVC{
    NSLog(@"gomainVC");
}
@end

//
//  NaviPageVC.m
//  Hecaifu_user
//
//  Created by renhe_cx on 9/9/15.
//  Copyright (c) 2015 hecaifu. All rights reserved.
//

#import "NaviPageVC.h"

#import "UIView+Extension.h"
#define screenW self.view.frame.size.width
#define screenH self.view.frame.size.height
#define pageCount 5
#define picH 2330 / 2
#define padding 690
#define topPicH 70
#define topPicW 112
#define btnH 35
#define btnW 140

@interface NaviPageVC ()<UIScrollViewDelegate>
/**
 *  底部滚动图片
 */
@property (nonatomic,strong)UIScrollView *guideView;
/**
 *  球形图片
 */
@property (nonatomic,strong)UIImageView *picView;
/**
 *  牌型滚动
 */
@property (nonatomic,strong)UIImageView *paiView;
/**
 *  指示
 */
@property (nonatomic,strong)UIPageControl *pageControl;
/**
 *  顶部图片滚动
 */
@property (nonatomic,strong)UIScrollView *topView;


@property (nonatomic, strong) NSMutableArray *leftImageViews;
@property (nonatomic, strong) NSMutableArray *rightImageViews;

@end

@implementation NaviPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI1];
    
}
+(UIColor *) randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}
// 懒加载
- (NSMutableArray *)rightImageViews{
    if (!_rightImageViews) {
        _rightImageViews = [[NSMutableArray alloc]initWithCapacity:5];
        
        for (int i = 0;i < 5; i++) {
            UIView *tempView = [[UIView alloc]init];
            tempView.frame = CGRectMake(screenW / 2.0, 100, screenW /2 - 50, screenH / 5.0);
            tempView.center = self.view.center;
            tempView.backgroundColor = [NaviPageVC randomColor];
            tempView.layer.anchorPoint = CGPointMake(0, 2);
            [self.view addSubview:tempView];
            [_rightImageViews addObject:tempView];
        }
    }
    return _rightImageViews;
}
- (void)configUI1{
    self.rightImageViews;
    /**
     滚动 辅助作用
     */
//    UIScrollView *ado_guideView = [[UIScrollView alloc] initWithFrame:self.view.frame];
//    ado_guideView.contentSize = CGSizeMake(screenW * pageCount, screenH);
//    ado_guideView.backgroundColor = [UIColor grayColor];
//    ado_guideView.bounces = NO;
//    ado_guideView.pagingEnabled = YES;
//    ado_guideView.delegate = self;
//    ado_guideView.showsHorizontalScrollIndicator = NO;
   // [self.view addSubview:ado_guideView];
    
    //UIView *view = [[UIView alloc]init];
    //CGRect frame = CGRectMake(screenW, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
}
- (void)configUI{
    /**
     背景图片
     */
    UIImageView *backView = [[UIImageView alloc]initWithFrame:self.view.frame];
    backView.backgroundColor = [UIColor clearColor];
    //backView.image = [UIImage imageNamed:@"page_bg_35"];
    [self.view addSubview:backView];
    self.view.backgroundColor = [UIColor colorWithRed:0.039 green:0.212 blue:0.341 alpha:1.000];
    
    /**
     滚动 辅助作用
     */
    UIScrollView *ado_guideView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    ado_guideView.contentSize = CGSizeMake(screenW * pageCount, screenH);
    ado_guideView.bounces = NO;
    ado_guideView.pagingEnabled = YES;
    ado_guideView.delegate = self;
    ado_guideView.showsHorizontalScrollIndicator = NO;
    
    /**
     滚动球
     */
    UIImageView *picView = [[UIImageView alloc] init];
    picView.width = picH*2;
    picView.height = picH*2;
    picView.centerX = screenW / 2;
    picView.centerY = screenH + padding;
    // 设置锚点是个坑,让旋转围绕着中心点旋转
    picView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    picView.image = [UIImage imageNamed:@"guider_qiu_35"];
    
    /**
     滚动牌
     */
    UIImageView *paiView = [[UIImageView alloc] init];
    paiView.width = picH;
    paiView.height = picH;
    paiView.centerX = screenW / 2 ;
    paiView.centerY = screenH + padding;
    // 设置描点
    paiView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    paiView.image = [UIImage imageNamed:@"guider_pai_35"];
    
    /**
     指示器
     */
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(screenW / 2 - 50, screenH - 20, 100, 20)];
    pageControl.numberOfPages = 5;
    pageControl.currentPage = 0;
    pageControl.pageIndicatorTintColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    [backView addSubview:pageControl];
    
    /**
     顶部滚动图片
     */
    UIScrollView *topView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20, screenW, topPicH)];
    topView.contentSize = CGSizeMake(screenW * pageCount, topPicH);
    topView.bounces = NO;
    topView.pagingEnabled = YES;
    for (int i = 0; i < pageCount; i ++) {
        UIImageView *topPic =  [[UIImageView alloc] init];
        topPic.width = topPicW;
        topPic.height = topPicH;
        topPic.centerX = i * screenW + screenW / 2;
        topPic.y = 0;
        NSString *picName = [NSString stringWithFormat:@"page_top_%d",i];
        topPic.image = [UIImage imageNamed:picName];
        [topView addSubview:topPic];
        
    }
    [backView addSubview:topView];
    self.topView = topView;
    
    self.pageControl = pageControl;
    [self.view addSubview:paiView];
    [self.view addSubview:picView];
    [self.view addSubview:ado_guideView];
    self.guideView = ado_guideView;
    self.picView = picView;
    self.paiView = paiView;
}
/**
 *  模态到下个页面
 *
 */
- (void)go2MainVC:(UIButton *)btn
{
    
}

/**
 *  scrollView代理方法
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
   
    
    float offSetX = scrollView.contentOffset.x;
    int index = scrollView.contentOffset.x / screenW;
    self.pageControl.currentPage = scrollView.contentOffset.x / screenW;
    // 围绕中心点旋转,这里注意角度的计算,除以3代表的就是60
    // 这点跟图片设计关联起来
    CGFloat temp_PI = M_PI / 3;
    // 取负数 - 逆时针旋转
    // 滑动的距离的百分比
    CGFloat temp_offSetW = -offSetX / screenW;
    // 旋转的角度
    CGFloat temp_Angle = temp_PI * temp_offSetW;
    
    switch (index) {
        case 0:
        {
            UIView *temp = (UIView *)[self.rightImageViews objectAtIndex:index];
            temp.layer.transform = CATransform3DMakeRotation(temp_Angle, 0, 0, 1);
        }
            break;
        case 1:
        {
            UIView *temp = (UIView *)[self.rightImageViews objectAtIndex:index];
            temp.layer.transform = CATransform3DMakeRotation(temp_Angle, 0, 0, 1);
            
        }
        case 2:
        {
            UIView *temp = (UIView *)[self.rightImageViews objectAtIndex:index];
            temp.layer.transform = CATransform3DMakeRotation(temp_Angle, 0, 0, 1);
            
        }
        case 4:
        {
            UIView *temp = (UIView *)[self.rightImageViews objectAtIndex:index];
            temp.layer.transform = CATransform3DMakeRotation(temp_Angle, 0, 0, 1);
            
        }
        case 5:
        {
            UIView *temp = (UIView *)[self.rightImageViews objectAtIndex:index];
            temp.layer.transform = CATransform3DMakeRotation(temp_Angle, 0, 0, 1);
            
        }
        default:
            break;
    }
    
    /*
    //self.picView.layer.transform = CATransform3DMakeRotation(temp_offSetW * temp_PI, 0, 0, 1);
    self.picView.layer.transform = CATransform3DMakeRotation(temp_Angle, 0, 0, 1);
    self.paiView.layer.transform = CATransform3DMakeRotation(temp_Angle, 0, 0, 1);
    
  
    if (self.pageControl.currentPage == 4) {
        UIButton *nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(screenW / 2  + offSetX - btnW / 2, screenH - 121, btnW, btnH)];
        [nextBtn addTarget:self action:@selector(go2MainVC:) forControlEvents:UIControlEventTouchUpInside];
        nextBtn.backgroundColor = [UIColor clearColor];
        [scrollView addSubview:nextBtn];
    }
    
    
    self.topView.contentOffset = CGPointMake(offSetX, 0);
     */
}
@end

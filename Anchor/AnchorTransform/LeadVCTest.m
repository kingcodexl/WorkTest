//
//  LeadVCTest.m
//  AnchorTransform
//
//  Created by renhe.cn on 15/9/29.
//  Copyright © 2015年 renhe.cn. All rights reserved.
//

#import "LeadVCTest.h"
#import "UIView+Extension.h"
#import "NaviPageVC.h"  //方便获取随机颜色

#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH [UIScreen mainScreen].bounds.size.height
#define PageCount 6
#define anchorPointY 1.8
// 描点具体是根据width或者高度比例来确定
// 比例
#define RotateRadius 1.0
@interface LeadVCTest ()<UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *viewsArray;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *contentView;

@end

@implementation LeadVCTest

#pragma mark - 初始化
- (instancetype)initWithArrays:(NSArray *)views{
    if (self = [super init]) {
        self.viewsArray = views;
    }
    return self;
}
#pragma mark - 懒加载
-(NSArray *)viewsArray{

    if (!_viewsArray) {
        NSMutableArray *M_viewArray = [[NSMutableArray alloc] initWithCapacity:PageCount];
        
        for (int i = 0; i < PageCount; i++) {
            UIView *view = [[UIView alloc]init];
            
            view.layer.anchorPoint = CGPointMake(0.5, anchorPointY);
            view.frame = self.view.bounds;
            view.backgroundColor = [NaviPageVC randomColor];
            view.userInteractionEnabled = NO;
            
            [M_viewArray addObject:view];
        }
        
        for (int i =1; i < PageCount; i++) {
            UIView *view = [M_viewArray objectAtIndex:i];
            float rotateAngle = i * (M_PI / 3);
            view.layer.transform = CATransform3DMakeRotation(rotateAngle, 0, 0, 1);
        }
        /*
        // 临时用view代替UIImageView
        // 相对偏移旋转半径
        float offsetRadius = (screenW / 2.0) / screenH;
        
        // 第一个view特殊处理
        UIView *view1 = [[UIView alloc]init];
        view1.userInteractionEnabled = NO;
        view1.layer.anchorPoint = CGPointMake(0.5, 2);
        // 特别注意顺序，因为anchorPoint的设置会改变frame
        // 所以后设置frame
         view1.frame = CGRectMake(0, 0, screenW , screenH );
        //view1.layer.position = CGPointMake(207, 368);
        NSLog(@"frame X:%f Y:%f Width:%f Height:%f",view1.x,view1.y,view1.width,view1.height);
        NSLog(@"Layer frame X:%f Y:%f Width:%f Height:%f",view1.layer.bounds.origin.x,view1.layer.bounds.origin.y,view1.layer.bounds.size.width,view1.bounds.size.height);
        NSLog(@"Position X:%f Y:%f",view1.layer.position.x,view1.layer.position.y);
        view1.backgroundColor = [NaviPageVC randomColor];
        [M_viewArray addObject:view1];
        
        // 其他view
        for (int  i = 0; i < PageCount - 2; i++) {
            UIView *temp = [[UIView alloc]init];
            
            temp.backgroundColor = [NaviPageVC randomColor];
            temp.layer.anchorPoint = CGPointMake(0.5, 0.5);
            temp.frame = CGRectMake(screenW, screenH, screenH, screenW);
            temp.userInteractionEnabled = NO;
            NSLog(@"frame X:%f Y:%f Width:%f Height:%f",temp.x,temp.y,temp.width,temp.height);
            NSLog(@"Layer frame X:%f Y:%f Width:%f Height:%f",temp.layer.bounds.origin.x,temp.layer.bounds.origin.y,temp.layer.bounds.size.width,temp.bounds.size.height);
            NSLog(@"Position X:%f Y:%f",temp.layer.position.x,temp.layer.position.y);

            [M_viewArray addObject:temp];
        }
        */
        
        _viewsArray = [M_viewArray copy];
         
    }
    return _viewsArray;
}

// 背景
- (UIView *)backView{
    if (!_backView) {
        _backView = [[UIView alloc]init];
        _backView.frame = self.view.bounds;
        _backView.backgroundColor = [UIColor grayColor];
    }
    return _backView;
    
}
// 内容View
- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
        _contentView.layer.anchorPoint = CGPointMake(0.5, anchorPointY);
        _contentView.backgroundColor = [UIColor clearColor];
        _contentView.userInteractionEnabled = NO;
        _contentView.frame = self.view.bounds;
    }
    return _contentView;
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    // Do any additional setup after loading the view.
}

- (void)configUI{
    // 添加子视图
    // 0-背景
    // 1-添加ScrollView
    // 2-添加旋转的各个View
    [self.view addSubview:self.backView];
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.bounces = NO;
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.contentSize = CGSizeMake(PageCount * screenW, screenH);
    [self.view addSubview:scrollView];
    
    for (UIView *view in self.viewsArray) {
        [self.contentView addSubview:view];
    }
    [self.view addSubview:self.contentView];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIScrollDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    float offsetX = scrollView.contentOffset.x;
    int index = offsetX / screenW;
    float rotateFactor = - offsetX /screenW;
    float real_PI = M_PI / 3;
    float realAngle = real_PI * rotateFactor;
    self.contentView.layer.transform = CATransform3DMakeRotation(realAngle, 0, 0, 1);
//    if (realAngle == M_PI / 3) {
//        UIView *temp = [self.viewsArray objectAtIndex:index];
//        temp.layer.transform = CATransform3DMakeRotation(realAngle, 0, 0, 1);
//    }
//    
//    switch (index) {
//        case 0:
//        {
//          
//            UIView *temp = [self.viewsArray objectAtIndex:index];
//            temp.layer.transform = CATransform3DMakeRotation(realAngle, 0, 0, 1);
//        }
//            break;
//        case 1:
//        {
////            UIView *temp1 = [self.viewsArray objectAtIndex:index - 1];
////            temp1.layer.transform = CATransform3DMakeRotation(realAngle, 0, 0, 1);
////            
////            UIView *temp = [self.viewsArray objectAtIndex:index];
////            temp.layer.transform = CATransform3DMakeRotation(realAngle, 0, 0, 1);
//            
//        }
//            break;
//        case 2:
//        {
//            
//            
////            UIView *temp = [self.viewsArray objectAtIndex:index];
////            temp.layer.transform = CATransform3DMakeRotation(realAngle, 0, 0, 1);
//            
//        }
//            break;
//            
//        default:
//            break;
//    }
//    if (1 == index) {
//        UIView *temp = [self.viewsArray objectAtIndex:index];
//        temp.layer.transform = CATransform3DMakeRotation(realAngle, 0, 0, 1);
//    }else{
//        if (index <= self.viewsArray.count) {
//#warning TODO
//           
//            UIView *temp = [self.viewsArray objectAtIndex:index];
//            temp.layer.transform = CATransform3DMakeRotation(realAngle, 0, 0, 1);
//        }
//        
//    }
//    
    
}
- (void)rotationView:(UIView *)view angle:(float)angle{
    view.layer.transform = CATransform3DMakeRotation(angle, 0, 0,1);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

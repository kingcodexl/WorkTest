//
//  LeadViewController.m
//  AnchorTransform
//
//  Created by renhe.cn on 15/9/29.
//  Copyright © 2015年 renhe.cn. All rights reserved.
//

#import "LeadViewController.h"
#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH [UIScreen mainScreen].bounds.size.height

@interface LeadViewController ()<UIScrollViewDelegate>
// 容器视图
@property (nonatomic, strong) UIView *contentView;
// 左视图
@property (nonatomic, strong) UIView *leftView;
// 右视图
@property (nonatomic, strong) UIView *rightView;

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation LeadViewController

- (void)viewDidLoad {
 
    [super viewDidLoad];
    [self configUI];
    // Do any additional setup after loading the view.
}
- (void)configUI{
    self.contentView = [[UIView alloc]init];
    self.leftView = [[UIView alloc]init];
    self.rightView = [[UIView alloc]init];
    self.scrollView = [[UIScrollView alloc]init];
    
    self.contentView.backgroundColor = [UIColor grayColor];
    self.leftView.backgroundColor = [UIColor yellowColor];
    self.rightView.backgroundColor = [UIColor blueColor];
    self.scrollView.backgroundColor = [UIColor yellowColor];
    self.scrollView.frame = self.view.bounds;
    self.scrollView.delegate = self;
    //self.scrollView.pagingEnabled = YES;
    // 必须设置了contentSize,滑动才会触发
    self.scrollView.contentSize = CGSizeMake(screenW * 8, screenH);
    
    float y = self.view.bounds.size.height;
    self.leftView.frame = CGRectMake(-100, 300 / 2, screenW / 2, screenH / 2);
    float x = self.view.bounds.size.width / 2.0;
    self.rightView.frame = CGRectMake(x , 200 , screenW / 5, screenH / 5);
    
    
    self.leftView.layer.anchorPoint = CGPointMake(1.0, 0.0);
    self.rightView.layer.anchorPoint = CGPointMake(0.0, 1.5);
    
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.leftView];
    [self.view addSubview:self.rightView];
    
    
    NSLog(@"right x:%f y:%f",self.rightView.layer.anchorPoint.x ,self.rightView.layer.anchorPoint.y);
    NSLog(@"left x:%f y:%f",self.leftView.layer.anchorPoint.x ,self.leftView.layer.anchorPoint.y);

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    float offSetX = scrollView.contentOffset.x;
    // 围绕中心点旋转,这里注意角度的计算,除以3代表的就是60
    // 这点跟图片设计关联起来
    CGFloat temp_PI = M_PI / 3;
    CGFloat temp_offSetW = -offSetX / screenW;
    CGFloat temp_Angle = temp_PI * temp_offSetW;
    //self.picView.layer.transform = CATransform3DMakeRotation(temp_offSetW * temp_PI, 0, 0, 1);
   
    if (offSetX > 0) {
         self.rightView.layer.transform = CATransform3DMakeRotation(temp_Angle, 0, 0, 1);
    }else{
        self.leftView.layer.transform =CATransform3DMakeRotation(temp_Angle, 0, 0, 1);
    }
//    self.paiView.layer.transform = CATransform3DMakeRotation(temp_Angle, 0, 0, 1);

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

//
//  LeadVC.m
//  AnchorTransform
//
//  Created by renhe.cn on 15/9/29.
//  Copyright © 2015年 renhe.cn. All rights reserved.
//

#import "LeadVC.h"
#import "NaviPageVC.h"
#define  count 8
#define screenW self.view.frame.size.width
#define screenH self.view.frame.size.height
#define pageCount 5

@interface LeadVC ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) NSMutableArray *images;

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation LeadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    // Do any additional setup after loading the view.
}
- (NSMutableArray *)images{
    if (!_images) {
        CGFloat temp_PI = M_PI / 3;
        for (int i = 0; i < count; i++) {
            UIView *view = [[UIView alloc]init];
            if (i <= (count / 2)) {
                view.frame = CGRectMake(i * 50,70 * i, 50, 50);
                
            }else{
                
                view.frame = CGRectMake((count - i) * 50,70 * i, 50, 50);
            }
            
            view.layer.anchorPoint = CGPointMake(0.5, 0.5);
            view.backgroundColor = [NaviPageVC randomColor];
            CGFloat real_PI = i * temp_PI;
            
            view.layer.transform = CATransform3DMakeRotation(real_PI, 0, 0, 1);
            [self.contentView addSubview:view];
        }
    }
    return _images;
}

- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
        _contentView.backgroundColor = [UIColor grayColor];
        _contentView.frame = self.view.bounds;
    }
    return _contentView;
}

- (void)configUI{
    [self.view addSubview:self.contentView];
    NSArray *images =  self.images;
    
    /**
     滚动 辅助作用
     */
//    UIScrollView *ado_guideView = [[UIScrollView alloc] initWithFrame:self.view.frame];
//    ado_guideView.contentSize = CGSizeMake(screenW * count, screenH);
//    ado_guideView.backgroundColor = [UIColor grayColor];
//    ado_guideView.bounces = NO;
//    ado_guideView.pagingEnabled = YES;
//    ado_guideView.delegate = self;
//    ado_guideView.showsHorizontalScrollIndicator = NO;
//    [self.view addSubview:ado_guideView];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    float offSetX = scrollView.contentOffset.x;
    int index = scrollView.contentOffset.x / screenW;
    // 围绕中心点旋转,这里注意角度的计算,除以3代表的就是60
    // 这点跟图片设计关联起来
    CGFloat temp_PI = M_PI / 3;
    // 取负数 - 逆时针旋转
    // 滑动的距离的百分比
    CGFloat temp_offSetW = -offSetX / screenW;
    // 旋转的角度
    CGFloat temp_Angle = temp_PI * temp_offSetW;

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

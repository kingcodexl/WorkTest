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

#define screenW self.view.frame.size.width
#define screenH self.view.frame.size.height
#define PageCount 5

// 描点具体是根据width或者高度比例来确定
// 比例
#define RotateRadius 1.0
@interface LeadVCTest ()<UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *viewsArray;

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
        // 临时用view代替UIImageView
        // 相对偏移旋转半径
        float offsetRadius = (screenW / 2.0) / screenH;
        // 第一个view特殊处理
        UIView *view1 = [[UIView alloc]init];
        view1.frame = CGRectMake(0, 0, screenW, screenH);
        view1.layer.anchorPoint = CGPointMake(0.5, 1 + offsetRadius);
        view1.backgroundColor = [NaviPageVC randomColor];
        [M_viewArray addObject:view1];
        
        // 其他view
        for (int  i = 0; i < 3; i++) {
            UIView *temp = [[UIView alloc]init];
            temp.frame = CGRectMake(screenW, screenH, screenH, screenW);
            temp.backgroundColor = [NaviPageVC randomColor];
            temp.layer.anchorPoint = CGPointMake(- offsetRadius, 0.5);
            [M_viewArray addObject:temp];
        }
        
        _viewsArray = [M_viewArray copy];
    }
    return _viewsArray;
}
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    // Do any additional setup after loading the view.
}

- (void)configUI{
    // 添加子视图
    // 1-添加ScrollView
    // 2-添加旋转的各个View
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
        [self.view addSubview:view];
    }
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

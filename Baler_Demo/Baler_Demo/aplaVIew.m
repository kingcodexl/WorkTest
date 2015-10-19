//
//  aplaVIew.m
//  Baler_Demo
//
//  Created by renhe.cn on 15/10/15.
//  Copyright © 2015年 renhe.cn. All rights reserved.
//

#import "aplaVIew.h"
#import "UIImageView+WebCache.h"

#define screenW [UIScreen mainScreen].bounds.size.width
#define screenH [UIScreen mainScreen].bounds.size.height

@interface aplaVIew(){
    UIView *bgView;         // 背景view
    UIImageView *imageView; // 显示图片
    
    UIButton *cancelButton; // 取消按钮
}
@property (nonatomic, copy) NSString *imageUrl; // 图片链接地址
@end

@implementation aplaVIew

- (instancetype)initWithFrame:(CGRect)frame imageUrlStr:(NSString *)urlStr{
    if (self = [super initWithFrame:frame]) {
        [self configView];
        self.imageUrl = urlStr;
    }
    return self;
}
- (void)configView{
    // 灰度背景
    bgView = [[UIView alloc]initWithFrame:self.bounds];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = .8f;
    [self addSubview:bgView];
    
    // 图片区域
    CGRect frame = CGRectMake(0, 0, self.bounds.size.width, 300);
    imageView = [[UIImageView alloc]initWithFrame:frame];
    imageView.center = self.center;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]init];
    [tapGesture addTarget:self action:@selector(imageViewClick:)];
    [imageView addGestureRecognizer:tapGesture];
    imageView.image = [UIImage imageNamed:@"2.png"];
     NSURL *url = [NSURL URLWithString:self.imageUrl];
    [imageView sd_setImageWithURL:url placeholderImage:nil];
    [self addSubview:imageView];
    
    // 取消button
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(screenW - 100, 30, 50, 50);
    [btn setImage:[UIImage imageNamed:@"2.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(cancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];

}
#pragma mark - 点击事件
// 图片点击事件
-(void)imageViewClick:(UITapGestureRecognizer *)gesture{
    
}
// 取消按钮点击事件
-(void)cancelBtnClick:(UIButton *)btn{
    [self removeFromSuperview];
}

// 再次点击消失
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    //[self removeFromSuperview];
//}
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
//   // return imageView;
//}
@end

//
//  ViewController.m
//  uMengShareTest
//
//  Created by renhe.cn on 15/10/8.
//  Copyright © 2015年 renhe.cn. All rights reserved.
//

#import "ShareCustomView.h"
#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kDeviceHight [UIScreen mainScreen].bounds.size.height
#define menuBtnWidth    50  //按钮宽度
#define menuBtnHeight   50  //按钮高度
#define btnxDistance    60 //按钮之间x的距离
#define btnyDistance    40 //按钮之间y的距离


@interface ShareCustomView ()
{
    UIView *shareMenuView;
    UIImageView *mainGrayBg;
    UILabel *shareToLabel1;
    UILabel *shareTolabel2;
    UIButton *cancelBtn;
    UILabel  *titleLabel;
    BOOL   isNight;
}

@property(nonatomic,retain)UIImageView *whiteBg;

@end

@implementation ShareCustomView

- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self creatMainShareView];
    }
    return self;
}

- (void)creatMainShareView
{
    mainGrayBg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHight)];
    [mainGrayBg setImage:[UIImage imageNamed:@"shareBgImg.png"]];
    [mainGrayBg  setUserInteractionEnabled:YES];
    // 不透明
    mainGrayBg.alpha = 0.0;
    mainGrayBg.backgroundColor = [UIColor colorWithRed:0.886 green:0.855 blue:0.839 alpha:1.000];
    [self addSubview:mainGrayBg];
    
    // 添加手势,mainGrayBg则从父视图中移除
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancelBtnClick:)];
    [mainGrayBg  addGestureRecognizer:tapGR];
    
    CGFloat shareMenuViewH = 150;
    shareMenuView = [[UIView alloc]initWithFrame:CGRectMake(0, kDeviceHight / 2.0 -  150 / 2.0, kDeviceWidth, shareMenuViewH)];
    [self addSubview:shareMenuView];

    [UIView animateWithDuration:0.4 animations:^{
        shareMenuView.frame =CGRectMake(0,kDeviceHight - shareMenuViewH, kDeviceWidth,shareMenuViewH);
        mainGrayBg.alpha = 1.0;
    } completion:^(BOOL finished) {
    }];
    
    _whiteBg = [[UIImageView alloc] initWithFrame:shareMenuView.bounds];
    [_whiteBg  setUserInteractionEnabled:YES];
    _whiteBg.backgroundColor = [UIColor whiteColor];
    [shareMenuView addSubview:_whiteBg];
    [self creatShareBtnView];
    
}

- (void)creatShareBtnView
{
    NSArray *titleArr = [NSArray arrayWithObjects:@"微信好友",@"新浪微博",@"微信朋友圈",@"短信", @"微信好友",@"新浪微博",@"微信朋友圈",@"短信",nil];
    NSArray *imgArr   = [NSArray arrayWithObjects:@"UMS_wechat_timeline_icon@2x",@"UMS_wechat_timeline_icon@2x",@"UMS_wechat_timeline_icon",@"UMS_wechat_timeline_icon@2x", @"UMS_wechat_timeline_icon@2x",@"UMS_wechat_timeline_icon@2x",@"UMS_wechat_timeline_icon",@"UMS_wechat_timeline_icon@2x",nil];
    int cloumsNum = 4;              //按钮列数
    int rowsNum = (int)(titleArr.count + cloumsNum - 1) / cloumsNum;                //按钮行数
    
    float viewWidth = kDeviceWidth - 30;//cloumsNum * menuBtnWidth + (cloumsNum - 1) * btnxDistance;
    float viewHeight = rowsNum * menuBtnHeight + (rowsNum - 1) * btnyDistance;
    
    UIView *buttonsView = [[UIView alloc] init];
    buttonsView.frame = CGRectMake(15,20, viewWidth, viewHeight);
    buttonsView.backgroundColor = [UIColor clearColor];
    [_whiteBg  addSubview:buttonsView];
    
    for(int i = 0; i < rowsNum; i++)
    {
        for(int j = 0; j<cloumsNum; j++)
        {
            int num = i * cloumsNum + j;
            if(num >= [titleArr count])
            {
                break ;
            }
            float btnX = j * menuBtnWidth + j * ((viewWidth - menuBtnWidth * cloumsNum) / (cloumsNum - 1));
            float btnY = i * kDeviceWidth / cloumsNum;
            
            UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            menuBtn.frame = CGRectMake(btnX, btnY, menuBtnWidth, menuBtnHeight);
            menuBtn.tag = 200 + num;
            [menuBtn setImage:[UIImage imageNamed:[imgArr objectAtIndex:num]] forState:UIControlStateNormal];
            [menuBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            buttonsView.backgroundColor = [UIColor clearColor];
            [buttonsView addSubview:menuBtn];
            
            titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 12)];
            titleLabel.font = [UIFont systemFontOfSize:12];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.textColor = [UIColor grayColor];
            titleLabel.backgroundColor = [UIColor clearColor];
            titleLabel.text = [titleArr objectAtIndex:num];
            [buttonsView addSubview:titleLabel];
            [titleLabel sizeToFit];
            titleLabel.center = CGPointMake(menuBtn.center.x, menuBtn.center.y + 40);
        }
    }
}

#pragma mark 选择分享按钮点击
- (void)shareBtnClick:(UIButton *)sender
{
    if (_shareDelegate  &&[_shareDelegate   respondsToSelector:@selector(shareBtnClickWithIndex:)]) {
        [_shareDelegate  shareBtnClickWithIndex:sender.tag];
    }
}

#pragma mark 取消分享
- (void)cancelBtnClick:(UIButton *)sender
{
    [UIView animateWithDuration:0.4 animations:^{
        shareMenuView.frame =CGRectMake(0, kDeviceHight - 20, kDeviceHight, 150);
        mainGrayBg.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
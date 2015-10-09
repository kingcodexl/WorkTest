//
//  ViewController.m
//  uMengShareTest
//
//  Created by renhe.cn on 15/10/8.
//  Copyright © 2015年 renhe.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol shareCustomDelegate <NSObject>      //协议

@required

- (void)shareBtnClickWithIndex:(int)tag;

@end

@interface ShareCustomView : UIView

@property(nonatomic,retain)id <shareCustomDelegate> shareDelegate;       //代理

@end

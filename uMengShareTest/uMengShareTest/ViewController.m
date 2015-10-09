//
//  ViewController.m
//  uMengShareTest
//
//  Created by renhe.cn on 15/10/8.
//  Copyright © 2015年 renhe.cn. All rights reserved.
//

#import "ViewController.h"
#import "shareMange/loginandshare/ShareCustomView.h"
#import "ShareManage.h"
@interface ViewController ()

@end

@implementation ViewController
- (void)awakeFromNib{
    [super awakeFromNib];
    //CGRect frame = CGRectMake(0, 0, 300, 300);
    ShareCustomView *shareView = [[ShareCustomView alloc]init];
    //shareView.center = self.view.center;
    
    self.view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:shareView];
}
- (void)viewDidLoad {
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

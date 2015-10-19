//
//  AplaViewController.m
//  Baler_Demo
//
//  Created by renhe.cn on 15/10/15.
//  Copyright © 2015年 renhe.cn. All rights reserved.
//

#import "AplaViewController.h"

@interface AplaViewController ()

@end

@implementation AplaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor grayColor];
    self.view.alpha = .5f;
    NSLog(@"width:%f height:%f  ",self.view.frame.size.width,self.view.frame.size.height);
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

//
//  ViewController.m
//  Baler_Demo
//
//  Created by renhe.cn on 15/10/15.
//  Copyright © 2015年 renhe.cn. All rights reserved.
//

#import "ViewController.h"
#import "AplaViewController.h"
#import "aplaVIew.h"
@interface ViewController ()
@property AplaViewController *temp;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _temp = [[AplaViewController alloc]init];
   
    NSLog(@"width:%f height:%f  ",self.view.frame.size.width,self.view.frame.size.height);
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)testBtn:(id)sender {
   // [self presentViewController:self.temp animated:YES completion:nil];
    aplaVIew *view = [[aplaVIew alloc]initWithFrame:self.view.bounds imageUrlStr:nil];
    [self.view addSubview:view];
}
@end

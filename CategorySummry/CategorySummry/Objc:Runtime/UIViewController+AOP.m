//
//  UIViewController+AOP.m
//  Hecaifu_user
//
//  Created by renhe.cn on 15/10/19.
//  Copyright © 2015年 hecaifu. All rights reserved.
//  友盟统计,统计用户每个页面的情况
//  使用Swill

#import "UIViewController+AOP.h"
#import <objc/runtime.h>

@implementation UIViewController (AOP)

// 文件一旦加载则调用,不用每个控制器文件都去import一次
+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        swizzleMethod([self class],
                      @selector(viewDidAppear:),
                      @selector(aop_ViewDidAppear:));
        swizzleMethod([self class],
                      @selector(viewWillAppear:),
                      @selector(aop_ViewWillAppear:));
        swizzleMethod([self class],
                      @selector(viewWillDisappear:),
                      @selector(aop_ViewWillDisapper:));
        swizzleMethod([self class],
                      @selector(viewDidDisappear:),
                      @selector(aop_ViewDidDisapper:));
        
    });
}
#pragma mark - SwizzleHelper
/**
 *  交换方法执行
 *
 *  @param class            操作的类
 *  @param orginSelector    原始选择器 
 *  @param swizzledSelector 交换选择器
 */
void swizzleMethod(Class class,SEL orginSelector,SEL swizzledSelector){
    Method orginalMethod = class_getInstanceMethod(class, orginSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    // 将原始的sel指向新的imp,并添加
    BOOL didAddMethod = class_addMethod(class,
                                        orginSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(orginalMethod));
    
    if (didAddMethod) {
        // 将交换的sel指向原来的imp
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(orginalMethod),
                            method_getTypeEncoding(orginalMethod));
    }else{
        // 交换imp
        method_exchangeImplementations(orginalMethod, swizzledMethod);
    }
}

#pragma mark - Swizzle方法

- (void)aop_ViewDidAppear:(BOOL)Animation{
    [self aop_ViewDidAppear:Animation];
}
- (void)aop_ViewWillAppear:(BOOL)Animation{
    [self aop_ViewWillAppear:Animation];
    
}

- (void)aop_ViewWillDisapper:(BOOL)Animation{
    [self aop_ViewWillDisapper:Animation];
    
}
- (void)aop_ViewDidDisapper:(BOOL)Animation{
    [self aop_ViewWillDisapper:Animation];
    
}

@end

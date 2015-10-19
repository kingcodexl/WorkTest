//
//  ObjcRuntime.m
//  CategorySummry
//
//  Created by renhe.cn on 15/10/19.
//  Copyright © 2015年 renhe.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

// 根据类名称获取类
// 系统提供 NSClassFromString(NSString *clsname)

// 获取一个类的所有属性名字:类型的名字，具有@property的, 父类的获取不了！
NSDictionary *GetPropertyListOfObject(NSObject *object);
NSDictionary *GetPropertyListOfClass(Class cls);
/**
 *  Swizzle
 *
 *  @param c       swizlle操作类
 *  @param origSEL 原方法
 *  @param newSEL  新增方法
 */
void Swizzle(Class c, SEL origSEL, SEL newSEL);
//
//  DDNSDictionary+Safe.m
//  IOSDuoduo
//
//  Created by 东邪 on 14-5-29.
//  Copyright (c) 2014年 dujia. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  安全的字典取值操作
 */
@interface NSDictionary(Safe)
/**
 *  从字典中返回对象
 *
 *  @param key 键
 *
 *  @return 对象值
 */
- (id)safeObjectForKey:(id)key;
/**
 *  从字典中返回int类型
 *
 *  @param key 键
 *
 *  @return int值
 */
- (int)intValueForKey:(id)key;

/**
 *  从字典中返回double
 *
 *  @param key 键
 *
 *  @return double值
 */
- (double)doubleValueForKey:(id)key;
/**
 *  从字典中返回字符串
 *
 *  @param key 键
 *
 *  @return 字符串
 */
- (NSString*)stringValueForKey:(id)key;

@end


@interface NSMutableDictionary(Safe)
/**
 *  添加对象
 *
 *  @param anObject 对象
 *  @param aKey     键
 */
- (void)safeSetObject:(id)anObject forKey:(id)aKey;
/**
 *  添加int,最终包装成对象
 *
 *  @param anObject int
 *  @param aKey     键
 */
- (void)setIntValue:(int)value forKey:(id)aKey;
/**
 *  添加double,最终包装成对象
 *
 *  @param anObject double
 *  @param aKey     键
 */
- (void)setDoubleValue:(double)value forKey:(id)aKey;
/**
 *  添加String
 *
 *  @param anObject string
 *  @param aKey     键
 */
- (void)setStringValueForKey:(NSString*)string forKey:(id)aKey;

@end

@interface NSArray (Exception)

- (id)objectForKey:(id)key;

@end

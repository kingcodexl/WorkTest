//
//  aplaVIew.h
//  Baler_Demo
//
//  Created by renhe.cn on 15/10/15.
//  Copyright © 2015年 renhe.cn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface aplaVIew : UIView

/**
 *  通过传入url实例化
 *
 *  @param frame  frame
 *  @param urlStr 图片的url
 *
 *  @return 实例
 */
- (instancetype)initWithFrame:(CGRect)frame imageUrlStr:(NSString *) urlStr;

@end

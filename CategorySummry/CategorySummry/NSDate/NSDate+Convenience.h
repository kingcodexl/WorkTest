//
//  NSDate+Convenience.h
//  CategorySummry
//
//  Created by renhe.cn on 15/10/19.
//  Copyright © 2015年 renhe.cn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Convenience)

-(NSDate *)offsetYear:(int)numYears;
-(NSDate *)offsetMonth:(int)numMonths;
-(NSDate *)offsetDay:(int)numDays;
-(NSDate *)offsetHours:(int)hours;

-(int)numDaysInMonth;
-(int)firstWeekDayInMonth;
-(int)year;
-(int)month;
-(int)day;

+(NSDate *)dateStartOfDay:(NSDate *)date;
+(NSDate *)dateStartOfWeek;
+(NSDate *)dateEndOfWeek;

@end

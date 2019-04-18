//
//  CalenDarTool.h
//  AreaApplication
//
//  Created by 涂欢 on 2018/7/13.
//  Copyright © 2018年 Beijing Tianjian Yuan Da Tecnology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalenDarTool : NSObject
+ (NSInteger)currentYear:(NSDate *)date;//获得当前的年份
+ (NSInteger)currentMonth:(NSDate *)date;//获得当前的月份
+ (NSInteger)currentDay:(NSDate *)date;//获得当前是哪一天
+ (NSInteger)currentMonthOfDay:(NSDate *)date;//获得本月有多少天
+ (NSInteger)preInMonth:(NSDate *)date;//获得上个月月份
+ (NSInteger)nextMonth:(NSDate *)date;//获得下个月月份
+ (NSInteger)preInMonthDay:(NSDate *)date;//获得上个月有多少天
+ (NSInteger)currentFirstDay:(NSDate *)date;//获得这个月份第一天是在星期几
+ (NSMutableArray *)currentMonthArray:(NSDate *)date;//获得这个月排布数组
+ (NSArray *)obtainSectionDaysByLimit:(NSInteger)limit;//获取当天limit天的日期
+ (NSString *) getweekDayStringWithDate:(NSDate *) date;//周几
@end


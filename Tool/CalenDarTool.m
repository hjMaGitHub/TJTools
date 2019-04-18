//
//  CalenDarTool.m
//  AreaApplication
//
//  Created by 涂欢 on 2018/7/13.
//  Copyright © 2018年 Beijing Tianjian Yuan Da Tecnology Co.,Ltd. All rights reserved.
//

#import "CalenDarTool.h"
#import "CalendarModel.h"
@implementation CalenDarTool
/**
 *  获取当前月的年份
 */
+ (NSInteger)currentYear:(NSDate *)date{
    
    NSDateComponents *componentsYear = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [componentsYear year];
}

/**
 *  获取当前月的月份
 */
+ (NSInteger)currentMonth:(NSDate *)date{
    
    NSDateComponents *componentsMonth = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [componentsMonth month];
}

/**
 *  获取当前是哪一天
 *
 */
+ (NSInteger)currentDay:(NSDate *)date{
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components day];
}

/**
 *  本月有几天
 *
 */
+ (NSInteger)currentMonthOfDay:(NSDate *)date{
    
    NSRange totaldaysInMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return totaldaysInMonth.length;
}

/**
 *  上一个月是有多少天数
 *
 */
+ (NSInteger)preInMonthDay:(NSDate *)date{
    
    NSInteger currnetYear = [CalenDarTool currentYear:date];
    NSInteger currentMonth = [CalenDarTool currentMonth:date];
    NSInteger preMonth;
    //判断上一个月是哪个月份
    if (currentMonth == 1) {
        preMonth = 12;
    }else{
        
        preMonth = currentMonth - 1;
    }
    
    //判断年份是不是闰年
    if (preMonth == 1 || preMonth == 3 || preMonth == 5 || preMonth == 7 || preMonth == 8 || preMonth == 10 || preMonth == 12) {
        return 31;
    }else if(preMonth == 2){
        //如果是闰年并且这个月份正好是二月份
        if(((currnetYear % 4 == 0) && (currnetYear % 100 == 0)) || (currnetYear % 400 == 0)){
            
            return 29;
        }else{
            
            return 28;
        }
    }else{
        
        return 30;
    }
}

/**
 *  本月第一天是星期几
 */
+ (NSInteger)currentFirstDay:(NSDate *)date{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekday - 1;
}


/**
 *  本月的上一个月是第几个月
 *
 */
+ (NSInteger)preInMonth:(NSDate *)date{
    //获取这个月月份
    NSInteger currentMonth = [CalenDarTool currentMonth:date];
    NSInteger preMonth;
    //判断上一个月是哪个月份
    if (currentMonth == 1) {
        preMonth = 12;
    }else{
        
        preMonth = currentMonth - 1;
    }
    return preMonth;
}
/**
 *  本月的下一个月是第几个月
 *
 */
+ (NSInteger)nextMonth:(NSDate *)date{
    
    //获取这个月月份
    NSInteger currentMonth = [CalenDarTool currentMonth:date];
    NSInteger preMonth;
    //判断下一个月是哪个月份
    if (currentMonth == 12) {
        preMonth = 1;
    }else{
        
        preMonth = currentMonth + 1;
    }
    return preMonth;
}

/**
 *  获得对应月份的天数数组
 *
 */
+ (NSMutableArray *)currentMonthArray:(NSDate *)date{
    
    NSMutableArray *dayArray = [NSMutableArray array];
    
    //获取上一个月是第几个月
    NSInteger preMonth = [CalenDarTool preInMonth:date];
    //获取上一个月天数
    NSInteger preDay = [CalenDarTool preInMonthDay:date];
    //获取下一个月是第几个月
    NSInteger nextMonth = [CalenDarTool nextMonth:date];
    
    //当月月份
    NSInteger currentMonth = [CalenDarTool currentMonth:date];
    
    //获得当前的年份
    NSInteger currentYear = [CalenDarTool currentYear:date];
    
    //上一个月份的年份
    NSInteger preYear = currentYear;
    if (currentMonth == 1) {
        
        preYear -= 1;
    }
    //下一个月份的年份
    NSInteger nextYear = currentYear;
    if (currentMonth == 12) {
        
        nextYear += 1;
    }
    
    NSInteger day = [self currentFirstDay:date];
    for (NSInteger i = 0; i < day; i++){
        
        [dayArray addObject:[[CalendarModel alloc]initWithYear:preYear andMonth:preMonth andDay:preDay - day + i + 1 andStatus:PRE_MONTH]];
    }
    
    NSInteger days = [self currentMonthOfDay:date];
    
    for (NSInteger i = 1; i <= days; i++) {
        [dayArray addObject:[[CalendarModel alloc]initWithYear:currentYear andMonth:currentMonth andDay:i andStatus:NOW_MONTH]];
    }
    //把剩下的空间置为空
    int lastCount = 1;
    for (NSInteger i = dayArray.count; i < 42; i ++) {
        [dayArray addObject:[[CalendarModel alloc]initWithYear:nextYear andMonth:nextMonth andDay:lastCount andStatus:NEXT_MONTH]];
        lastCount ++;
    }
    return dayArray;
}
+ (NSArray *)obtainSectionDaysByLimit:(NSInteger)limit{
    
    //1当天的日期
    NSDate *cDate = [[NSDate alloc]init];
    
    //2 日历类
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //3 获取compent
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:cDate];
    
    //4获取数据
    NSMutableArray *datas = [NSMutableArray array];
    __block NSInteger cMonth = components.month;
    __block NSInteger cYear = components.year;
    __block NSInteger cDay = components.day;
    /*
    __block NSInteger cWeek = components.weekday;
    
    CalendarModel *model = [[CalendarModel alloc]init];
    model.year = cYear;
    model.month = cMonth;
    model.day = cDay;
    NSArray *tmpweekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    model.weekStr = [tmpweekdays objectAtIndex:cWeek];
    [datas addObject:model];*/
    
    for(int i = 0;i < limit;i ++){
        
        //首先判断现在日期是否超出
        [self isOverMonth:cMonth andYear:cYear andDay:cDay resultDate:^(NSInteger year, NSInteger month, NSInteger day,NSString *week) {
            
            cYear = year;
            cMonth = month;
            cDay = day;
            
            CalendarModel *model = [[CalendarModel alloc]init];
            model.year = cYear;
            model.month = cMonth;
            model.day = cDay;
            model.weekStr = week;
            [datas addObject:model];
        }];
    }
    
    return datas;
}

+ (NSString *) getweekDayStringWithDate:(NSDate *) date
{
    NSCalendar *calendars = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [calendars components:NSCalendarUnitWeekday fromDate:date];
    
    // 1 是周日，2是周一 3.以此类推
    NSNumber * weekNumber = @([comps weekday]);
    NSInteger weekInt = [weekNumber integerValue];
    NSString *weekDayString = @"周一";
    switch (weekInt) {
            
        case 1:
        {
            weekDayString = @"周日";
        }
            break;
        case 2:
        {
            weekDayString = @"周一";
        }
            break;
        case 3:
        {
            weekDayString = @"周二";
        }
            break;
        case 4:
        {
            weekDayString = @"周三";
        }
            break;
        case 5:
        {
            weekDayString = @"周四";
        }
            break;
        case 6:
            
        {
            weekDayString = @"周五";
        }
            break;
        case 7:
        {
            weekDayString = @"周六";
        }
            break;
        default:
            
            break;
    }
    return weekDayString;
}
//获取时间
+ (void)isOverMonth:(NSInteger)cMonth andYear:(NSInteger)cYear andDay:(NSInteger)cDay resultDate:(void(^)(NSInteger year,NSInteger month,NSInteger day,NSString *week))dateBlock{
    
    //本月天数默认30
    NSInteger day = 30;
    //是否需要注意年份
    BOOL attentionYear = NO;
    
    if(cMonth == 2){
        
        if ((cYear % 4 == 0 && cYear % 100 != 0) || cYear % 400 == 0) {
            //是闰年 29天
            day = 29;
            
        }else{
            day = 28;
            
        }
    }else if (cMonth == 1
              || cMonth == 3
              || cMonth == 1
              ||cMonth == 5
              ||cMonth == 7
              ||cMonth == 8
              ||cMonth == 10){
        day = 31;
        
    }else if (cMonth == 12){
        //12月份需要注意年份
        day = 31;
        attentionYear = YES;
    }else
        day = 30;
    
    //计算年月日
    if (cDay >= day) {
        
        cDay = 1;
        if (attentionYear) {
            
            cMonth = 1;
            cYear ++;
        }else
            cMonth ++;
    }else{
        
        cDay ++;
    }
    
    //获取星期
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    NSCalendar *calendars = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSDateComponents *theComponents = [calendars components:calendarUnit fromDate:[fmt dateFromString:[NSString stringWithFormat:@"%li-%li-%li",cYear,cMonth,cDay]]];
    //返回年月日
    dateBlock(cYear,cMonth,cDay,[weekdays objectAtIndex:theComponents.weekday]);
}


@end


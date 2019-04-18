//
//  IDTool.m
//  我的工具
//
//  Created by 吕强 on 16/7/28.
//  Copyright © 2017年 Beijing Tianjian Yuan Da Tecnology Co.,Ltd. All rights reserved.
//

#import "IDTool.h"
#import "UIImage+GeometricZoom.h"
#import <AudioToolbox/AudioToolbox.h>

#define SCALE_WIDTH(x) (([UIScreen mainScreen].bounds.size.width/320.0)*(x))
NSString *dbKey  = @"sentriesinthezipfileinitialize0";
NSString *dataPW = @"1cTransform.TransformFinalBlock";

@implementation IDTool

+(NSString*)plat
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        return @"ipad";
    }
    else
    {
        return @"iphone";
    }
}

+(NSString*)model
{
    return [UIDevice currentDevice].model;
}

+(NSString*)deviceInfo
{
    static NSString *deviceI = nil;
    if (!deviceI) {
        deviceI = [[NSString alloc] initWithFormat:@"%@ %@",[UIDevice currentDevice].model,[[UIDevice currentDevice] systemVersion]];
    }
    return deviceI;
}


+ (UIImage*)createImageWithColor:(UIColor*)color Size:(CGSize)size
{
    CGRect rect=CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage*theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+(UIImage*)getImageSize:(NSString*)imgPath Ext:(NSString*)strExt Size:(CGSize)size
{
    UIImage *image = nil;
    @autoreleasepool {
        NSData *data = [NSData dataWithContentsOfFile:imgPath];
        if (data) {
            image = [UIImage imageWithData:data scale:1];
            
            CGFloat width = image.size.width;
            CGFloat height = image.size.height;
            
            float verticalRadio = size.height*1.0/height;
            float horizontalRadio = size.width*1.0/width;
            float radio = 1;
            if(verticalRadio>1 && horizontalRadio>1)
            {
                radio = verticalRadio > horizontalRadio ? verticalRadio : horizontalRadio;
            }
            else
            {
                radio = verticalRadio < horizontalRadio ? horizontalRadio : verticalRadio;
            }
            width = width*radio;
            height = height*radio;
            
            image = [image scaleToSize:CGSizeMake(width, height)];
            image = [image cutToRect:CGRectMake((width - size.width)/2.0, (height - size.height)/2.0, size.width, size.height)];
        }
    }
    return image;
}

+ (NSString*)encodeURL:(NSString *)string
{
    CFStringRef ref = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)string, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    NSString *newString = (NSString*)CFBridgingRelease(ref);
    if (newString) {
        return newString;
    }
    return @"";
    
}

//+(BOOL)connectedToNetwork
//{
//    //创建零地址，0.0.0.0的地址表示查询本机的网络连接状态
//    struct sockaddr_storage zeroAddress;
//    
//    bzero(&zeroAddress, sizeof(zeroAddress));
//    zeroAddress.ss_len = sizeof(zeroAddress);
//    zeroAddress.ss_family = AF_INET;
//    
//    // Recover reachability flags
//    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
//    SCNetworkReachabilityFlags flags;
//    
//    //获得连接的标志
//    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
//    CFRelease(defaultRouteReachability);
//    
//    //如果不能获取连接标志，则不能连接网络，直接返回
//    if (!didRetrieveFlags)
//    {
//        return NO;
//    }
//    //根据获得的连接标志进行判断
//    
//    BOOL isReachable = flags & kSCNetworkFlagsReachable;
//    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
//    return (isReachable&&!needsConnection) ? YES : NO;
//}
//
//+(BOOL)isWIFIConnection
//{
//    BOOL ret = YES;
//    struct ifaddrs * first_ifaddr, * current_ifaddr;
//    NSMutableArray* activeInterfaceNames = [[NSMutableArray alloc] init];
//    getifaddrs( &first_ifaddr );
//    current_ifaddr = first_ifaddr;
//    while( current_ifaddr!=NULL )
//    {
//        if( current_ifaddr->ifa_addr->sa_family==0x02 )
//        {
//            [activeInterfaceNames addObject:[NSString stringWithFormat:@"%s", current_ifaddr->ifa_name]];
//        }
//        current_ifaddr = current_ifaddr->ifa_next;
//    }
//    ret = [activeInterfaceNames containsObject:@"en0"] || [activeInterfaceNames containsObject:@"en1"];
//    return ret;
//}

//System Sound Services
+(void)playSoundWithName:(NSString *)soundName withType:(NSString *)type
{
    NSString *path = [[NSBundle mainBundle] pathForResource:soundName ofType:type];
    //创建路径
    CFURLRef soundURL = (__bridge CFURLRef)[NSURL fileURLWithPath:path];
    SystemSoundID soundID;
    OSStatus status = AudioServicesCreateSystemSoundID(soundURL, &soundID);
    if(status == 0)
        AudioServicesPlaySystemSound(soundID);//播放声音
    else
    {
        NSLog(@"AudioServicesCreateSystemSoundID error = %lld",(long long)status);
    }
}
//震动
+(void)shakeMobiledevice
{
    AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);
}

+ (BOOL)valiMobile:(NSString *)mobile{
    if (mobile.length < 11)
    {
        return NO;
    }else{
        /**
         *  Mobile
         *
         */
        NSString * MOBILE = @"^1(3[0-9]|5[0-3,5-9]|6[6]|7[0135678]|8[0-9]|9[89])\\d{8}$";
        
        /**
         * 中国移动：China Mobile
         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,183,187,188,198[0-9]
         */
        //    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2378])\\d)\\d{7}$";
        NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2378]|9[8])\\d)\\d{7}$";
        /**
         * 中国联通：China Unicom
         * 130,131,132,152,155,156,176,185,186，166[0-9]
         */
        //    NSString * CU = @"^1(3[0-2]|5[256]|7[6]|8[56])\\d{8}$";
        NSString * CU = @"^1(3[0-2]|5[256]|7[6]|8[56]|6[6])\\d{8}$";
        /**
         * 中国电信：China Telecom
         * 133,1349,153,180,189,199[0-9]
         */
        //    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
        NSString * CT = @"^1((33|53|8[09]|9[9])[0-9]|349)\\d{7}$";
        /**
         25 * 大陆地区固话及小灵通
         26 * 区号：010,020,021,022,023,024,025,027,028,029
         27 * 号码：七位或八位
         28 */
        // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
        
        NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
        NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
        NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
        NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
        
        if (([regextestmobile evaluateWithObject:mobile] == YES)
            || ([regextestcm evaluateWithObject:mobile] == YES)
            || ([regextestct evaluateWithObject:mobile] == YES)
            || ([regextestcu evaluateWithObject:mobile] == YES))
        {
            return YES;
        }else{
            return NO;
        }
    }
    return YES;
}




+ (BOOL)isPhoneNumber:(NSString *)phoneNum
{
    /**
     * 手机号码
     */
    //    NSString *MOBILE = @"^((19[0-9])|(11[0-9])|(12[0-9])|(17[0-9])|(13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    /**
     * 固定电话号码
     */
    NSString *PHS = @"(^((0[1,2]{1}\\d{1}-?\\d{8})|(0[3-9]{1}\\d{2}-?\\d{7,8}))$)|(^0?(13[0-9]|15[0-35-9]|18[0236789]|14[57])[0-9]{8}$)";
    /**
     * 固定电话号码分机
     */
    NSString *PHS1 = @"^0\\d{2,3}-\\d{7,8}-\\d{1,4}$|^0\\d{2,3}-\\d{7,8}$";
    NSPredicate *regextestPHS = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS];
    NSPredicate *regextestPHS1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PHS1];
    
    BOOL ismobilePhoneNum = [self isMobileNumber:phoneNum];
    
    if (ismobilePhoneNum == YES || ([regextestPHS evaluateWithObject:phoneNum] == YES) || [regextestPHS1 evaluateWithObject:phoneNum] == YES)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+ (BOOL)isAccount:(NSString *)strAccount
{
    NSString *strPure = @"^[a-zA-z][a-zA-Z0-9_]{3,15}$";
    NSPredicate *regextestAccount = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", strPure];
    if (([regextestAccount evaluateWithObject:strAccount] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+ (BOOL)isPureNumber:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    long long val;
    return[scan scanLongLong:&val] && [scan isAtEnd];
}
+ (BOOL)checkUserIdCard:(NSString*)idCard{
    
    NSString *pattern =@"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    BOOL isMatch = [pred evaluateWithObject:idCard];
    return isMatch;
}

//身份证号
+ (BOOL)validateIdentityCard: (NSString *)identityCard
{
    BOOL flag = NO;
    if (identityCard.length <= 0) {
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    flag = [identityCardPredicate evaluateWithObject:identityCard];
    return flag;
}

+ (BOOL)validateIDCardNumber:(NSString *)value {
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSInteger length = 0;
    if (!value) {
        return NO;
    }else {
        length = value.length;
        
        if (length != 15 && length !=18) {
            return NO;
        }
    }
    // 省份代码
    NSArray *areasArray =@[@"11", @"12", @"13", @"14", @"15", @"21", @"22", @"23", @"31", @"32", @"33", @"34", @"35", @"36", @"37", @"41", @"42", @"43", @"44", @"45", @"46", @"50", @"51", @"52", @"53", @"54", @"61", @"62", @"63", @"64", @"65", @"71", @"81", @"82", @"91"];
    
    NSString *valueStart2 = [value substringToIndex:2];
    BOOL areaFlag = NO;
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag =YES;
            break;
        }
    }
    
    if (!areaFlag) {
        return false;
    }
    
    
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    
    int year = 0;
    switch (length) {
        case 15:
            year = [value substringWithRange:NSMakeRange(6,2)].intValue +1900;
            
            if (year % 4 ==0 || (year % 100 ==0 && year % 4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];// 测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];// 测试出生日期的合法性
            }
            
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            if(numberofMatch > 0) {
                return YES;
            }else {
                return NO;
            }
        case 18:
            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            if (year % 4 ==0 || (year % 100 ==0 && year % 4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}(19|2[0-9])[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];// 测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}(19|2[0-9])[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];// 测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            if(numberofMatch > 0) {
                int S = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
                int Y = S % 11;
                NSString *M = @"F";
                NSString *JYM = @"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y,1)]; // 判断校验位
                if ([M isEqualToString:[value substringWithRange:NSMakeRange(17,1)]]) {
                    return YES;// 检测ID的校验位
                }else {
                    return NO;
                }
                
            }else {
                return NO;
            }
        default:
            return NO;
    }
}

+ (double)brithDayToAge:(long long)birthDay
{
    if (birthDay <= 0) {
        return 0;
    }
    long long time = birthDay / 1000;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSTimeInterval dateDiff = [date timeIntervalSinceNow];
    double age = fabs(trunc(dateDiff/( 60 * 60 * 24)) / 365.0);
    return age;
}

+ (UIImage*)mergedImageOnMainImage:(CGFloat)nhW WithImageArray:(NSArray *)imgArray
{
    CGSize size = CGSizeMake(nhW, nhW);
    UIGraphicsBeginImageContext(size);
    if ([imgArray count] >= 5) {
        CGFloat imgHW = (size.width - SCALE_WIDTH(4))/3.0;
        if([imgArray count]  == 5)
        {
            UIImage *img = imgArray[0];
            img =  [UIImage createRoundedRectImage:img size:size];
            [img drawInRect:CGRectMake((size.width - (2*imgHW+SCALE_WIDTH(1)))/2 ,(size.width - (2*imgHW+SCALE_WIDTH(1)))/2,imgHW,imgHW)];
            img = imgArray[1];
            img =  [UIImage createRoundedRectImage:img size:size];
            [img drawInRect:CGRectMake((size.width - (2*imgHW+SCALE_WIDTH(1)))/2+imgHW+SCALE_WIDTH(1),(size.width - (2*imgHW+SCALE_WIDTH(1)))/2,imgHW,imgHW)];
            img = imgArray[2];
            img =  [UIImage createRoundedRectImage:img size:size];
            [img drawInRect:CGRectMake(SCALE_WIDTH(1),(size.width - (2*imgHW+SCALE_WIDTH(1)))/2+(imgHW+SCALE_WIDTH(1)),imgHW,imgHW)];
            img = imgArray[3];
            img =  [UIImage createRoundedRectImage:img size:size];
            [img drawInRect:CGRectMake(SCALE_WIDTH(1)+imgHW+SCALE_WIDTH(1),(size.width - (2*imgHW+SCALE_WIDTH(1)))/2+(imgHW+SCALE_WIDTH(1)),imgHW,imgHW)];
            img = imgArray[4];
            img =  [UIImage createRoundedRectImage:img size:size];
            [img drawInRect:CGRectMake(SCALE_WIDTH(1)+imgHW+SCALE_WIDTH(1)+imgHW+SCALE_WIDTH(1),(size.width - (2*imgHW+SCALE_WIDTH(1)))/2+(imgHW+SCALE_WIDTH(1)),imgHW,imgHW)];
        }
        else if([imgArray count]  == 6)
        {
            UIImage *img = imgArray[0];
            img =  [UIImage createRoundedRectImage:img size:size];
            [img drawInRect:CGRectMake(SCALE_WIDTH(1) ,(size.width - (2*imgHW+SCALE_WIDTH(1)))/2,imgHW,imgHW)];
            img = imgArray[1];
            img =  [UIImage createRoundedRectImage:img size:size];
            [img drawInRect:CGRectMake(SCALE_WIDTH(1)+imgHW+SCALE_WIDTH(1),(size.width - (2*imgHW+SCALE_WIDTH(1)))/2,imgHW,imgHW)];
            img = imgArray[2];
            img =  [UIImage createRoundedRectImage:img size:size];
            [img drawInRect:CGRectMake(SCALE_WIDTH(1)+imgHW+SCALE_WIDTH(1)+imgHW+SCALE_WIDTH(1),(size.width - (2*imgHW+SCALE_WIDTH(1)))/2,imgHW,imgHW)];
            img = imgArray[3];
            img =  [UIImage createRoundedRectImage:img size:size];
            [img drawInRect:CGRectMake(SCALE_WIDTH(1),(size.width - (2*imgHW+SCALE_WIDTH(1)))/2+(imgHW+SCALE_WIDTH(1)),imgHW,imgHW)];
            img = imgArray[4];
            img =  [UIImage createRoundedRectImage:img size:size];
            [img drawInRect:CGRectMake(SCALE_WIDTH(1)+imgHW+SCALE_WIDTH(1),(size.width - (2*imgHW+SCALE_WIDTH(1)))/2+(imgHW+SCALE_WIDTH(1)),imgHW,imgHW)];
            img = imgArray[5];
            img =  [UIImage createRoundedRectImage:img size:size];
            [img drawInRect:CGRectMake(SCALE_WIDTH(1)+imgHW+SCALE_WIDTH(1)+imgHW+SCALE_WIDTH(1),(size.width - (2*imgHW+SCALE_WIDTH(1)))/2+(imgHW+SCALE_WIDTH(1)),imgHW,imgHW)];
        }
        else if([imgArray count]  == 7)
        {
            UIImage *img = imgArray[0];
            img =  [UIImage createRoundedRectImage:img size:size];
            [img drawInRect:CGRectMake((size.width - imgHW)/2,SCALE_WIDTH(1),imgHW,imgHW)];
            img = imgArray[1];
            img =  [UIImage createRoundedRectImage:img size:size];
            [img drawInRect:CGRectMake(SCALE_WIDTH(1),SCALE_WIDTH(1)+(imgHW+SCALE_WIDTH(1)),imgHW,imgHW)];
            img = imgArray[2];
            img =  [UIImage createRoundedRectImage:img size:size];
            [img drawInRect:CGRectMake(SCALE_WIDTH(1)+(imgHW+SCALE_WIDTH(1)),SCALE_WIDTH(1)+(imgHW+SCALE_WIDTH(1)),imgHW,imgHW)];
            img = imgArray[3];
            img =  [UIImage createRoundedRectImage:img size:size];
            [img drawInRect:CGRectMake(SCALE_WIDTH(1)+imgHW+SCALE_WIDTH(1)+imgHW+SCALE_WIDTH(1),SCALE_WIDTH(1)+(imgHW+SCALE_WIDTH(1)),imgHW,imgHW)];
            img = imgArray[4];
            img =  [UIImage createRoundedRectImage:img size:size];
            [img drawInRect:CGRectMake(SCALE_WIDTH(1),SCALE_WIDTH(1)+(imgHW+SCALE_WIDTH(1))*2,imgHW,imgHW)];
            img = imgArray[5];
            img =  [UIImage createRoundedRectImage:img size:size];
            [img drawInRect:CGRectMake(SCALE_WIDTH(1)+imgHW+SCALE_WIDTH(1),SCALE_WIDTH(1)+(imgHW+SCALE_WIDTH(1))*2,imgHW,imgHW)];
            img = imgArray[6];
            img =  [UIImage createRoundedRectImage:img size:size];
            [img drawInRect:CGRectMake(SCALE_WIDTH(1)+imgHW+SCALE_WIDTH(1)+imgHW+SCALE_WIDTH(1),SCALE_WIDTH(1)+(imgHW+SCALE_WIDTH(1))*2,imgHW,imgHW)];
        }
        else if([imgArray count]  == 8)
        {
            UIImage *img = imgArray[0];
            img =  [UIImage createRoundedRectImage:img size:size];
            [img drawInRect:CGRectMake((size.width - imgHW*2-1)/2,1,imgHW,imgHW)];
            img = imgArray[1];
            img =  [UIImage createRoundedRectImage:img size:size];
            [img drawInRect:CGRectMake((size.width - imgHW*2-1)/2+(imgHW+SCALE_WIDTH(1)),1,imgHW,imgHW)];
            img = imgArray[2];
            img =  [UIImage createRoundedRectImage:img size:size];
            [img drawInRect:CGRectMake(SCALE_WIDTH(1),SCALE_WIDTH(1)+(imgHW+SCALE_WIDTH(1)),imgHW,imgHW)];
            img = imgArray[3];
            img =  [UIImage createRoundedRectImage:img size:size];
            [img drawInRect:CGRectMake(SCALE_WIDTH(1)+(imgHW+SCALE_WIDTH(1)),SCALE_WIDTH(1)+(imgHW+SCALE_WIDTH(1)),imgHW,imgHW)];
            img = imgArray[4];
            img =  [UIImage createRoundedRectImage:img size:size];
            [img drawInRect:CGRectMake(SCALE_WIDTH(1)+imgHW+SCALE_WIDTH(1)+imgHW+SCALE_WIDTH(1),SCALE_WIDTH(1)+(imgHW+SCALE_WIDTH(1)),imgHW,imgHW)];
            img = imgArray[5];
            img =  [UIImage createRoundedRectImage:img size:size];
            [img drawInRect:CGRectMake(SCALE_WIDTH(1),SCALE_WIDTH(1)+(imgHW+SCALE_WIDTH(1))*2,imgHW,imgHW)];
            img = imgArray[6];
            img =  [UIImage createRoundedRectImage:img size:size];
            [img drawInRect:CGRectMake(SCALE_WIDTH(1)+imgHW+SCALE_WIDTH(1),SCALE_WIDTH(1)+(imgHW+SCALE_WIDTH(1))*2,imgHW,imgHW)];
            img = imgArray[7];
            img =  [UIImage createRoundedRectImage:img size:size];
            [img drawInRect:CGRectMake(SCALE_WIDTH(1)+imgHW+SCALE_WIDTH(1)+imgHW+SCALE_WIDTH(1),SCALE_WIDTH(1)+(imgHW+SCALE_WIDTH(1))*2,imgHW,imgHW)];
        }
        else if([imgArray count]  >= 9)
        {
            UIImage *img = imgArray[0];
            img =  [UIImage createRoundedRectImage:img size:size];
            [img drawInRect:CGRectMake(SCALE_WIDTH(1),1,imgHW,imgHW)];
            img = imgArray[1];
            img =  [UIImage createRoundedRectImage:img size:size];
            [img drawInRect:CGRectMake(SCALE_WIDTH(1)+imgHW+SCALE_WIDTH(1),1,imgHW,imgHW)];
            img = imgArray[2];
            img =  [UIImage createRoundedRectImage:img size:size];
            [img drawInRect:CGRectMake(SCALE_WIDTH(1)+imgHW+SCALE_WIDTH(1)+imgHW+SCALE_WIDTH(1),1,imgHW,imgHW)];
            img = imgArray[3];
            img =  [UIImage createRoundedRectImage:img size:size];
            [img drawInRect:CGRectMake(SCALE_WIDTH(1),SCALE_WIDTH(1)+(imgHW+SCALE_WIDTH(1)),imgHW,imgHW)];
            img = imgArray[4];
            img =  [UIImage createRoundedRectImage:img size:size];
            [img drawInRect:CGRectMake(SCALE_WIDTH(1)+(imgHW+SCALE_WIDTH(1)),SCALE_WIDTH(1)+(imgHW+SCALE_WIDTH(1)),imgHW,imgHW)];
            img = imgArray[5];
            img =  [UIImage createRoundedRectImage:img size:size];
            [img drawInRect:CGRectMake(SCALE_WIDTH(1)+imgHW+SCALE_WIDTH(1)+imgHW+SCALE_WIDTH(1),SCALE_WIDTH(1)+(imgHW+SCALE_WIDTH(1)),imgHW,imgHW)];
            img = imgArray[6];
            img =  [UIImage createRoundedRectImage:img size:size];
            [img drawInRect:CGRectMake(SCALE_WIDTH(1),SCALE_WIDTH(1)+(imgHW+SCALE_WIDTH(1))*2,imgHW,imgHW)];
            img = imgArray[7];
            img =  [UIImage createRoundedRectImage:img size:size];
            [img drawInRect:CGRectMake(SCALE_WIDTH(1)+imgHW+SCALE_WIDTH(1),SCALE_WIDTH(1)+(imgHW+SCALE_WIDTH(1))*2,imgHW,imgHW)];
            img = imgArray[8];
            img =  [UIImage createRoundedRectImage:img size:size];
            [img drawInRect:CGRectMake(SCALE_WIDTH(1)+imgHW+SCALE_WIDTH(1)+imgHW+SCALE_WIDTH(1),SCALE_WIDTH(1)+(imgHW+SCALE_WIDTH(1))*2,imgHW,imgHW)];
        }
    }
    else
    {
        CGFloat imgHW = size.width/3*2.0 - SCALE_WIDTH(2);
        if([imgArray count]  == 2)
        {
            imgHW = (size.width- SCALE_WIDTH(3))/2.0;
            for (NSInteger ii = 0; ii < [imgArray count]; ii++) {
                UIImage *img = imgArray[ii];
                img =  [UIImage createRoundedRectImage:img size:size];
                [img drawInRect:CGRectMake(SCALE_WIDTH(1)+(imgHW+SCALE_WIDTH(1))*ii,(size.width - imgHW)/2,imgHW,imgHW)];
            }
        }
        else if([imgArray count]  == 3)
        {
            imgHW = (size.width - SCALE_WIDTH(3))/2.0;
            UIImage *img = imgArray[0];
            img =  [UIImage createRoundedRectImage:img size:size];
            [img drawInRect:CGRectMake((size.width - imgHW)/2,SCALE_WIDTH(1),imgHW,imgHW)];
            img = imgArray[1];
            img =  [UIImage createRoundedRectImage:img size:size];
            [img drawInRect:CGRectMake(SCALE_WIDTH(1),SCALE_WIDTH(1)+imgHW+SCALE_WIDTH(1),imgHW,imgHW)];
            img = imgArray[2];
            img =  [UIImage createRoundedRectImage:img size:size];
            [img drawInRect:CGRectMake(SCALE_WIDTH(1)+imgHW+SCALE_WIDTH(1),SCALE_WIDTH(1)+imgHW+SCALE_WIDTH(1),imgHW,imgHW)];
        }
        else if([imgArray count]  == 4)
        {
            imgHW = (size.width- SCALE_WIDTH(3))/2;
            UIImage *img = imgArray[0];
            img =  [UIImage createRoundedRectImage:img size:size];
            [img drawInRect:CGRectMake(SCALE_WIDTH(1),1,imgHW,imgHW)];
            img = imgArray[1];
            img =  [UIImage createRoundedRectImage:img size:size];
            [img drawInRect:CGRectMake((SCALE_WIDTH(1)+imgHW)+SCALE_WIDTH(1),SCALE_WIDTH(1),imgHW,imgHW)];
            img = imgArray[2];
            img =  [UIImage createRoundedRectImage:img size:size];
            [img drawInRect:CGRectMake(SCALE_WIDTH(1),SCALE_WIDTH(1)+imgHW+SCALE_WIDTH(1),imgHW,imgHW)];
            img = imgArray[3];
            img =  [UIImage createRoundedRectImage:img size:size];
            [img drawInRect:CGRectMake(SCALE_WIDTH(1)+imgHW+SCALE_WIDTH(1),SCALE_WIDTH(1)+imgHW+SCALE_WIDTH(1),imgHW,imgHW)];
        }
        else
        {
            UIImage *img = imgArray[0];
            img =  [UIImage createRoundedRectImage:img size:size];
            [img drawInRect:CGRectMake((size.width - imgHW)/2,(size.width - imgHW)/2,imgHW,imgHW)];
        }
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIViewController *)getCurVC
{
    UIViewController *showVC = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        showVC = nextResponder;
    else
        showVC = window.rootViewController;
    
    return showVC;
}


+ (void)judgeTheDigitalTypeJudgment:(UITextField *)textfield CN:(NSInteger)chinaT EN:(NSInteger)engT
{
    NSString *toBeString = textfield.text;
    NSString *lang = [[UIApplication sharedApplication]textInputMode].primaryLanguage; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textfield markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textfield positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > chinaT) {
                textfield.text = [toBeString substringToIndex:chinaT];
            }
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (toBeString.length > engT) {
            textfield.text = [toBeString substringToIndex:engT];
        }
    }
}

+(NSNumber *)ageFromIdentityCard:(NSString *)numberStr {
    NSNumber *result = [NSNumber numberWithInt:0];
    NSString *birthday = nil;

//    //年龄按照年算
//    BOOL isAllNumber = YES;
//    if([numberStr length]<14)
//        return result;
//    if (numberStr.length == 18) {
//        //**截取前14位
//        NSString *fontNumer = [numberStr substringWithRange:NSMakeRange(0, 13)];
//
//        //**检测前14位否全都是数字;
//        const char *str = [fontNumer UTF8String];
//        const char *p = str;
//        while (*p!='\0') {
//            if(!(*p>='0'&&*p<='9'))
//                isAllNumber = NO;
//            p++;
//        }
//
//        if(!isAllNumber)
//            return result;
//
//        birthday = [numberStr substringWithRange:NSMakeRange(6, 4)];
//
//        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//        [formatter setDateFormat:@"yyyy"];
//        NSString *nowYear = [formatter stringFromDate:[NSDate date]];
//        int age = nowYear.intValue-birthday.intValue;
//        if (age < 0) {
//            age = -1;
//        }
//        return [NSNumber numberWithDouble:age];
//
//    }else{
//        NSString *fontNumer = [numberStr substringWithRange:NSMakeRange(0, 11)];
//
//        //**检测前14位否全都是数字;
//        const char *str = [fontNumer UTF8String];
//        const char *p = str;
//        while (*p!='\0') {
//            if(!(*p>='0'&&*p<='9'))
//                isAllNumber = NO;
//            p++;
//        }
//
//        if(!isAllNumber)
//            return result;
//
//        birthday = [numberStr substringWithRange:NSMakeRange(6, 6)];
//        birthday = [NSString stringWithFormat:@"19%@",birthday];
//
//        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//        [formatter setDateFormat:@"yyyy"];
//        NSString *nowYear = [formatter stringFromDate:[NSDate date]];
//        int age = nowYear.intValue-birthday.intValue;
//        if (age < 0) {
//            age = -1;
//        }
//        return [NSNumber numberWithDouble:age];
//
//    }
    
//    年龄按照生日算
    BOOL isAllNumber = YES;
    if([numberStr length]<14)
        return result;
    if (numberStr.length == 18) {
        //**截取前14位
        NSString *fontNumer = [numberStr substringWithRange:NSMakeRange(0, 13)];
        
        //**检测前14位否全都是数字;
        const char *str = [fontNumer UTF8String];
        const char *p = str;
        while (*p!='\0') {
            if(!(*p>='0'&&*p<='9'))
                isAllNumber = NO;
            p++;
        }
        
        if(!isAllNumber)
            return result;
        
        birthday = [numberStr substringWithRange:NSMakeRange(6, 8)];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyyMMdd"];
        NSDate *date = [formatter dateFromString:birthday];
    
        NSTimeInterval dateDiff = [date timeIntervalSinceNow];
        double age = fabs(trunc(dateDiff/( 60 * 60 * 24)) / 365.0);
        return [NSNumber numberWithDouble:age];
        
    }else{
        NSString *fontNumer = [numberStr substringWithRange:NSMakeRange(0, 11)];
        
        //**检测前14位否全都是数字;
        const char *str = [fontNumer UTF8String];
        const char *p = str;
        while (*p!='\0') {
            if(!(*p>='0'&&*p<='9'))
                isAllNumber = NO;
            p++;
        }
        
        if(!isAllNumber)
            return result;
        
        birthday = [numberStr substringWithRange:NSMakeRange(6, 6)];
        birthday = [NSString stringWithFormat:@"19%@",birthday];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyyMMdd"];
        NSDate *date = [formatter dateFromString:birthday];
        
        NSTimeInterval dateDiff = [date timeIntervalSinceNow];
        double age = fabs(trunc(dateDiff/( 60 * 60 * 24)) / 365.0);
        return [NSNumber numberWithDouble:age];
        
    }
}
//根据身份证号码转换成生日
+(NSString *)birthdayStrFromIdentityCard:(NSString *)numberStr{
    
    //    if(EMPTY_NIL_STR(numberStr))
    //        return nil;
    NSMutableString *result = [NSMutableString stringWithCapacity:0];
    NSString *year = nil;
    NSString *month = nil;
    
    BOOL isAllNumber = YES;
    NSString *day = nil;
    if([numberStr length]<14)
        return result;
    if (numberStr.length == 18) {
        //**截取前14位
        NSString *fontNumer = [numberStr substringWithRange:NSMakeRange(0, 13)];
        
        //**检测前14位否全都是数字;
        const char *str = [fontNumer UTF8String];
        const char *p = str;
        while (*p!='\0') {
            if(!(*p>='0'&&*p<='9'))
                isAllNumber = NO;
            p++;
        }
        
        if(!isAllNumber)
            return result;
        
        year = [numberStr substringWithRange:NSMakeRange(6, 4)];
        month = [numberStr substringWithRange:NSMakeRange(10, 2)];
        day = [numberStr substringWithRange:NSMakeRange(12,2)];
        
        [result appendString:year];
        [result appendString:@"-"];
        [result appendString:month];
        [result appendString:@"-"];
        [result appendString:day];
        return result;
        
    }else{
        NSString *fontNumer = [numberStr substringWithRange:NSMakeRange(0, 11)];
        
        //**检测前14位否全都是数字;
        const char *str = [fontNumer UTF8String];
        const char *p = str;
        while (*p!='\0') {
            if(!(*p>='0'&&*p<='9'))
                isAllNumber = NO;
            p++;
        }
        
        if(!isAllNumber)
            return result;
        
        year = [numberStr substringWithRange:NSMakeRange(6, 2)];
        month = [numberStr substringWithRange:NSMakeRange(8, 2)];
        day = [numberStr substringWithRange:NSMakeRange(10,2)];
        
        //        [result appendString:year];
        //        [result appendString:@"-"];
        //        [result appendString:month];
        //        [result appendString:@"-"];
        //        [result appendString:day];
        NSString* resultAll = [NSString stringWithFormat:@"19%@-%@-%@",year,month,day];
        return resultAll;
        
    }
    
}

+ (BOOL)compareIdCardSex:(NSString*)idCard andSex:(NSNumber*)sex
{
    if (idCard.length == 15) {//15位身份证
        NSString *lastStr = [idCard substringWithRange:NSMakeRange(14, 1)];
        int lastNum = [lastStr intValue];
        if ((lastNum % 2 == 0 && [sex intValue] == 1) || (lastNum % 2 == 1 && [sex intValue] == 0)) {
            return NO;
        }else{
            return YES;
        }
    }else if (idCard.length == 18){//18位身份证
        NSString *lastStr = [idCard substringWithRange:NSMakeRange(16, 1)];
        int lastNum = [lastStr intValue];
        if ((lastNum % 2 == 0 && [sex intValue] == 1) || (lastNum % 2 == 1 && [sex intValue] == 0)) {
            return NO;
        }else{
            return YES;
        }
        
    }else{
        [[[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"身份证号码格式错误" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil] show];
        return YES;
    }
}


@end

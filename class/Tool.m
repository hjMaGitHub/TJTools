//
//  Tool.m
//  AreaApplication
//
//  Created by 吕强 on 15/10/28.
//  Copyright © 2015年 涂婉丽. All rights reserved.
//

#import "Tool.h"

@implementation Tool

+(UIImage *)imagepathForImagename:(NSString *)name type:(NSString *)type
{
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:type];
    UIImage *image = [UIImage imageWithContentsOfFile:path];

    return image;
}
+(UIColor *)colorWithRedcount:(CGFloat)redcount greencount:(CGFloat)greencount bluecount:(CGFloat)bluecount alpha:(CGFloat)alphacount
{
    UIColor *color = [UIColor colorWithRed:redcount/255.0 green:greencount/255.0 blue:bluecount/255.0 alpha:alphacount];
    return color;
}
+ (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}
#pragma mark  旧方法

+(void)showMBProgressHUDText:(MBProgressHUD *)hud Message:(NSString *)text Time:(NSInteger)time addView:(UIView *)addView FrameY:(CGFloat)y
{
    [MBProgressHUD hideHUDForView:addView animated:NO];
    [hud removeFromSuperview];
    hud = [MBProgressHUD showHUDAddedTo:addView animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.text = text;
    hud.offset = CGPointMake(0, y);
    hud.userInteractionEnabled = NO;
    hud.margin = 9.f;
    hud.detailsLabel.font = [UIFont systemFontOfSize:14];
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:time];
}
+(void)showMBProgressHUDLabel:(MBProgressHUD *)hud Message:(NSString *)text addView:(UIView *)addView
{
    [MBProgressHUD hideHUDForView:addView animated:NO];
    [hud removeFromSuperview];
    hud = [MBProgressHUD showHUDAddedTo:addView animated:YES];
    hud.detailsLabel.text = text;
    hud.detailsLabel.font = [UIFont systemFontOfSize:14];
    hud.removeFromSuperViewOnHide = YES;
}
+(void)hiddenHUD:(MBProgressHUD *)hud fromView:(UIView *)addView
{
    [MBProgressHUD hideHUDForView:addView animated:YES];
    [MBProgressHUD hideHUDForView:addView animated:YES];
    [hud removeFromSuperview];
}

+(void)showNetWorkMBProgressHUD:(MBProgressHUD *)hud Message:(NSString *)text Time:(NSInteger)time addView:(UIView *)addView yOffset:(CGFloat)y
{
    [MBProgressHUD hideHUDForView:addView animated:NO];
    [hud removeFromSuperview];
    hud = [MBProgressHUD showHUDAddedTo:addView animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.text = text;
    hud.detailsLabel.font = [UIFont systemFontOfSize:14];
    hud.offset = CGPointMake(0, y);
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:2];
}
#pragma mark  新方法
+(void)showMBProgressHUDText:(MBProgressHUD *)hud Message:(NSString *)text Time:(NSInteger)time DimBackground:(BOOL)dimBackground addViewController:(RootViewController *)viewVC FrameY:(CGFloat)y
{
    [MBProgressHUD hideHUDForView:viewVC.view animated:NO];
    [hud removeFromSuperview];
    hud = [MBProgressHUD showHUDAddedTo:viewVC.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.detailsLabel.text = text;
    hud.margin = 9.f;
    hud.detailsLabel.font = [UIFont systemFontOfSize:14];
    hud.offset = CGPointMake(0, y);
    hud.userInteractionEnabled = NO;
    if (dimBackground) {
        hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    }
    hud.delegate = viewVC;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:time];
}
+(void)showMBProgressHUDLabel:(MBProgressHUD *)hud Message:(NSString *)text DimBackground:(BOOL)dimBackground addViewController:(RootViewController *)viewVC
{
    [MBProgressHUD hideHUDForView:viewVC.view animated:NO];
    [hud removeFromSuperview];
    hud = [MBProgressHUD showHUDAddedTo:viewVC.view animated:YES];
    hud.detailsLabel.text = text;
    hud.detailsLabel.font = [UIFont systemFontOfSize:14];
    hud.delegate = viewVC;
    if (dimBackground) {
        hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    }
    hud.removeFromSuperViewOnHide = YES;
}
+(void)showMBProgressHUDLabelAndGif:(MBProgressHUD *)hud Message:(NSString *)text DimBackground:(BOOL)dimBackground addViewController:(RootViewController *)viewVC
{
    [MBProgressHUD hideHUDForView:viewVC.view animated:NO];
    [hud removeFromSuperview];
    hud = [MBProgressHUD showHUDAddedTo:viewVC.view animated:YES];
    hud.detailsLabel.text = text;
    hud.detailsLabel.font = [UIFont systemFontOfSize:14];
    hud.delegate = viewVC;
    if (dimBackground) {
        hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    }
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeCustomView;
    UIImageView *gifImageView = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, 100, 100)];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"gif01" ofType:@"gif"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    UIImage *image = [UIImage sd_imageWithGIFData:data];
    gifImageView.image = image;
    hud.customView = gifImageView;
    
}
+(void)showMBProgressHUDWithCustomView:(MBProgressHUD *)HUD Message:(NSString *)text Time:(NSInteger)time DimBackground:(BOOL)dimBackground CustomCount:(NSInteger)CustomCount addViewController:(RootViewController *)viewVC
{
    
    [MBProgressHUD hideHUDForView:viewVC.view animated:NO];
    [HUD removeFromSuperview];
    HUD = [MBProgressHUD showHUDAddedTo:viewVC.view animated:YES];
    NSString *imageName;
    //    1、警告，2、错误，3、正确
    switch (CustomCount) {
        case 1:
            imageName = @"37x-Warning";
            break;
        case 2:
            imageName = @"37x-Cancel";
            break;
        case 3:
            imageName = @"37x-Checkmark";
            break;
            
        default:
            imageName = @"37x-Checkmark";
            break;
    }
    
    HUD.mode = MBProgressHUDModeCustomView;
    UIImage *image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    HUD.customView = [[UIImageView alloc] initWithImage:image];
    HUD.square = YES;
    if (dimBackground) {
        HUD.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    }
    HUD.label.text = text;
    [HUD showAnimated:YES];
    [HUD hideAnimated:YES afterDelay:time];
}
+(void)hiddenHUD:(MBProgressHUD *)hud fromViewController:(UIViewController *)viewVC
{
    [MBProgressHUD hideHUDForView:viewVC.view animated:YES];
    [hud removeFromSuperview];
}

+(void)showMBProgressHUDWithCustomView:(MBProgressHUD *)HUD Message:(NSString *)text Time:(NSInteger)time DimBackground:(BOOL)dimBackground CustomCount:(NSInteger)CustomCount addView:(UIView *)view
{
    
    [MBProgressHUD hideHUDForView:view animated:NO];
    [HUD removeFromSuperview];
    HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    NSString *imageName;
    //    1、警告，2、错误，3、正确
    switch (CustomCount) {
        case 1:
            imageName = @"37x-Warning";
            break;
        case 2:
            imageName = @"37x-Cancel";
            break;
        case 3:
            imageName = @"37x-Checkmark";
            break;
        case 4:
            imageName = @"HealthKnowedge_collect";
            break;
        default:
            imageName = @"37x-Checkmark";
            break;
    }
    
    HUD.mode = MBProgressHUDModeCustomView;
    UIImage *image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    HUD.customView = [[UIImageView alloc] initWithImage:image];
    HUD.square = YES;
    HUD.label.text = text;
    if (dimBackground) {
        HUD.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    }
    [HUD showAnimated:YES];
    [HUD hideAnimated:YES afterDelay:time];
}
+ (UIImage *) createImageWithColor: (UIColor *) color
{
    CGRect rect = CGRectMake(0.0f,0.0f,1.0f,1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *myImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return myImage;
}
+(void)showAlertViewMessge:(NSString *)message delegate:(id)viewVC
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:message delegate:viewVC cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    [alert show];
}


+(UILabel *)setX:(float)x setY:(float)y setW:(float)width setText:(NSString *)string setFont:(UIFont *)font setColor:(UIColor *)color Alignment:(VerticalAlignment)Alignment
{
    
    MyLabel *label = [[MyLabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    [label setNumberOfLines:0];
    label.lineBreakMode=NSLineBreakByWordWrapping;
    CGSize size=CGSizeMake(width, MAXFLOAT);
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:6];
//    paragraphStyle.firstLineHeadIndent = 20.f;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attributedString.length)];
    [attributedString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, attributedString.length)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, attributedString.length)];
    label.attributedText = attributedString;

    CGRect rect  = [attributedString boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];

    [label setFrame:CGRectMake(x, y, rect.size.width, rect.size.height)];
    [label setVerticalAlignment:Alignment];
    return label;
}
+(YYLabel *)setX:(float)x setY:(float)y setW:(float)width setText:(NSString *)string setFont:(UIFont *)font setColor:(UIColor *)color Type:(NSString *)type
{
    
    YYLabel *label = [[YYLabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    [label setNumberOfLines:0];
    label.lineBreakMode=NSLineBreakByWordWrapping;
    CGSize size=CGSizeMake(width, MAXFLOAT);
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:6];
    paragraphStyle.firstLineHeadIndent = 20.f;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attributedString.length)];
    [attributedString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, attributedString.length)];
    
    
    if ([type isEqualToString:@"A1"]) {
        NSRange range = [string rangeOfString:@"，"];
        if (range.location != NSNotFound) {
            
            [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0/255.0f green:168/255.0f blue:255/255.0f alpha:1] range:NSMakeRange(0, range.location+1)];
            [attributedString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(range.location+1, attributedString.length-range.location-1)];
            
        }else{
            [attributedString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, attributedString.length)];
        }
    }else{
        [attributedString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, attributedString.length)];
    }
    label.attributedText = attributedString;
    
    CGRect rect  = [attributedString boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    
    [label setFrame:CGRectMake(x, y, width, rect.size.height+20)];
    label.textVerticalAlignment = YYTextVerticalAlignmentTop;
    return label;
}

#pragma mark - 精确判断身份证号码
+(BOOL)checkIdentityCardNo:(NSString*)value
{
//    BOOL flag = NO;
//    if (value.length <= 0) {
//        return flag;
//    }
//    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
//    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
//    flag = [identityCardPredicate evaluateWithObject:value];
//    return flag;
    
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    NSInteger length =0;
    if (!value) {
        return NO;
    }else {
        length = value.length;
        
        if (length !=15 && length !=18) {
            return NO;
        }
    }
    // 省份代码
    NSArray *areasArray = @[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41", @"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
    
    NSString *valueStart2 = [value substringToIndex:2];
    BOOL areaFlag =NO;
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag =YES;
            break;
        }
    }
    
    if (!areaFlag) {
        return NO;
    }
    
    
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    
    int year =0;
    switch (length) {
        case 15:
            year = [value substringWithRange:NSMakeRange(6,2)].intValue +1900;
            
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            
            
            if(numberofMatch >0) {
                return YES;
            }else {
                return NO;
            }
        case 18:
            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}(19|20)[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$" options:NSRegularExpressionCaseInsensitive error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}(19|20)[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$" options:NSRegularExpressionCaseInsensitive error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            
            if(numberofMatch >0) {
                int S = [value substringWithRange:NSMakeRange(0,1)].intValue*7 + [value substringWithRange:NSMakeRange(10,1)].intValue *7 + [value substringWithRange:NSMakeRange(1,1)].intValue*9 + [value substringWithRange:NSMakeRange(11,1)].intValue *9 + [value substringWithRange:NSMakeRange(2,1)].intValue*10 + [value substringWithRange:NSMakeRange(12,1)].intValue *10 + [value substringWithRange:NSMakeRange(3,1)].intValue*5 + [value substringWithRange:NSMakeRange(13,1)].intValue *5 + [value substringWithRange:NSMakeRange(4,1)].intValue*8 + [value substringWithRange:NSMakeRange(14,1)].intValue *8 + [value substringWithRange:NSMakeRange(5,1)].intValue*4 + [value substringWithRange:NSMakeRange(15,1)].intValue *4 + [value substringWithRange:NSMakeRange(6,1)].intValue*2 + [value substringWithRange:NSMakeRange(16,1)].intValue *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
                
                int Y = S %11;
                NSString *M =@"F";
                NSString *JYM =@"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y,1)];// 判断校验位
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
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
//返回字符串所占用的尺寸.
+(CGSize)sizeWithFont:(UIFont *)font textString:(NSString *)string
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [string boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}
+(NSMutableAttributedString *)attributedStringColor:(UIColor *)color
                                               text:(NSString *)text
                                               font:(UIFont *)font
                                       anOtherColor:(UIColor *)anOtherColor
                                        anOtherText:(NSString *)anOtherText
                                        anOtherFont:(UIFont *)anOtherFont
{
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:text];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:color,NSForegroundColorAttributeName,font,NSFontAttributeName, nil];
    [attributeString setAttributes:dic range:NSMakeRange(0, attributeString.length)];
    NSDictionary *dics = [NSDictionary dictionaryWithObjectsAndKeys:anOtherColor,NSForegroundColorAttributeName,anOtherFont,NSFontAttributeName, nil];
    NSAttributedString *string = [[NSAttributedString alloc]initWithString:anOtherText attributes:dics];
    [attributeString appendAttributedString:string];
    return attributeString;
}
+(bool)checkDevice:(NSString*)name
{
    NSString* deviceType = [UIDevice currentDevice].model;
    NSRange range = [deviceType rangeOfString:name];
    return range.location != NSNotFound;
}
+ (BOOL)isHttpPre:(NSString *)path
{
    if (path && ([[ [path stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] lowercaseString] hasPrefix:@"http://"] || [[[path stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] lowercaseString] hasPrefix:@"https://"])) {
        return YES;
    }
    else return NO;
}
+(NSString*)toCompactString:(NSDictionary *)dic
{
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:0 error:nil];
    NSString* jsonString = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding];
    return jsonString;
}
//手机号码是否正确
+ (NSString *)valiMobile:(NSString *)mobile {
    
    if (mobile.length != 11) {
        return @"手机号长度只能是11位";
    } else {
        
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
            return nil;
        }
        else
        {
            return @"请输入正确的电话号码";
        }
    }
    
    return nil;
}

//邮箱验证
+ (BOOL)validateEmail:(NSString*)email {
    
    NSString*emailRegex =@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate*emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return[emailTest evaluateWithObject:email];
    
}

#pragma 正则匹配用户密码6-20位数字或字母组合
+ (BOOL)checkPassword:(NSString *) password
{
    NSString *pattern = @"^[a-zA-Z0-9]{6,20}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
}

+(NSString *)notRounding:(float)price afterPoint:(int)position{
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:price];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return [NSString stringWithFormat:@"%@",roundedOunces];
}

+ (NSString *)stringFromeNumber:(NSNumber *)number {
//    NSNumberFormatterNoStyle = kCFNumberFormatterNoStyle, ///无格式 小数点后不保留    NSNumberFormatterDecimalStyle = kCFNumberFormatterDecimalStyle,///千分数，即千位以后加标点 188，880.02    NSNumberFormatterCurrencyStyle = kCFNumberFormatterCurrencyStyle,///千分数，加金钱符号 $188.880.02    NSNumberFormatterPercentStyle = kCFNumberFormatterPercentStyle,///百分号 0.35 -> 35%    NSNumberFormatterScientificStyle = kCFNumberFormatterScientificStyle,///科学计数法 1.888882E5    NSNumberFormatterSpellOutStyle = kCFNumberFormatterSpellOutStyle,///字母表示.. one hundred eighty-eight thousand eight hundred eighty-eight point two    NSNumberFormatterOrdinalStyle NS_ENUM_AVAILABLE(10_11, 9_0) = kCFNumberFormatterOrdinalStyle,    NSNumberFormatterCurrencyISOCodeStyle NS_ENUM_AVAILABLE(10_11, 9_0) = kCFNumberFormatterCurrencyISOCodeStyle,    NSNumberFormatterCurrencyPluralStyle NS_ENUM_AVAILABLE(10_11, 9_0) = kCFNumberFormatterCurrencyPluralStyle,    NSNumberFormatterCurrencyAccountingStyle NS_ENUM_AVAILABLE(10_11, 9_0) = kCFNumberFormatterCurrencyAccountingStyle,
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    [formatter setGroupingSeparator:@""];///使用空去分割group
    return [formatter stringFromNumber:number];
}

+(BOOL)isBlank:(NSString *)str{
    NSRange _range = [str rangeOfString:@" "];
    if (_range.location != NSNotFound) {
        //有空格
        DLog(@"空格");
        return YES;
    }else {
        DLog(@"无空格");
        return NO;
    }
}

//由身份证号返回为性别
+ (NSInteger)getSexFromIdCardSex:(NSString*)idCard
{
    if (idCard.length == 15) {//15位身份证
        NSString *lastStr = [idCard substringWithRange:NSMakeRange(14, 1)];
        int lastNum = [lastStr intValue];
        if (lastNum % 2 == 0) {
            return 3;
        }else{
            return 2;
        }
    }else{//18位身份证
        if (idCard.length != 18) {
            return 0;
        }
        NSString *lastStr = [idCard substringWithRange:NSMakeRange(16, 1)];
        int lastNum = [lastStr intValue];
        if (lastNum % 2 == 0) {
            return 3;
        }else{
            return 2;
        }
    }
}
+ (UIView *)createLineViewWithFrame:(CGRect)frame {
    UIView *lineView = [[UIView alloc]initWithFrame:frame];
//    lineView.backgroundColor = [UIColor colorWithRed:193/255.0f green:193/255.0f blue:193/255.0f alpha:1];
    lineView.backgroundColor =  LinTableViewCellSeparatorColor;
    return lineView;
}
+ (NSString *)fileSizeWithByte:(int64_t)count {
    return [NSString stringWithFormat:@"%.2fM",(float)count/(1024*1024)];
}
+ (NSString *)idNumberReplaceSecret:(NSString *)idNumber {
    if (!idNumber || idNumber.length == 0 || idNumber.length < 15) {
        return @"";
    }
    NSMutableAttributedString *secret = [[NSMutableAttributedString alloc]init];
    
    for (int i = 0; i < 4; i++) {
        [secret appendString:@"*"];
    }
    
    NSMutableString *string = [[NSMutableString alloc]initWithString:[idNumber stringByReplacingCharactersInRange:NSMakeRange(10, idNumber.length-14) withString:secret.string]];
    return string;
}

+(BOOL)is5Sdown
{
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    if ([platform isEqualToString:@"iPhone3,1"] && [platform isEqualToString:@"iPhone3,2"] && [platform isEqualToString:@"iPhone3,3"] &&[platform isEqualToString:@"iPhone4,1"] &&[platform isEqualToString:@"iPhone5,1"] &&[platform isEqualToString:@"iPhone5,2"] &&[platform isEqualToString:@"iPhone5,3"] && [platform isEqualToString:@"iPhone5,4"] &&[platform isEqualToString:@"iPhone6,1"] &&[platform isEqualToString:@"iPhone6,2"]){//5S版本以下3竖列
        return YES;
    }else{
        return NO;
    }
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

+ (BOOL)isChinese:(NSString *)name
{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:name];
}



+(NSString *)birthdayStrFromIdentityCard:(NSString *)numberStr
{
    NSMutableString *result = [NSMutableString stringWithCapacity:0];
    NSString *year = nil;
    NSString *month = nil;
    
    BOOL isAllNumber = YES;
    NSString *day = nil;
    if([numberStr length]<14)
        return result;
    
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
}
+ (BOOL)justifyTheUserInfo
{
    NSString *nameStr = [UserConfig sharedInstance].name;
    NSString *idnoStr = [UserConfig sharedInstance].idNo;
    NSString *mobileStr = [UserConfig sharedInstance].mobileTel;
    if ([UserConfig sharedInstance].logined&&(nameStr.length == 0||idnoStr.length == 0||mobileStr.length == 0)) {//用户完善信息
        //        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        UIViewController *curVC = [IDTool getCurVC];
        PersonalDetailsVC *detailVC = [[PersonalDetailsVC alloc]init];
        ILNavigationController *nav = [[ILNavigationController alloc]initWithRootViewController:detailVC];
        [curVC presentViewController:nav animated:YES completion:nil];
    }else{
        if (![UserConfig sharedInstance].logined) {
            UIViewController *curVC = [IDTool getCurVC];
            LoginVC *loginvc = [[LoginVC alloc]init];
            ILNavigationController *nav = [[ILNavigationController alloc]initWithRootViewController:loginvc];
            [curVC presentViewController:nav animated:YES completion:nil];
        }else{
            return NO;
        }
        
    }
    return YES;
    
}


/**
 判断是不是字符有没有值，没有的话返回自定义字符
 */
+ (NSString *)isNSStringClass:(NSString *)str placeNSString:(NSString *)placeStr{
    
    NSString *temStr;
    if (str.length > 0 && str != nil) {
        temStr = str;
    }else{
        temStr = placeStr;
    }
    return  temStr;
}

@end

//
//  Tool.h
//  AreaApplication
//
//  Created by 吕强 on 15/10/28.
//  Copyright © 2015年 涂婉丽. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "MyLabel.h"
@interface Tool : NSObject
+(UIImage *)imagepathForImagename:(NSString *)name type:(NSString *)type;
+(UIColor *)colorWithRedcount:(CGFloat)redcount greencount:(CGFloat)greencount bluecount:(CGFloat)bluecount alpha:(CGFloat)alphacount;
/**
 *  字典转json
 *
 *  @param dic 字典
 *
 *  @return json
 */
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;


#pragma mark  旧方法
/**
 * 旧方法 Label
 *
 *  @param hud     <#hud description#>
 *  @param text    <#text description#>
 *  @param addView <#addView description#>
 */
+(void)showMBProgressHUDLabel:(MBProgressHUD *)hud Message:(NSString *)text addView:(UIView *)addView;
/**
 *  旧方法 text
 *
 *  @param hud                             <#hud description#>
 *  @param text                            <#text description#>
 *  @param time                            <#time description#>
 *  @param addView                         <#addView description#>
 *  @param showMBProgressHUDWithCustomView <#showMBProgressHUDWithCustomView description#>
 *  @param HUD                             <#HUD description#>
 *  @param text                            <#text description#>
 *  @param time                            <#time description#>
 *  @param dimBackground                   <#dimBackground description#>
 *  @param CustomCount                     <#CustomCount description#>
 *  @param viewVC                          <#viewVC description#>
 */
+(void)showMBProgressHUDText:(MBProgressHUD *)hud Message:(NSString *)text Time:(NSInteger)time addView:(UIView *)addView FrameY:(CGFloat)y;
/**
 *  旧方法 隐藏
 *
 *  @param hud     HUD
 *  @param addView HUD加载的view
 */
+(void)hiddenHUD:(MBProgressHUD *)hud fromView:(UIView *)addView;
/**
 *  网络提醒
 *
 *  @param hud                    <#hud description#>
 *  @param text                   <#text description#>
 *  @param time                   <#time description#>
 *  @param addView                <#addView description#>
 *  @param showMBProgressHUDLabel <#showMBProgressHUDLabel description#>
 *  @param hud                    <#hud description#>
 *  @param text                   <#text description#>
 *  @param dimBackground          <#dimBackground description#>
 *  @param viewVC                 <#viewVC description#>
 */
+(void)showNetWorkMBProgressHUD:(MBProgressHUD *)hud Message:(NSString *)text Time:(NSInteger)time addView:(UIView *)addView yOffset:(CGFloat)y;
#pragma mark  新方法

/**
 *  新方法 Label 隐藏配套新方法使用
 *
 *  @param hud           HUD
 *  @param text          提醒消息
 *  @param dimBackground 是否显示蒙板
 *  @param viewVC        控制器
 */
+(void)showMBProgressHUDLabel:(MBProgressHUD *)hud Message:(NSString *)text DimBackground:(BOOL)dimBackground addViewController:(UIViewController *)viewVC;

/**
 *  新方法 LabelGIF图片 隐藏配套新方法使用
 *
 *  @param hud           HUD
 *  @param showGif       是否显示gif图片
 *  @param text          提醒消息
 *  @param dimBackground 是否显示蒙板
 *  @param viewVC        控制器
 */
+(void)showMBProgressHUDLabelAndGif:(MBProgressHUD *)hud Message:(NSString *)text DimBackground:(BOOL)dimBackground addViewController:(UIViewController *)viewVC;

/**
 *  新方法 text
 *
 *  @param hud           HUD
 *  @param text          提醒消息
 *  @param time          显示时间
 *  @param dimBackground 是否显示蒙板
 *  @param viewVC        控制器
 *  @param y             Y坐标偏移量
 */
+(void)showMBProgressHUDText:(MBProgressHUD *)hud Message:(NSString *)text Time:(NSInteger)time DimBackground:(BOOL)dimBackground addViewController:(UIViewController *)viewVC FrameY:(CGFloat)y;

/**
 *  HUD CustomView（加载在导航栏View 可以全屏幕蒙板）
 *
 *  @param HUD           HUD
 *  @param text          提醒消息
 *  @param time          显示时间
 *  @param dimBackground 是否显示蒙板
 *  @param CustomCount   1、警告，2、错误，3、正确
 *  @param viewVC        控制器
 */
+(void)showMBProgressHUDWithCustomView:(MBProgressHUD *)HUD Message:(NSString *)text Time:(NSInteger)time DimBackground:(BOOL)dimBackground CustomCount:(NSInteger)CustomCount addViewController:(UIViewController *)viewVC;


/**
 *  隐藏HUD 新方法  注意新方法不能和旧方法交替使用
 *
 *  @param hud    <#hud description#>
 *  @param viewVC 控制器
 */
+(void)hiddenHUD:(MBProgressHUD *)hud fromViewController:(UIViewController *)viewVC;
/**
 *  View提醒HUD（加载在View 局部蒙板）
 *
 *  @param HUD                 <#HUD description#>
 *  @param text                <#text description#>
 *  @param time                <#time description#>
 *  @param dimBackground       <#dimBackground description#>
 *  @param CustomCount         <#CustomCount description#>
 *  @param showAlertViewMessge <#showAlertViewMessge description#>
 *  @param message             <#message description#>
 *  @param viewVC              <#viewVC description#>
 */
+(void)showMBProgressHUDWithCustomView:(MBProgressHUD *)HUD Message:(NSString *)text Time:(NSInteger)time DimBackground:(BOOL)dimBackground CustomCount:(NSInteger)CustomCount addView:(UIView *)view;

+ (void)showAlertViewMessge:(NSString *)message delegate:(id)viewVC;


+ (UIImage *) createImageWithColor: (UIColor *) color;
+ (UILabel *)setX:(float)x setY:(float)y setW:(float)width setText:(NSString *)string setFont:(UIFont *)font setColor:(UIColor *)color Alignment:(VerticalAlignment)Alignment;
//消息详情专用
+ (UILabel *)setX:(float)x setY:(float)y setW:(float)width setText:(NSString *)string setFont:(UIFont *)font setColor:(UIColor *)color Type:(NSString *)type;

/**
 *  精确判断身份证号码
 *
 *  @param cardNo <#cardNo description#>
 *
 *  @return <#return value description#>
 */
+(BOOL)checkIdentityCardNo:(NSString*)value;
/**
 *  颜色转图片
 *
 *  @param color 颜色
 *  @param size  大小
 *
 *  @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
/**
 *  获取字符串所占用的长度：计算一句话
 *
 *  @param font   字体
 *  @param string 字符串
 *
 *  @return CGSize
 */
+ (CGSize)sizeWithFont:(UIFont *)font textString:(NSString *)string;

/**
 *  创建富文本
 *
 *  @param color        颜色
 *  @param text         文本
 *  @param font         字体
 *  @param anOtherColor 颜色
 *  @param anOtherText  文本
 *  @param anOtherFont  字体
 *
 *  @return 富文本
 */
+ (NSMutableAttributedString *)attributedStringColor:(UIColor *)color
                                               text:(NSString *)text
                                               font:(UIFont *)font
                                       anOtherColor:(UIColor *)anOtherColor
                                        anOtherText:(NSString *)anOtherText
                                        anOtherFont:(UIFont *)anOtherFont;
/**
 *  判断设备类型
 *
 *  @param name 设备类型名称 iPhone iPod
 *
 *  @return BOOL
 */
+(bool)checkDevice:(NSString*)name;
/*
 **是否为网址
 */
+ (BOOL)isHttpPre:(NSString *)path;
/**
 *  字典转json
 *
 *  @param dic 字典
 *
 *  @return json
 */
+(NSString*)toCompactString:(NSDictionary *)dic;

/**
 *  验证手机号码
 *
 *  @param mobile 手机号码
 *
 *  @return
 */
+ (NSString *)valiMobile:(NSString *)mobile;

/**
 *  邮箱
 *
 *  @param email 邮箱账号
 *
 *  @return BOOL
 */
+ (BOOL)validateEmail:(NSString*)email;

/**
 *  正则匹配用户密码6-20位数字或字母组合
 *
 *  @param password 密码
 *
 *  @return BOOL
 */
+ (BOOL)checkPassword:(NSString *) password;
/**
 *  四舍五入
 *
 *  @param price    金额
 *  @param position 保留几位小数
 *
 *  @return nil
 */
+(NSString *)notRounding:(float)price afterPoint:(int)position;

/**
 *  Number 转String
 *
 *  @param number Number
 *
 *  @return String
 */
+ (NSString *)stringFromeNumber:(NSNumber *)number;
/**
 *  字符串中是否包含空格
 *
 *  @param str string
 *
 *  @return BOOL
 */
+(BOOL)isBlank:(NSString *)str;
/**
 *  获取性别
 *
 *  @param idCard 身份证号
 *
 *  @return 1 男 2 女  0 未知
 */
+ (NSInteger)getSexFromIdCardSex:(NSString*)idCard;
/**
 *  灰色的线
 *
 *  @param frame <#frame description#>
 *
 *  @return <#return value description#>
 */
+ (UIView *)createLineViewWithFrame:(CGRect)frame;

/**
 *  字节换算
 *
 *  @param count 字节
 *
 *  @return M／GB
 */
+ (NSString *)fileSizeWithByte:(int64_t)count;

//判断苹果手机型号
+(BOOL)is5Sdown;

+ (UIImage*)createImageWithColor:(UIColor*)color Size:(CGSize)size;

/**
 判断是否全中文
 
 @param name 中文
 @return Bool
 */
+ (BOOL)isChinese:(NSString *)name;

/**
 身份证号加密显示

 @param idNumber 身份证号
 @return
 */
+ (NSString *)idNumberReplaceSecret:(NSString *)idNumber;
//判断登录
+ (BOOL)justifyTheUserInfo;


/**
 判断是不是字符有没有值，没有的话返回自定义字符
 */
+ (NSString *)isNSStringClass:(NSString *)str placeNSString:(NSString *)placeStr;

@end

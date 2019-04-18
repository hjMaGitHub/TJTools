//
//  IDTool.h
//  我的工具
//
//  Created by 吕强 on 16/7/28.
//  Copyright © 2017年 Beijing Tianjian Yuan Da Tecnology Co.,Ltd. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface IDTool : NSObject

+(NSString*)plat;
+(NSString*)model;

+(NSString*)deviceInfo;

+(NSString*)encrypted:(NSString*)strBuf;
+(NSString*)decrypted:(NSString*)strBuf;

+(UIImage*)createImageWithColor:(UIColor*)color Size:(CGSize)size;

+(UIImage*)getImageSize:(NSString*)imgPath Ext:(NSString*)strExt Size:(CGSize)size;

+(NSString*)encodeURL:(NSString *)string;

//+(BOOL)connectedToNetwork;
//+(BOOL)isWIFIConnection;

//System Sound Services
+(void)playSoundWithName:(NSString *)soundName withType:(NSString *)type;
//震动
+(void)shakeMobiledevice;
// 正则判断手机号码地址格式
+ (BOOL)isMobileNumber:(NSString *)mobileNum;
+ (BOOL)isPhoneNumber:(NSString *)phoneNum;
+ (BOOL)isAccount:(NSString *)strAccount;

+ (BOOL)valiMobile:(NSString *)mobile;


// 判断是否是数字
+ (BOOL)isPureNumber:(NSString*)string;
//根据生日（单位秒）转换成一个年龄
+ (double)brithDayToAge:(long long)birthDay;
//根据身份证号码 转换成一个生日
+(NSString *)birthdayStrFromIdentityCard:(NSString *)numberStr;
//根据身份证号码 转换成年龄
+(NSNumber *)ageFromIdentityCard:(NSString *)numberStr;

+ (void)showAlertView:(NSError *)error;

+ (UIImage*)mergedImageOnMainImage:(CGFloat)nhW WithImageArray:(NSArray *)imgArray;

+ (BOOL)isHttpPre:(NSString *)path;

+ (UIViewController *)getCurVC;
//获取ale
+ (NSString *)getAlassetExt:(NSString *)strPath;

//判断身份证号码
+ (BOOL)validateIdentityCard: (NSString *)identityCard;
//精确判断身份证号码
+ (BOOL)validateIDCardNumber:(NSString *)identityCard;

//对中文输入和英文字符限制的问题
+ (void)judgeTheDigitalTypeJudgment:(UITextField *)textfield CN:(NSInteger)chinaT EN:(NSInteger)engT;

//判断身份证号码和性别是否一致
+ (BOOL)compareIdCardSex:(NSString*)idCard andSex:(NSNumber*)sex;


@end

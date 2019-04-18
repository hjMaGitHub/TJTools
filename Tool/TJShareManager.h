//
//  TJShareManager.h
//  AreaApplication
//
//  Created by Lv Qiang on 2016/12/16.
//  Copyright © 2016年 Beijing Tianjian Yuan Da Tecnology Co.,Ltd. All rights reserved.
//  分享工具类

#import <Foundation/Foundation.h>
#import <UMShare/UMShare.h>

@interface TJShareManager : NSObject



/**
 *  分享文本
 *
 *  @param platformType 类型
 *  @param text         分享文字
 */
+ (void)shareTextToPlatformType:(UMSocialPlatformType)platformType
                           text:(NSString *)text
          currentViewController:(id)currentViewController
                shareCompletion:(UMSocialRequestCompletionHandler)shareCompletion;;

/**
 *  分享图片/网络图片
 *
 *  @param platformType 类型
 *  @param thumbImage   缩略图（UIImage或者NSData类型，或者image_url（必须为HTTPS））
 *  @param shareImage   分享图片（UIImage或者NSData类型，或者image_url（必须为HTTPS））
 */
+ (void)shareImageToPlatformType:(UMSocialPlatformType)platformType
                      thumbImage:(id)thumbImage
                      shareImage:(id)shareImage
           currentViewController:(id)currentViewController
                 shareCompletion:(UMSocialRequestCompletionHandler)shareCompletion;;

/**
 *  分享图片和文字
 *
 *  @param platformType 类型
 *  @param text         文本
 *  @param thumbImage   缩略图（UIImage或者NSData类型，或者image_url（必须为HTTPS））
 *  @param shareImage   分享图片 （UIImage或者NSData类型，或者image_url（必须为HTTPS））
 */
+ (void)shareImageAndTextToPlatformType:(UMSocialPlatformType)platformType
                                   text:(NSString *)text
                             thumbImage:(id)thumbImage
                             shareImage:(id)shareImage
                  currentViewController:(id)currentViewController
                        shareCompletion:(UMSocialRequestCompletionHandler)shareCompletion;

/**
 *  网页分享
 *
 *  @param platformType 类型
 *  @param title        标题
 *  @param descr        内容
 *  @param thumImage    缩略图（UIImage或者NSData类型，或者image_url（必须为HTTPS））
 *  @param webLink      链接
 */
+ (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
                             title:(NSString *)title
                             descr:(NSString *)descr
                         thumImage:(id)thumImage
                           webLink:(NSString *)webLink
             currentViewController:(id)currentViewController
                   shareCompletion:(UMSocialRequestCompletionHandler)shareCompletion;

+ (void)checkThumImage:(id)thumbImage complete:(void (^)(id))downImage;

@end

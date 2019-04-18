//
//  TJShareManager.m
//  AreaApplication
//
//  Created by Lv Qiang on 2016/12/16.
//  Copyright © 2016年 Beijing Tianjian Yuan Da Tecnology Co.,Ltd. All rights reserved.
//

#import "TJShareManager.h"
#import "MBProgressHUD.h"

#define global_quque    dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@implementation TJShareManager

/**
 *  分享文本
 *
 *  @param platformType 类型
 *  @param text         分享文字
 */
+ (void)shareTextToPlatformType:(UMSocialPlatformType)platformType
                           text:(NSString *)text
          currentViewController:(id)currentViewController
                shareCompletion:(UMSocialRequestCompletionHandler)shareCompletion
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //设置文本
    messageObject.text = text;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:currentViewController completion:^(id data, NSError *error) {
        if (error) {
            [self showMessage:@"分享失败" Time:2 CustomCount:2];
        }else{
            [self showMessage:@"分享成功" Time:2 CustomCount:3];
        }
        shareCompletion(data,error);
    }];
}

/**
 *  分享图片/网络图片
 *
 *  @param platformType 类型
 *  @param thumbImage   缩略图（UIImage或者NSData类型，或者image_url）
 *  @param shareImage   分享图片（UIImage或者NSData类型，或者image_url）
 */
+ (void)shareImageToPlatformType:(UMSocialPlatformType)platformType
                      thumbImage:(id)thumbImage
                      shareImage:(id)shareImage
           currentViewController:(id)currentViewController
                 shareCompletion:(UMSocialRequestCompletionHandler)shareCompletion
{
    [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    [TJShareManager checkThumImage:thumbImage complete:^(id data) {
        [TJShareManager checkThumImage:shareImage complete:^(id shareData) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
            });
            //创建分享消息对象
            UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
            
            //创建图片内容对象
            UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
            //如果有缩略图，则设置缩略图本地
            shareObject.thumbImage = thumbImage;
            
            [shareObject setShareImage:shareImage];
            
            
            //分享消息对象设置分享内容对象
            messageObject.shareObject = shareObject;
            
            //调用分享接口
            [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:currentViewController completion:^(id data, NSError *error) {
                if (error) {
                    [self showMessage:@"分享失败" Time:2 CustomCount:2];
                }else{
                    [self showMessage:@"分享成功" Time:2 CustomCount:3];
                }
                shareCompletion(data,error);
            }];
        }];
    }];
    
}

/**
 *  分享图片和文字
 *
 *  @param platformType 类型
 *  @param text         文本
 *  @param thumbImage   缩略图（UIImage或者NSData类型，或者image_url）
 *  @param shareImage   分享图片 （UIImage或者NSData类型，或者image_url）
 */
+ (void)shareImageAndTextToPlatformType:(UMSocialPlatformType)platformType
                                   text:(NSString *)text
                             thumbImage:(id)thumbImage
                             shareImage:(id)shareImage
                  currentViewController:(id)currentViewController
                        shareCompletion:(UMSocialRequestCompletionHandler)shareCompletion
{
    [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    [TJShareManager checkThumImage:thumbImage complete:^(id data) {
        [TJShareManager checkThumImage:shareImage complete:^(id shareData) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
            });
            //创建分享消息对象
            UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
            
            //设置文本
            messageObject.text = text;
            
            //创建图片内容对象
            UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
            
            shareObject.thumbImage = data;//缩略图
            [shareObject setShareImage:shareData];//分享图片
            
            //分享消息对象设置分享内容对象
            messageObject.shareObject = shareObject;
            
            //调用分享接口
            [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:currentViewController completion:^(id data, NSError *error) {
                if (error) {
                    [self showMessage:@"分享失败" Time:2 CustomCount:2];
                }else{
                    [self showMessage:@"分享成功" Time:2 CustomCount:3];
                }
                shareCompletion(data,error);
            }];
        }];
    }];
    
    
    
    
}

/**
 *  网页分享
 *
 *  @param platformType 类型
 *  @param title        标题
 *  @param descr        内容
 *  @param thumImage    图片 缩略图（UIImage或者NSData类型，或者image_url）
 *  @param webLink      链接
 */
+ (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
                             title:(NSString *)title
                             descr:(NSString *)descr
                         thumImage:(id)thumImage
                           webLink:(NSString *)webLink
             currentViewController:(id)currentViewController
                   shareCompletion:(UMSocialRequestCompletionHandler)shareCompletion
{
    [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    [TJShareManager checkThumImage:thumImage complete:^(id data) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
        });
        //创建分享消息对象
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        
        UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:descr thumImage:data];
        //设置网页地址
        shareObject.webpageUrl = webLink;
        
        //分享消息对象设置分享内容对象
        messageObject.shareObject = shareObject;
        
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:currentViewController completion:^(id data, NSError *error) {
            if (error) {
                [self showMessage:@"分享失败" Time:2 CustomCount:2];
            }else{
                [self showMessage:@"分享成功" Time:2 CustomCount:3];
            }
            shareCompletion(data,error);
        }];
        
    }];
    
}
+(void)showMessage:(NSString *)text Time:(NSInteger)time CustomCount:(NSInteger)CustomCount
{
    
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
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
    HUD.label.text = text;
    [HUD showAnimated:YES];
    [HUD hideAnimated:YES afterDelay:time];
    
}

//检查http链接下载：http链接图片下载  progress:(nullable void (^)(id))downImage
+ (void)checkThumImage:(id)thumbImage complete:(nullable void (^)(id))downImage
{
    
    if (thumbImage && ![thumbImage isMemberOfClass:[UIImage class]] &&([thumbImage isMemberOfClass:[NSString class]]||[[NSString stringWithFormat:@"%@",[thumbImage class]] rangeOfString:@"String"].location !=NSNotFound) && ([[[thumbImage stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] lowercaseString] hasPrefix:@"http://"])) {
        [[SDWebImageManager sharedManager]loadImageWithURL:[NSURL URLWithString:thumbImage] options:SDWebImageProgressiveLoad progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
            if(image) {
                downImage(image);
            }else{
                downImage([UIImage imageNamed:[NSString stringWithFormat:@"App_icon_%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]]]);
            }
        }];
    }else{
        downImage(thumbImage);
    }
}

@end


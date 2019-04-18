//
//  TJUploaderManager.h
//  AreaApplication
//
//  Created by Lv Qiang on 2017/4/12.
//  Copyright © 2017年 Beijing Tianjian Yuan Da Tecnology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define CommunityConsult_Function               @"CommunityConsult"
#define CommunityNotify_Function                @"CommunityNotify"
#define FamilyMemberHeaderImage_Function        @"FamilyMemberHeaderImage"


NS_ASSUME_NONNULL_BEGIN
@interface TJUploaderManager : NSObject

+(TJUploaderManager *)sharedInstance;

/**
 图片上传 （UIImage）

 @param imageArr    UIImage 格式
 @param isThumbnail 是否生成缩略图
 @param isOverride  是否覆盖旧文件
 @param smallSize   缩略图size、不指定：输入CGSizeZero 缩略图默认为200*160
 @param module     功能模块
 @param progress    进度
 @param success     成功回掉
 @param failure     失败回掉
 */
- (void)uploadImageData:(NSArray <UIImage *>*)imageArr
              thumbnail:(BOOL)isThumbnail
               override:(BOOL)isOverride
          thumbnailSize:(CGSize)smallSize
         functionModule:(NSString *)module
               progress:(nullable void (^)(NSProgress *progress))progress
                success:(void (^)(id responseObject))success
                failure:(void (^)(NSError *error))failure;



/**
 图片上传 （NSURL）

 @param imageArr 图片 NSURL
 @param mimeType    The MIME type of the specified data. (For example, the MIME type for a JPEG image is image/jpeg.)
 @param isThumbnail 是否生成缩略图
 @param isOverride  是否覆盖旧文件
 @param smallSize   缩略图size  不指定：输入CGSizeZero 缩略图默认为200*160
 @param module     功能模块
 @param progress    进度
 @param success     成功回掉
 @param failure     失败回掉
 */
- (void)uploadImageUrl:(NSArray <NSURL *>*)imageArr
              mimeType:(NSString *)mimeType
             thumbnail:(BOOL)isThumbnail
              override:(BOOL)isOverride
         thumbnailSize:(CGSize)smallSize
        functionModule:(NSString *)module
              progress:(nullable void (^)(NSProgress *progress))progress
               success:(void (^)(id responseObject))success
               failure:(void (^)(NSError *error))failure;



/**
 *  文件上传（NSURL）
 *
 *  @param fileArr     NSURL 数组
 *  @param mimeType    The MIME type of the specified data. (For example, the MIME type for a JPEG image is image/jpeg.)
 *  @param extension   文件后缀
 *  @param isOverride  是否覆盖旧文件
 *  @param module      功能模块
 *  @param progress    进度
 *  @param success     成功回掉
 *  @param failure     失败回掉
 */
- (void)uploadFileUrl:(NSArray <NSURL *>*)fileArr
             mimeType:(NSString *)mimeType
        fileExtension:(NSString *)extension
             override:(BOOL)isOverride
       functionModule:(NSString *)module
             progress:(nullable void (^)(NSProgress *progress))progress
              success:(void (^)(id responseObject))success
              failure:(void (^)(NSError *error))failure;

/**
 *  文件上传（NSData）
 *
 *  @param fileArr     NSData 数组
 *  @param mimeType    The MIME type of the specified data. (For example, the MIME type for a JPEG image is image/jpeg.)
 *  @param extension   文件后缀
 *  @param isOverride  是否覆盖旧文件
 *  @param module      功能模块
 *  @param progress    进度
 *  @param success     成功回掉
 *  @param failure     失败回掉
 */
- (void)uploadFileData:(NSArray <NSData *>*)fileArr
              mimeType:(NSString *)mimeType
         fileExtension:(NSString *)extension
              override:(BOOL)isOverride
        functionModule:(NSString *)module
              progress:(nullable void (^)(NSProgress *progress))progress
               success:(void (^)(id responseObject))success
               failure:(void (^)(NSError *error))failure;

- (void)cancelAllOperations;


@end
NS_ASSUME_NONNULL_END

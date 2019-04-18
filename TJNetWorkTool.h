//
//  TJNetWorkTool.h
//  LvCode
//
//  Created by 吕强 on 16/7/19.
//  Copyright © 2016年 吕强. All rights reserved.
//  网络请求

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface TJNetWorkTool : NSObject
/**
 *  POST 请求
 *
 *  @param URLString  请求头
 *  @param parameters 请求体
 *  @param progress   进度
 *  @param success    成功
 *  @param failure    失败
 */
+ (void)POST:(NSString *)URLString
  parameters:(nullable id)parameters
    progress:(nullable void (^)(NSProgress *progress))progress
     success:(void (^)(id responseObject))success
     failure:(void (^)(NSError *error))failure;



@end
NS_ASSUME_NONNULL_END

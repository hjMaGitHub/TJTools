//
//  TJNetWorkTool.m
//  LvCode
//
//  Created by 吕强 on 16/7/19.
//  Copyright © 2016年 Beijing Tianjian Yuan Da Tecnology Co.,Ltd. All rights reserved.
//

#import "TJNetWorkTool.h"
#import "TJNetManager.h"

@implementation TJNetWorkTool



+(void)POST:(NSString *)URLString
 parameters:(id)parameters
   progress:(void (^)(NSProgress *))progress
    success:(void (^)(id))success
    failure:(void (^)(NSError *))failure{
    
    AFHTTPSessionManager *manager = [TJNetManager shareInstance];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSLog(@"请求网址:%@ %@",URLString,parameters);
    [manager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (success) {
            NSDictionary *successDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            success(successDic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (failure) {
            failure(error);
        }
    }];
}
 

/*
+(void)POST:(NSString *)URLString
 parameters:(id)parameters
   progress:(void (^)(NSProgress *))progress
    success:(void (^)(id))success
    failure:(void (^)(NSError *))failure{
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            NSDictionary *successDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            success(successDic);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}
 */

@end

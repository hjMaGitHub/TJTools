//
//  ZHCommonRequsetTool.h
//  HealthApplicaton
//
//  Created by 涂欢 on 2018/9/21.
//  Copyright © 2018年 Beijing Tianjian Yuan Da Tecnology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonListModel.h"

@interface ZHCommonRequsetTool : NSObject
+ (ZHCommonRequsetTool *)commonRequestTool;

/**
 获取消息

 @param success 成功
 @param failure 失败
 */
+ (void)getMessageUnReadSuccess:(void (^)(id))success failure:(void (^)(NSError *))failure;

/**
 健康头条

 @param success 成功
 @param failure 失败
 */
+ (void)getHealthHeadlineSuccess:(void (^)(id))success failure:(void (^)(NSError *))failure;


/**
 输入账号密码登录
 @param success 成功
 @param failure 失败

*/
+ (void)loginIputAccount:(NSString *) account AndPassword:(NSString *) password AndUIViewController:(UIViewController *)controlller GetLoginSuccess:(void(^)(id))success  failure:(void (^)(NSError *))failure;



/**
获取默认就诊model并存到本地
 */
+ (void)returnDefaultVPatientModel:(void(^)(CommonListModel *model))success;

/**
 获取常用就诊人列表
 */
+ (void)returnOfenPatientPerson:(void (^)(id))success failure:(void (^)(NSError *))failure;

/**
 判断是否建档
 */
+ (void)jusityThePersonActive:(void (^)(id))success failure:(void (^)(NSError *))failure;

/**
 签约的团队
 */
+ (void)getMySignTeam:(void (^)(id))success failure:(void (^)(NSError *))failure;

@end

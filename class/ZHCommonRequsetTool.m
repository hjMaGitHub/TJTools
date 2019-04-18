//
//  ZHCommonRequsetTool.m
//  HealthApplicaton
//
//  Created by 涂欢 on 2018/9/21.
//  Copyright © 2018年 Beijing Tianjian Yuan Da Tecnology Co.,Ltd. All rights reserved.
//

#import "ZHCommonRequsetTool.h"
#import "HealthKnowledgeDB.h"
#import "NewsItemModel.h"
#import "PersonalDetailsVC.h"
#import "CommuSignPsnModel.h"
#import "IDTool.h"
#import "LoginVC.h"
@implementation ZHCommonRequsetTool
+ (ZHCommonRequsetTool *)commonRequestTool
{
    static ZHCommonRequsetTool *tool;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        tool = [[ZHCommonRequsetTool alloc]init];
    });
    return tool;
}
+ (void)getMessageUnReadSuccess:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSDictionary * dic = @{@"verbId":@"unReadMessageCount",@"userId":[UserConfig sharedInstance].userId,@"idNo":[UserConfig sharedInstance].idNo,@"deviceType":@"ios"};
    
    [TJNetWorkTool POST:[NSString stringWithFormat:@"%@%@",ZHReqAppBaseUrl,ZHmessageCenter] parameters:dic progress:nil success:^(id  _Nonnull responseObject) {
        
        if ([[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"flag"]]isEqualToString:@"0"]) {
            NSArray *dataArr = responseObject[@"data"];
            [[NSNotificationCenter defaultCenter]postNotificationName:NotificationRemindVCRefeshPage object:nil];
            NSInteger count = 0;
            for (NSDictionary *temp in dataArr) {
                NSNumber *number = [temp objectForKey:@"num"];
                count +=number.integerValue;
            }
            [UserConfig sharedInstance].unread = [[NSString stringWithFormat:@"%ld",count]integerValue];
        }
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
+ (void)getHealthHeadlineSuccess:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSDictionary *paramaDict = @{@"verbId":@"getNews",@"newTypeId":@"134338",@"pageNo":@"1",@"userId":[UserConfig sharedInstance].userId,@"pageSize":@"15"};
    NSMutableArray *_newsArr = [[NSMutableArray alloc]init];
   NSString *urlStr = [NSString stringWithFormat:@"%@%@",ZHReqAppBaseUrl,ZHhealthKnowledgeAction];
    [TJNetWorkTool POST:urlStr parameters:paramaDict progress:nil success:^(id  _Nonnull responseObject) {
        {
            //获取表上面的数据
            if ([responseObject[@"data"] isKindOfClass:[NSArray class]])
            {
                NSArray *newsListArray = responseObject[@"data"];
                for (NSInteger ii = 0; ii < [newsListArray count]; ii++) {
                    NewsItemModel *model = [[NewsItemModel alloc] init];
                    [model setValuesForKeysWithDictionary:newsListArray[ii]];
                    if (![Tool isHttpPre:model.picUrl]) {
                        
                        model.picUrl = [NSString stringWithFormat:@"%@%@",ZHReqAppFileUrl,model.picUrl];
                    }
                    [_newsArr addObject:model];
                }
                if (_newsArr.count>0) {
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                        [HealthKnowledgeDB deleteNewsDetailInfoItemData:@"134338"];
                        [HealthKnowledgeDB insertModeNewsInfo:_newsArr TypeID:@"134338"];
                    });
                }else{
                    [HealthKnowledgeDB deleteNewsDetailInfoItemData:@"134338"];
                }
                success(_newsArr);
                
            }else{
                NSString *err;
                err = [responseObject objectForKey:@"err"];
                if (err.length == 0) {
                    err = @"暂无头条呢~";
                }
                NSError *error = [NSError errorWithDomain:@"" code:01 userInfo:@{@"NSLocalizedDescription":err}];
                if (failure) {
                    failure(error);
                }dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                    [HealthKnowledgeDB deleteNewsDetailInfoItemData:@"134338"];
                });
            }
        }
        
    } failure:^(NSError * _Nonnull error) {
        NSString *err = @"网络正在开小差，请检查后重试";
        NSError *errorB = [NSError errorWithDomain:@"" code:01 userInfo:@{@"NSLocalizedDescription":err}];
        if (failure) {
            failure(errorB);
        }
    }];
}


+ (void)loginIputAccount:(NSString *) account AndPassword:(NSString *) password AndUIViewController:(UIViewController *)controlller GetLoginSuccess:(void(^)(id))success  failure:(void (^)(NSError *))failure
{
     MBProgressHUD *HUD;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    if ([account isEqualToString:@""]) {
        [Tool showMBProgressHUDText:HUD Message:@"请输入账号" Time:2 addView:window FrameY:HUD_Yoffset];
        return;
        
    }else if (!([Tool valiMobile:account] == nil || [Tool validateEmail:account] || [Tool checkIdentityCardNo:account])) {
        
        [Tool showMBProgressHUDText:HUD Message:@"请输入正确的手机号/邮箱号/身份证号" Time:2 addView:window FrameY:HUD_Yoffset];
        return;
    }else if ([password isEqualToString:@""]){
        [Tool showMBProgressHUDText:HUD Message:@"请输入密码" Time:2 addView:window FrameY:HUD_Yoffset];
        return;
    }
    else{
        [Tool showMBProgressHUDLabel:HUD Message:@"正在登录…" addView:window];
        NSString *urlStr = [NSString stringWithFormat:@"%@%@",ZHPTReqBaseUrl,ZHpatientUserAction];
        NSMutableDictionary *muDict = [[NSMutableDictionary alloc]init];
        [muDict setValue:@"login" forKey:@"verbId"];
        [muDict setValue:password forKey:@"password"];
        [muDict setValue:account forKey:@"userName"];
        [muDict setValue:[UserConfig sharedInstance].deviceId forKey:@"deviceId"];
        [muDict setValue:@"ios" forKey:@"deviceType"];
        
        [TJNetWorkTool POST:urlStr parameters:muDict progress:nil success:^(id  _Nonnull responseObject) {
             [Tool hiddenHUD:HUD  fromView:window];
            DLog(@"success---%@",responseObject);
            if ([[responseObject objectForKey:@"flag"] isEqualToString:@"0"]) {
                [Tool showMBProgressHUDText:HUD Message:@"登录成功" Time:2 addView:window FrameY:HUD_Yoffset];
                NSDictionary *dataDict = responseObject[@"data"];
                [UserConfig sharedInstance].account = account;
                [UserConfig sharedInstance].password = password;
                [[UserConfig sharedInstance] setValuesForKeysWithDictionary:dataDict];
                
                if ([UserConfig sharedInstance].sexName.length != 0) {
                    if ([[UserConfig sharedInstance].sexName isEqualToString:@"男"]) {
                        [UserConfig sharedInstance].sexId = @"2";
                    }else{
                        [UserConfig sharedInstance].sexId = @"3";
                    }
                }
                [MobClick profileSignInWithPUID:[UserConfig sharedInstance].userId];//友盟账号统计
                [UserConfig sharedInstance].isLoginAutomatic = @"1";
                [[DataBaseManager manager] insertUserInfo];
                [UserConfig sharedInstance].logined = YES;
                /*
                if ([[dataDict objectForKey:@"userId"]isEqualToString:@""] ||  [UserConfig sharedInstance].userId.length == 0) {
                    [Tool showMBProgressHUDText:HUD Message:@"服务器参数有误" Time:2.0 addView:window FrameY:0.0];
                    return ;
                }else{
//                    [self returnRoot];
                }*/
                if (success) {
                    success(responseObject);
                }
                
                [[NSNotificationCenter defaultCenter] postNotificationName:NotificationLogin object:nil];
                [ZHCommonRequsetTool returnDefaultVPatientModel:^(CommonListModel *model) {
                    //自动登录成功后并保存默认就诊人MOdel到本地
                }];
            }else{
                [Tool showMBProgressHUDText:HUD Message:[responseObject objectForKey:@"err"] Time:2 addView:window FrameY:HUD_Yoffset];
            }
        } failure:^(NSError * _Nonnull error) {
            [Tool hiddenHUD:HUD  fromView:window];
            NSString *description = [error.userInfo objectForKey:@"NSLocalizedDescription"];
            if (description.length == 0) {
                description = @"网络在开小差，检查后再试吧";
            }
            [Tool showMBProgressHUDText:HUD Message:description Time:2 addView:window FrameY:HUD_Yoffset];
            if (failure) {
                failure(error);
            }
        }];
        
    }
    
}


+ (void)returnDefaultVPatientModel:(void(^)(CommonListModel *model))success{
    
    CommonListModel *model = [[CommonListModel alloc]init];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",ZHPTReqBaseUrl,ZHPatientAction];
    NSDictionary *dic = @{@"verbId":@"getDefaultCommonPatient",@"userId":[UserConfig sharedInstance].userId,@"deviceType":@"IOS",@"securityUserId":[UserConfig sharedInstance].securityUserBaseinfoId};
    [TJNetWorkTool POST:urlStr parameters:dic progress:nil success:^(id  _Nonnull responseObject) {
        DLog(@"%@",responseObject);
        if ([[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"flag"]]isEqualToString:@"0"]) {
            if ([[responseObject objectForKey:@"data"] isKindOfClass:[NSDictionary class]]) {
                [model setValuesForKeysWithDictionary:[responseObject objectForKey:@"data"]];
                [UserConfig sharedInstance].patientModel = model;
            }else{
                model.name = [UserConfig sharedInstance].name;
                model.mobelPhone = [UserConfig sharedInstance].account;
                model.idNo = [UserConfig sharedInstance].idNo;
                model.age = [NSString stringWithFormat:@"%@",[IDTool ageFromIdentityCard:[UserConfig sharedInstance].idNo]];
                  [UserConfig sharedInstance].patientModel = model;
            }
            
        }else{
            model.name = [UserConfig sharedInstance].name;
            model.mobelPhone = [UserConfig sharedInstance].account;
            model.idNo = [UserConfig sharedInstance].idNo;
            model.age = [NSString stringWithFormat:@"%@",[IDTool ageFromIdentityCard:[UserConfig sharedInstance].idNo]];
              [UserConfig sharedInstance].patientModel = model;
            }

        if (success) {
            success(model);
        }
        
    } failure:^(NSError * _Nonnull error) {
    }];
    
    
}
+ (void)returnOfenPatientPerson:(void (^)(id))success failure:(void (^)(NSError *))failure{
    NSMutableArray *patientArr = [[NSMutableArray alloc]init];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",ZHPTReqBaseUrl,ZHPatientAction];
    NSDictionary *dic = @{@"verbId":@"getCommonPatient",@"userId":[UserConfig sharedInstance].userId,@"deviceType":@"IOS",@"self":@"1",@"securityUserId":[UserConfig sharedInstance].securityUserBaseinfoId};
    __block CommonListModel *tmpCommonModel;
    [TJNetWorkTool POST:urlStr parameters:dic progress:nil success:^(id  _Nonnull responseObject) {
        
        if ([[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"flag"]]isEqualToString:@"0"]) {
            [patientArr removeAllObjects];
            NSArray *listArr = [responseObject objectForKey:@"data"];
            for (NSDictionary *listDict in listArr) {
                CommonListModel *model = [[CommonListModel alloc]init];
                [model setValuesForKeysWithDictionary:listDict];
                if ([model.isDefault isEqualToString:@"1"]) {
                    tmpCommonModel = model;
                }else{
                    [patientArr addObject:model];
                }
            }
            if (tmpCommonModel) {
                [patientArr insertObject:tmpCommonModel atIndex:0];
            }
        }else{
            [patientArr removeAllObjects];
        }
        if (success) {
            success(patientArr);
        }
    } failure:^(NSError * _Nonnull error) {
        NSString *err = @"网络正在开小差，请检查后重试";
        NSError *errorB = [NSError errorWithDomain:@"" code:01 userInfo:@{@"NSLocalizedDescription":err}];
        if (failure) {
            failure(errorB);
        }
    }];
}
+ (void)jusityThePersonActive:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSDictionary *dic = @{@"verbId":@"isExistHealthCard",@"idNo":[UserConfig sharedInstance].idNo};
    [TJNetWorkTool POST:[NSString stringWithFormat:@"%@%@",ZHPTReqBaseUrl,ZHfamilyMember] parameters:dic progress:nil success:^(id  _Nonnull responseObject) {
        DLog(@"是否建档:%@",responseObject);
        if ([[NSString stringWithFormat:@"%@",[responseObject objectForKey:@"flag"]] isEqualToString:@"0"]) {
            NSDictionary* data = responseObject[@"data"];
            NSNumber* isExistHealthCard = data[@"isExistHealthCard"];
            if ([isExistHealthCard isEqualToNumber:@(1)]) {
                [UserConfig sharedInstance].comType = Communty_Procedure;
                [UserConfig sharedInstance].hspName = data[@"healthCard"][@"hspConfigName"];
                [UserConfig sharedInstance].hspCode = data[@"healthCard"][@"hspConfigCode"];
                [UserConfig sharedInstance].pid = data[@"healthCard"][@"pid"];
                [UserConfig sharedInstance].comType = Communty_Procedure;
                success(@"1");
                
            }else{
                [UserConfig sharedInstance].comType = Communty_UNProcedure;
                success(@"0");
                
            }
        }else{
            NSString *err;
            err = [responseObject objectForKey:@"err"];
            if (err.length == 0) {
                err = @"未查到是否建档~";
            }
            NSError *error = [NSError errorWithDomain:@"" code:01 userInfo:@{@"NSLocalizedDescription":err}];
            if (failure) {
                failure(error);
                
            }
            success(@"0");
        }
    } failure:^(NSError * _Nonnull error) {
        NSString *err = @"网络正在开小差，请检查后重试";
        NSError *errorB = [NSError errorWithDomain:@"" code:01 userInfo:@{@"NSLocalizedDescription":err}];
        if (failure) {
            failure(errorB);
        }
    }];
}
+ (void)getMySignTeam:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSMutableDictionary *paramDict = [[NSMutableDictionary alloc]init];
    [paramDict setValue:[UserConfig sharedInstance].userId forKey:@"userId"];
    [paramDict setValue:[UserConfig sharedInstance].pid forKey:@"pid"];
    NSMutableArray *myDocArr = [[NSMutableArray alloc]init];
    __block CommuSignTeamMenberFormListModel *leaderModel = [CommuSignTeamMenberFormListModel new];
    CommuSignTeamFormModel *teamModel = [CommuSignTeamFormModel new];
//    http://117.158.224.183:8090/SignDocServer/commuSignAction.do?verbId=getHomePage&userId=52f602135f4646e5a0a96a1b2ca238b9&pid=
    [TJNetWorkTool POST:[NSString stringWithFormat:@"%@%@verbId=getHomePage",ZHReqBaseUrl,ZHcommuSignAction] parameters:paramDict progress:nil success:^(id  _Nonnull responseObject) {
        DLog(@"requestObject = %@",responseObject);
        if (![[responseObject objectForKey:@"data"] isKindOfClass:[NSNull class]]) {
            //            [UserConfig sharedInstance].signPsnId
            //有签约医生团队
            NSDictionary* dic = responseObject[@"data"][@"commuSignTeamForm"];
            [teamModel setValuesForKeysWithDictionary:dic];
            for (NSDictionary* dict in teamModel.commuSignTeamMenberFormList) {
                CommuSignTeamMenberFormListModel* model = [CommuSignTeamMenberFormListModel new];
                [model setValuesForKeysWithDictionary:dict];
                if (![model.hspStaffBaseinfoId isEqualToString:teamModel.teamLeaderId]) {
                    [myDocArr addObject:model];
                }else{
                    leaderModel = model;
                }
            }
            //            NSDictionary* lastRecordDic = responseObject[@"data"][@"commuSignCompleteRecord"];
            //            self.recordModel = [CommuSignCompleteRecordModel modelWithDictionary:lastRecordDic];
            //            NSDictionary *commuSignPsn = responseObject[@"data"][@"commuSignPsn"];
            //            if (commuSignPsn.count > 0) {
            //                [UserConfig sharedInstance].signPsnId  = commuSignPsn[@"id"];
            //            }
        }else{
            //没有签约医生团队
//            isSign = NO;
        }

    } failure:^(NSError * _Nonnull error) {
 
    }];
}
@end

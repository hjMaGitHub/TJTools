//
//  ZHExternCommonTool.m
//  HealthApplicaton
//
//  Created by 涂欢 on 2018/9/18.
//  Copyright © 2018年 Beijing Tianjian Yuan Da Tecnology Co.,Ltd. All rights reserved.
//

#import "ZHExternCommonTool.h"

@implementation ZHExternCommonTool
//http://17j158m674.iask.in  董玲
//http://123.126.109.40:30024  开发环境
//http://123.126.109.40:30058  质控部测试
//董玲
/*
NSString *ZHReqBaseUrl = @"http://17j158m674.iask.in/AreaApp-API";
NSString *ZHPTReqBaseUrl = @"http://17j158m674.iask.in/AreaApp-API";
NSString *ZHReqImageUrl = @"http://17j158m674.iask.in/AreaApp-API";//图片
NSString *ZHReqAppBaseUrl = @"http://17j158m674.iask.in/AreaAppBaseServer";//基础框架
NSString *ZHReqAppFileUrl = @"http://17j158m674.iask.in/AreaAppFile";//文件
*/


//张德胜
/*
NSString *ZHReqBaseUrl = @"http://192.168.0.53:8080/AreaApp-API";
NSString *ZHPTReqBaseUrl = @"http://192.168.0.53:8080/AreaApp-API";
NSString *ZHReqImageUrl = @"http://192.168.0.53:8080/AreaApp-API";//图片
NSString *ZHReqAppBaseUrl = @"http://192.168.0.53:8080/AreaAppBaseServer";//基础框架
NSString *ZHReqAppFileUrl = @"http://192.168.0.53:8080/AreaAppFile";//文件
*/
//测试

//NSString *ZHReqBaseUrl = @"http://123.126.109.40:30058/AreaApp-API";
//NSString *ZHPTReqBaseUrl = @"http://123.126.109.40:30058/AreaApp-API";
//NSString *ZHReqImageUrl = @"http://123.126.109.40:30058/AreaApp-API";//图片
//NSString *ZHReqAppBaseUrl = @"http://123.126.109.40:30058/AreaAppBaseServer";//基础框架
//NSString *ZHReqAppFileUrl = @"http://123.126.109.40:30058/AreaAppFile";//文件



NSString *ZHReqBaseUrl = @"http://110.43.198.80:30024/AreaApp-API";
NSString *ZHPTReqBaseUrl = @"http://110.43.198.80:30024/AreaApp-API";
NSString *ZHReqImageUrl = @"http://110.43.198.80:30024/AreaApp-API";//图片
NSString *ZHReqAppBaseUrl = @"http://110.43.198.80:30024/AreaAppBaseServer";//基础框架
NSString *ZHReqAppFileUrl = @"http://110.43.198.80:30024/AreaAppFile";//文件



//注册相关
NSString *ZHpatientRegisterAction = @"/registerAction.do?";
//登录相关
NSString *ZHpatientUserAction = @"/phoneUser.do?";
//健康资讯
NSString *ZHHealthInfomationAction = @"/HealthInfomationAction.do?";
NSString *ZHbaseFunctionAction = @"/baseFunctionAction.do?";
NSString *ZHhealthInformation = @"/healthInformation.do?";

//医生团队
NSString *ZHcommuSignDocAction = @"/commuSignDocAction.do?";
NSString *ZHcommuSignAction = @"/commuSignAction.do?";
NSString *ZHfamilyMember = @"/familyMember.do?";
NSString *ZHhomeDoctor = @"/homeDoctor.do?";

//社区
NSString *ZHcommunityServerAction = @"/communityServerAction.do?";

//消息
NSString *ZHmessageCenter = @"/messageCenter.do?";

//咨询
NSString *ZHfamilyDoctorAction = @"/familyDoctorAction.do?";


//医院信息
NSString *ZHHspBaseDictAction = @"/HspBaseDictAction.do?";
//医生信息
NSString *ZHAppointmentAction = @"/AppointmentAction.do?";
NSString *ZHHspInfoAction = @"/HspInfoAction.do?";
NSString *ZHFocusAction = @"/FocusAction.do?";

//预约
NSString *ZHReservationAction = @"/ReservationAction.do?";
NSString *ZHPaymentBaseAction = @"/PaymentBaseAction.do?";
NSString *ZHAlipayNotifyAction = @"/AlipayNotifyAction.do?";

//获取健康资讯、新闻、公告
NSString *ZHhealthInfoAction = @"/healthInfoAction.do?";
//就诊人
NSString *ZHPatientAction = @"/PatientAction.do?";

//检查报告列表
NSString *ZHLabExamRecordAction = @"/LabExamRecordAction.do?";
//病历\处方
NSString *ZHSelfMedicalRecordAction = @"/selfMedicalRecordAction.do?";
NSString *ZHMedicalRecordAction = @"/medicalRecordAction.do?";
//费用
NSString *ZHHealthConsumptionAction = @"/HealthConsumptionAction.do?";

//处方单
NSString *ZHMeClinicPresAction = @"/ClinicPresAction.do?";

//素养、自评
NSString *ZHQuestionAction = @"/QuestionAction.do?";


//保存评价 获取评价
NSString *ZHAppraiseAction = @"/AppraiseAction.do?";
//健康知识
NSString *ZHhealthKnowledgeAction = @"/healthKnowledgeAction.do?";


//健康自测
NSString *ZHphoneSelfTestAction = @"/phoneSelfTestAction.do?";


//添加日记
NSString *ZHRehabilitationDiaryAction = @"/RehabilitationDiaryAction.do?";


//
NSString *ZHsearchHspAction = @"/searchHspAction.do?";

//
NSString *ZHcommonPatient = @"/commonPatient.do?";


//
NSString *ZHrelativeAction = @"/relativeAction.do?";





@end

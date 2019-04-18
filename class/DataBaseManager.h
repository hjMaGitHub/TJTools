//
//  DataBaseManager.h
//  AreaApplication
//
//  Created by 吕强 on 15/12/3.
//  Copyright © 2015年 涂婉丽. All rights reserved.
//
#define TJ_UserInfo                 @"TJ_UserInfo"//用户信息
#define TJ_DataVersion              @"TJ_DataVersion"//数据库版本

#import <Foundation/Foundation.h>
#import "FMDB.h"
#import "RootModel.h"

@interface DataBaseManager : NSObject

@property (nonatomic,strong)FMDatabase *fmdb;
@property (nonatomic, strong)FMDatabaseQueue *queue;
//获取管理类的单例对象
+ (DataBaseManager *)manager;
- (void)clearData:(NSInteger)index;
#pragma mark - 个人信息
-(BOOL)insertUserInfo;
@end

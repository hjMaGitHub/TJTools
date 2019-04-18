//
//  DataBaseManager.m
//  AreaApplication
//
//  Created by 吕强 on 15/12/3.
//  Copyright © 2015年 涂婉丽. All rights reserved.
//

#import "DataBaseManager.h"
#define TJ_Current_DataVersion     1  //数据库版本号

@interface DataBaseManager ()

@property (nonatomic,assign)BOOL isFirst;//是否第一次
@end

@implementation DataBaseManager

+(DataBaseManager *)manager
{
    static DataBaseManager *dm;
    static dispatch_once_t dmonce;
    dispatch_once(&dmonce, ^{
        dm = [[DataBaseManager alloc] init];
    });
    return dm;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        //需要管理的数据库的路径
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        //沙盒路径下创建文件夹
        NSFileManager *fileManager = [[NSFileManager alloc] init];
        NSString *createPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"FMDB"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:createPath]) {
            [fileManager createDirectoryAtPath:createPath withIntermediateDirectories:YES attributes:nil error:nil];
            _isFirst = YES;
        }
        //使用数据库的路径初始化管理者
        _fmdb = [FMDatabase databaseWithPath:[NSString stringWithFormat:@"%@/FMDB.db",createPath]];
        DLog(@"Is SQLite compiled with it's thread safe options turned on? %@!", [FMDatabase isSQLiteThreadSafe] ? @"Yes" : @"No");
        //打开数据库（如果数据库文件不存在，就先创建，再打开）
        BOOL isOpen = [_fmdb open];
        DLog(@"open  ===   %tu",isOpen);
        ///Users/devintu/Library/Developer/CoreSimulator/Devices/0A10C64F-97D1-440C-B187-6E267B5CE55D/data/Containers/Data/Application/5CA11110-DAA3-457E-BD59-D31C8387F634/Documents/FMDB/knowedge_newsDetail.sqlite
        NSString *knowedgePath = [NSString stringWithFormat:@"%@/knowedge_newsDetail.sqlite",createPath];
        
        _queue = [FMDatabaseQueue databaseQueueWithPath:knowedgePath];
        
        //数据库版本
        if ([self.fmdb tableExists:TJ_DataVersion]) {
            NSString *versionSql = [NSString stringWithFormat:@"select * from %@",TJ_DataVersion];
            FMResultSet *set = [self.fmdb executeQuery:versionSql];
            NSInteger lastVersion = 0;
            NSString *lastString = @"";
            while ([set next]) {
                lastVersion = [set intForColumn:@"version"];
                lastString = [set stringForColumn:@"version"];
            }
            if (lastVersion < TJ_Current_DataVersion || [lastString isEqualToString:TJ_DataVersion]) {
//                [self dropTable];
            }
        }
        [self createTable];

        
    }
    return self;
}

#pragma mark--清空数据
- (void)clearData:(NSInteger)index
{
    if (index<0) {
        [self deleteCommonTabName:@"messageCenter_type"];
        
        [self deleteCommonTabName:@"knowedge_newsDetail"];
        [self deleteCommonTabName:@"knowedge_PicRecom"];
        [self deleteCommonTabName:@"knowedge_newsClass"];
        
        [self deleteCommonTabName:@"Resident_Alltags"];
        [self deleteCommonTabName:@"Resident_Manager"];
        [self deleteCommonTabName:@"CommunitySerive_DaLei"];
        [self deleteCommonTabName:@"CommunitySerive_DaLeiList"];
        
        [self deleteCommonTabName:@"Resident_ConsultList"];
        [self deleteCommonTabName:@"Resident_NotificationList"];
        [self deleteCommonTabName:@"Resident_NotificationChat"];
        [self deleteCommonTabName:@"ContractService_PDFFile"];
        [self deleteCommonTabName:@"ResConsult_Chat"];
        [self deleteCommonTabName:@"ResNotification_Chat"];
        [self deleteCommonTabName:@"HealthEducationDB"];
        
    }
}
#pragma mark - 用户信息

-(BOOL)insertUserInfo{
    
    NSString *selectSql = [NSString stringWithFormat:@"delete from %@",TJ_UserInfo];
    [[DataBaseManager manager].fmdb executeUpdate:selectSql];
    
    NSString *insertSql = [NSString stringWithFormat:@"insert into %@(userId,userName,securityUserBaseinfoId,idNo,birthday,commConfigSexId,commConfigSexName,mobileTel,account,password,email,photoFlag,isRememberPW,isLoginAutomatic) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)",TJ_UserInfo];
    BOOL isInsert = [self.fmdb executeUpdate:insertSql,[UserConfig sharedInstance].userId,[UserConfig sharedInstance].name,[UserConfig sharedInstance].securityUserBaseinfoId,[UserConfig sharedInstance].idNo,[UserConfig sharedInstance].birthDay,[UserConfig sharedInstance].sexId,[UserConfig sharedInstance].sexName,[UserConfig sharedInstance].mobileTel,[UserConfig sharedInstance].account,[UserConfig sharedInstance].password,[UserConfig sharedInstance].email,[UserConfig sharedInstance].photoUrl,[UserConfig sharedInstance].isRememberPW,[UserConfig sharedInstance].isLoginAutomatic];
    if (!isInsert) {
        DLog(@"insert = %@",self.fmdb.lastErrorMessage);
    }
    return isInsert;
    
}
/**
 判断是否需要初始化表
 */
- (void)createTable
{
    
    //sql语句，专门用来操作数据库的语句
    //create table if not exists是固定的，如果表不存在就创建
    //userInfo()表示的是一个表,userInfo是表名，小括号里是字段信息
    //字段之间用逗号隔开，每一个字段的第一个单词是字段名，第二个单词是数据类型，primary key代表主键，autoincrement代表主键自增
    //用户信息
    //创建健康资讯表

    if (![self.fmdb tableExists:TJ_UserInfo]) {
        NSString *userInfoSql = [NSString stringWithFormat:@"create table if not exists %@(id integer primary key autoincrement,userId varchar(256),userName text,securityUserBaseinfoId varchar(256),idNo varchar(256),birthday varchar(256),commConfigSexId varchar(256),commConfigSexName text,mobileTel varchar(256),account varchar(256),password varchar(256),email varchar(256),photoFlag varchar(256),isRememberPW text,identityType text,isLoginAutomatic text)",TJ_UserInfo];
        [self createTableSql:userInfoSql];
    }
    
    
    //保存当前版本号
    if (![self.fmdb tableExists:TJ_DataVersion]) {
        NSString *versionSql = [NSString stringWithFormat:@"create table if not exists %@(id integer primary key autoincrement,version INTEGER)",TJ_DataVersion];
        [self createCommonTab:versionSql tabName:@"版本号表"];
        NSString *insertSql = [NSString stringWithFormat:@"insert into %@(version) values(?)",TJ_DataVersion];
        BOOL isInsert = [self.fmdb executeUpdate:insertSql,[NSString stringWithFormat:@"%d",TJ_Current_DataVersion]];
        if (!isInsert) {
            DLog(@"insert = %@",self.fmdb.lastErrorMessage);
        }
    }
    
    //创建健康资讯表
    [self createCommonTab:@"create table if not exists findInformation_list (newsId TEXT primary key,informationContent TEXT, title TEXT, image TEXT, createDate TEXT, typeId TEXT,updateUser TEXT);"tabName:@"资讯表"];
    
}

- (void)createCommonTab:(NSString *)createSql tabName:(NSString *)name
{
    [_queue inDatabase:^(FMDatabase *db) {
        BOOL result = [db executeUpdate:createSql];
        NSString *tabStr = @"失败";
        if (result) {
            tabStr = @"成功";
        } else {
            tabStr = @"失败";
        }
        DLog(@"创建%@表%@",name,tabStr);
    }];
}
-(void)createTableSql:(NSString *)createSql
{
    if ([self.fmdb open]) {
        //执行更新的sql语句（只要操作对数据库产生了改变，在fmdb看来都属于更新操作）
        BOOL isCreate = [self.fmdb executeUpdate:createSql];
        if (!isCreate) {
            //如果执行sql语句失败，打印错误信息
            DLog(@"create = %@",self.fmdb.lastErrorMessage);
        }
    }
}
- (void)deleteCommonTabName:(NSString *)name
{
    NSString *strSql = [NSString stringWithFormat:@"delete from %@",name];
    [_queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        BOOL result = [db executeUpdate:strSql];
        NSString *tabStr = @"失败";
        if (result) {
            tabStr = @"成功";
        } else {
            tabStr = @"失败";
        }
    }];
}



@end

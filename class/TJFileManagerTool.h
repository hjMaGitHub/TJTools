//
//  TJFileManagerTool.h
//  AreaApplication
//
//  Created by Lv Qiang on 2017/3/9.
//  Copyright © 2017年 Beijing Tianjian Yuan Da Tecnology Co.,Ltd. All rights reserved.
//  文件操作工具

#import <Foundation/Foundation.h>

@interface TJFileManagerTool : NSObject

//获取DocumentDirectory文件路径
+ (NSString*)getDocumentDirectoryPathString;
//获取CachesDirectory文件路径
+ (NSString*)getCachesDirectoryPathString;
//获取TemporaryDirectory文件路径
+ (NSString*)getTemporaryDirectoryPathString;
//文件是否存在
+ (BOOL)isFileExistAtPath:(NSString*)fileFullPath;
//获取资源文件路径 Images.xcassets里的图片不在根目录下，不能通过该方法获取
+ (NSString*)getFilePathWithName:(NSString*)fileName ofType:(NSString*)fileType;
//在DocumentDirectory中创建文件夹
+ (BOOL)createFileDirectory:(NSString*)directoryName;
//清空DocumentDirectory中某个文件夹里的所有文件
+ (void)removeAllFileInDocumentDirection:(NSString*)directoryName;
//清空文件夹里的所有文件
+ (void)removeAllFileInDirection:(NSString*)directoryPath;
//计算DocumentDirectory中某个文件夹里的文件总大小
+ (float)getTotalSizeInDocumentDirection:(NSString*)directoryName;
//计算文件夹里的文件总大小
+ (float)getTotalSizeInDirection:(NSString *)directoryPath;
//找出文件夹中指定类型的文件
+ (NSArray *)getFilenamelistOfType:(NSString *)type fromDirPath:(NSString *)directoryPath;

@end

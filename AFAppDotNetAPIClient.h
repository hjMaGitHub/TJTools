//
//  AFAppDotNetAPIClient.h
//  AreaApplication
//
//  Created by 吕强 on 15/12/3.
//  Copyright © 2015年 涂婉丽. All rights reserved.
//  网络监听
#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

@interface AFAppDotNetAPIClient : AFHTTPSessionManager
+ (instancetype)sharedClient;

@property (nonatomic,assign) NSInteger type;

@end

//
//  AFNetworkType.h
//  AreaApplication
//
//  Created by 吕强 on 16/4/18.
//  Copyright © 2016年 涂婉丽. All rights reserved.
//  网络状态单例

#import <Foundation/Foundation.h>

@interface AFNetworkType : NSObject

/**
 *  类型  1、流量 2、Wi-Fi 3、无网络状态
 */
@property (nonatomic,assign)NSInteger type;

+(AFNetworkType *)sharedInstance;

@end

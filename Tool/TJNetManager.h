//
//  TJNetManager.h
//  LvCode
//
//  Created by 吕强 on 16/7/19.
//  Copyright © 2016年 吕强. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface TJNetManager : NSObject

+ (AFHTTPSessionManager *)shareInstance;

@end

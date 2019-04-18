//
//  AFNetworkType.m
//  AreaApplication
//
//  Created by 吕强 on 16/4/18.
//  Copyright © 2016年 涂婉丽. All rights reserved.
//

#import "AFNetworkType.h"

@implementation AFNetworkType

+(AFNetworkType *)sharedInstance
{
    static AFNetworkType *afnetworkType;
    static dispatch_once_t afnetworkTypeonce;
    dispatch_once(&afnetworkTypeonce, ^{
        afnetworkType = [[AFNetworkType alloc] init];
    });
    return afnetworkType;
}

@end

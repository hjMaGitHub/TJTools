//
//  AFAppDotNetAPIClient.m
//  AreaApplication
//
//  Created by 吕强 on 15/12/3.
//  Copyright © 2015年 涂婉丽. All rights reserved.
//

#import "AFAppDotNetAPIClient.h"
#import "AppDelegate.h"
#import "AFNetworkType.h"
static NSString * const AFAppDotNetAPIBaseURLString = @"https://api.app.net/";


@implementation AFAppDotNetAPIClient


+ (instancetype)sharedClient {
    
    static AFAppDotNetAPIClient *_sharedClient = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        _sharedClient = [[AFAppDotNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:AFAppDotNetAPIBaseURLString]];
        
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        
        
        
        [_sharedClient.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            
            switch (status) {
                    
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    
                    
                    [AFNetworkType sharedInstance].type = 1;
                    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationNetWork_Success object:nil];
                    break;
                    
                    
                    
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    
                    [AFNetworkType sharedInstance].type = 2;
                    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationNetWork_Success object:nil];
                    break;
                    
                case AFNetworkReachabilityStatusNotReachable:
                    
                    [(AppDelegate *)[[UIApplication sharedApplication] delegate] showMessage:@"亲，您的手机网络不太顺畅喔～"];
                    [AFNetworkType sharedInstance].type = 3;
                    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationNetWork_File object:nil];
                    break;
                    
                default:
                    
                    break;
                    
            }
            
        }];
        
        [_sharedClient.reachabilityManager startMonitoring];
        
    });
    
    
    return _sharedClient;
    
}

@end

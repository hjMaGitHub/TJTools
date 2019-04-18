//
//  JSProgressHUD.h
//  AreaApplication
//
//  Created by apple on 2017/6/26.
//  Copyright © 2017年 Beijing Tianjian Yuan Da Tecnology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"


@interface JSProgressHUD : NSObject
///统一Indicator(显示) 主线程调用
+ (void)showIndicator;
///统一Indicator(隐藏) 主线程调用
+ (void)hideIndicator;

@end

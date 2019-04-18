//
//  JSProgressHUD.m
//  AreaApplication
//
//  Created by apple on 2017/6/26.
//  Copyright © 2017年 Beijing Tianjian Yuan Da Tecnology Co.,Ltd. All rights reserved.
//

#import "JSProgressHUD.h"

#define Key_Window  [UIApplication sharedApplication].delegate.window

@implementation JSProgressHUD

///菊花
static long loadCount = 0;//声明静态变量
static MBProgressHUD *shareHud;


///创建信号量和菊花
+ (dispatch_semaphore_t)shareLockSignal{
    static dispatch_semaphore_t lockSignal;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        lockSignal = dispatch_semaphore_create(1);
        shareHud = [MBProgressHUD showHUDAddedTo:Key_Window animated:YES];
    });
    return lockSignal;
}

///显示菊花
+ (void)showIndicator{
    dispatch_semaphore_t lockSignal = [self shareLockSignal];
    dispatch_semaphore_wait(lockSignal, DISPATCH_TIME_FOREVER);
    loadCount++;
    shareHud.frame = Key_Window.bounds;
    [Key_Window addSubview:shareHud];
    dispatch_semaphore_signal(lockSignal);
}

///隐藏菊花
+ (void)hideIndicator{
    dispatch_semaphore_t lockSignal = [self shareLockSignal];
    dispatch_semaphore_wait(lockSignal, DISPATCH_TIME_FOREVER);
    loadCount--;
    dispatch_async(dispatch_get_main_queue(), ^{
        //网络请求数量为0时，移除菊花
        if (loadCount == 0) {
            [shareHud removeFromSuperview];
        }
    });
    dispatch_semaphore_signal(lockSignal);
}
    
@end

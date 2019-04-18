//
//  ILNavigationController.m
//  区域App应用
//
//  Created by 涂婉丽 on 15/10/27.
//  Copyright (c) 2015年 涂婉丽. All rights reserved.

#import "ILNavigationController.h"
@interface ILNavigationController ()

@end

@implementation ILNavigationController

#pragma mark 一个类只会调用一次
+ (void)initialize
{
    // 1.取出设置主题的对象
    //取出导航栏样式
    UINavigationBar *navBar = [UINavigationBar appearance];
    //    [navBar setBarTintColor:[UIColor redColor]];
//    //取出按钮样式
    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    
    // 2.设置导航栏的背景图片
    
//
    [navBar setBackgroundImage:[Tool  imageWithColor:[UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1] size:CGSizeMake(k_width, 64)] forBarMetrics:UIBarMetricsDefault];
    

//     3.设置导航栏标题颜色为白色
    [navBar setTitleTextAttributes:@{
                                     NSForegroundColorAttributeName : [UIColor blackColor]
                                     }];
//
//    // 4.设置导航栏按钮文字颜色为白色
    [barItem setTitleTextAttributes:@{
                                      NSForegroundColorAttributeName : [UIColor blackColor],
                                      NSFontAttributeName : [UIFont systemFontOfSize:15]
                                      } forState:UIControlStateNormal];
    [navBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18], NSForegroundColorAttributeName:[UIColor blackColor]}];

     [[UITabBar appearance] setTranslucent:NO];

}


//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//    // 白色样式
////    return UIStatusBarStyleLightContent;
////    return UIStatusBarStyleDefault;
//}

@end

//
//  RootViewController.h
//  AreaApplication
//
//  Created by 吕强 on 16/4/7.
//  Copyright © 2016年 涂婉丽. All rights reserved.
//  基类

#import <UIKit/UIKit.h>
#import "TJNetRequestFail.h"
#import "TJNetWorkRemindView.h"
#import "MBProgressHUD.h"
#import "NetWorkRemind.h"

typedef NS_ENUM(NSInteger,ServicePackType){
        ServicePackType_False, // 没有服务包
        ServicePackType_True // 有服务包

};


@interface RootViewController : UIViewController <MBProgressHUDDelegate,UIGestureRecognizerDelegate,TJNetRequestFailDelegate,TJNetWorkRemindViewDelegate>
/**
 *  重新加载按钮
 */
@property(nonatomic,retain)TJNetRequestFail *requestView;//重新请求
/**
 *  无网络状态提醒栏
 */
@property(nonatomic,retain)TJNetWorkRemindView *netFileView;//提醒栏

@property (nonatomic, strong)UIImageView *navBarlineImageView;

/**
 *  调用添加返回按钮和手势
 */
- (void)addBackItemAndAction;

/**
 *  调用添加白色返回按钮和手势
 */
- (void)addBackItemAndActionColorWithWhite;

/**
 *  关闭按钮
 */
- (void)addCloseItem;
/**
 *  返回上一页
 */
- (void)backBefore;
/**
 *  隐藏导航栏线
 */
- (void)showLineView:(BOOL)ishidden;

/**
 显示网络断开
 */
- (void)showNetFileRemindView;

/**
 网络连接
 */
- (void)hiddenNetFileRemindView;


@end

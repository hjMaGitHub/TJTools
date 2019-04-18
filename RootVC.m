//
//  RootVC.m
//  区域App应用
//
//  Created by 涂婉丽 on 15/10/27.
//  Copyright (c) 2015年 涂婉丽. All rights reserved.


#import "RootVC.h"
#import "ILNavigationController.h"
#import "FindVC.h"
#import "CustomHeaderViewController.h"
#import "HealthKnowedgeListVC.h"
#import "ZHHomeVC.h"

@interface RootVC ()<UITabBarControllerDelegate,UITabBarDelegate>
{
    ZHHomeVC *zhHome;
    CustomHeaderViewController *customVC;
}
@property (nonatomic,assign)NSInteger unRead;
@property BOOL isRemindSelect;
-(void)loadTabBarController;
@end

@implementation RootVC
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    self.view.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestMessageOresident) name:NotificationLogin object:nil];
    [self loadTabBarController];

    //获取健康头条
    [ZHCommonRequsetTool getHealthHeadlineSuccess:^(id response) {
    } failure:^(NSError * error) {
    }];
}
-(void)loadTabBarController
{
    zhHome = [[ZHHomeVC alloc]init];
    
    ILNavigationController *ZHhomeNav =  [self setRootTabBarItemControl:zhHome PitchImage:@"tabbar_homeGray" rootImage:@"tabbar_home" Title:@"智慧健康"];
    
    HealthKnowedgeListVC *jkVC = [[HealthKnowedgeListVC alloc]init];
    ILNavigationController *JKnv = [self setRootTabBarItemControl:jkVC PitchImage:@"tabbar_newsGray" rootImage:@"tabbar_news" Title:@"健康头条"];
    
    FindVC *findVC = [[FindVC alloc]init];
    ILNavigationController *finnv = [self setRootTabBarItemControl:findVC PitchImage:@"tabbar_findGray" rootImage:@"tabbar_find" Title:@"发现"];
    
    customVC = [[CustomHeaderViewController alloc]init];
    ILNavigationController *cusnv = [self setRootTabBarItemControl:customVC PitchImage:@"tabbar_meGray" rootImage:@"tabbar_me" Title:@"我"];
    
    NSArray *controllers = @[ZHhomeNav,JKnv,finnv,cusnv];
    self.tabBar.tintColor = DeviceColor;
    [self setViewControllers:controllers];
}

#pragma make 设置tabbar
-(ILNavigationController *)setRootTabBarItemControl:(id)control PitchImage:(NSString *)pitchIM rootImage:(NSString *)rootIM Title:(NSString *)title{
    UIImage * rootPitch = [[UIImage imageNamed:pitchIM]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage * rootImg = [[UIImage imageNamed:rootIM]  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    ILNavigationController *NV = [[ILNavigationController alloc]initWithRootViewController:control];
    NV.tabBarItem = [[UITabBarItem alloc]initWithTitle:title image:rootPitch selectedImage:rootImg];
    [NV.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, TabaleBarTitleHeight)];
    
    return NV;
}
#pragma mark - 公用网络请求
- (void)requestMessageOresident
{
    [ZHCommonRequsetTool getMessageUnReadSuccess:^(id responseObject) {
        [zhHome showUnReadNum];
        [customVC showUnReadNum];
    } failure:^(NSError *error) {
    }];
    [ZHCommonRequsetTool jusityThePersonActive:^(id success) {
        
    } failure:^(NSError *error) {
        
    }];
    [ZHCommonRequsetTool getMySignTeam:^(id success) {
    } failure:^(NSError *error) {
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

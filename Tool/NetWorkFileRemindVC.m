//
//  NetWorkFileRemindVC.m
//  AreaApplication
//
//  Created by 吕强 on 16/4/19.
//  Copyright © 2016年 涂婉丽. All rights reserved.
//

#import "NetWorkFileRemindVC.h"
#import "MyLabel.h"
@interface NetWorkFileRemindVC ()

@end

@implementation NetWorkFileRemindVC
-(void)viewDidAppear:(BOOL)animated
{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"无网络连接";
    self.view.backgroundColor = [UIColor whiteColor];
    [self addBackItemAndAction];
    [self createUI];
}
- (void)createUI
{
    //1、打开设备的“系统设置”>“无线和网络”>“移动网络”。\n2
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 20, bounds_width-40, 40)];
    titleLabel.text = @"请设置你的网络";
    titleLabel.textColor = [UIColor colorWithRed:87/255.0f green:90/255.0f blue:94/255.0f alpha:1];
    titleLabel.font = [UIFont systemFontOfSize:18];
    
    [self.view addSubview:titleLabel];
    
    MyLabel *remindLabel = [[MyLabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(titleLabel.frame)+10, bounds_width-40, 90)];
    remindLabel.text = @"1.打开设备的“系统设置”>“无线和网络”>“移动网络”。\n\n2.打开设备的“系统设置”>“WLAN”，“启动WLAN”后从中选择一个可用的热点连接。";
    remindLabel.textColor = [UIColor colorWithRed:157/255.0f green:157/255.0f blue:157/255.0f alpha:1];
    remindLabel.numberOfLines = 0;
    remindLabel.font = [UIFont systemFontOfSize:14];
    remindLabel.verticalAlignment = VerticalAlignmentTop;
    [self.view addSubview:remindLabel];
    
    UIView *grayView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(remindLabel.frame), bounds_width, 15)];
    grayView.backgroundColor = [UIColor colorWithRed:238/255.0f green:238/255.0f blue:238/255.0f alpha:1];
    [self.view addSubview:grayView];
    
    UILabel *titleWFLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(grayView.frame), bounds_width-40, 40)];
    titleWFLabel.text = @"如果你已经连接Wi-Fi网络";
    titleWFLabel.textColor = [UIColor colorWithRed:87/255.0f green:90/255.0f blue:94/255.0f alpha:1];
    titleWFLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:titleWFLabel];
    
    MyLabel *remindWFLabel = [[MyLabel alloc]initWithFrame:CGRectMake(20,CGRectGetMaxY(titleWFLabel.frame)+10, bounds_width-40, 60)];
    remindWFLabel.text = @"请确认你所介入的Wi-Fi网络已经连入互联网，或者确认你的设备是否被允许接入该热点。";
    remindWFLabel.textColor = [UIColor colorWithRed:157/255.0f green:157/255.0f blue:157/255.0f alpha:1];
    remindWFLabel.numberOfLines = 0;
    remindWFLabel.font = [UIFont systemFontOfSize:14];
    remindWFLabel.verticalAlignment = VerticalAlignmentTop;
    [self.view addSubview:remindWFLabel];
    
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

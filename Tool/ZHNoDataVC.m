//
//  ZHNoDataVC.m
//  HealthApplicaton
//
//  Created by 马恒健 on 2018/9/10.
//  Copyright © 2018年 Beijing Tianjian Yuan Da Tecnology Co.,Ltd. All rights reserved.
//

#import "ZHNoDataVC.h"

@interface ZHNoDataVC ()
@property (nonatomic,strong)NetWorkRemind *netWorkView;
@end

@implementation ZHNoDataVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:self.title];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:self.title];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBackItemAndAction];
    self.netWorkView.hidden = NO;
}

- (NetWorkRemind *)netWorkView{
    if (!_netWorkView) {
        _netWorkView = [[NetWorkRemind alloc]initWithFrame:CGRectMake((k_width-180)/2,(k_height-180)/3, 180, 180)];
        [self.view addSubview:_netWorkView];
        [self.view bringSubviewToFront:_netWorkView];
        _netWorkView.hidden = YES;
        [_netWorkView showNetworkRemindViewImageType:NetWork_Sweat title:@"暂时没有数据~~"];
    }
    return _netWorkView;
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

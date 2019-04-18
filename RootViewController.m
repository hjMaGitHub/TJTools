//
//  RootViewController.m
//  AreaApplication
//
//  Created by 吕强 on 16/4/7.
//  Copyright © 2016年 涂婉丽. All rights reserved.
//

#import "RootViewController.h"
#import "NetWorkFileRemindVC.h"


@interface RootViewController ()

@end

@implementation RootViewController

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([AFNetworkType sharedInstance].type == 3) {
        [self performSelector:@selector(showNetFileRemindView) withObject:nil afterDelay:2];
    }else{
        if (self.netFileView.isHidden == NO) {
            self.netFileView.hidden = YES;
        }
    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.netFileView.hidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _navBarlineImageView = [self lineImageViewBar:self.navigationController.navigationBar];
    [self.view addSubview:self.netFileView];
    self.view.backgroundColor = DeviceBackGroundColor;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showNetFileRemindView) name:NotificationNetWork_File object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hiddenNetFileRemindView) name:NotificationNetWork_Success object:nil];

}
-(TJNetWorkRemindView *)netFileView
{
    if (!_netFileView) {
        
        _netFileView = [[TJNetWorkRemindView alloc]init];
        _netFileView.delegate = self;
        _netFileView.hidden = YES;
    }
    
    return _netFileView;
}
- (void)showNetFileRemindView
{
    self.netFileView.hidden = NO;
    [[self.netFileView superview] bringSubviewToFront:self.netFileView];
}
- (void)hiddenNetFileRemindView
{
    self.netFileView.hidden = YES;
}
-(TJNetRequestFail *)requestView
{
    if (!_requestView) {
        _requestView = [[TJNetRequestFail alloc]initWithFrame:self.view.bounds];
        _requestView.delegate = self;
        [_requestView remindType:1 OrTitle:nil Detail:nil];
    }
    
    return _requestView;
}

/**
 *  重新加载
 */
-(void)NetRequestFailRequestAgain
{
    
}
/**
 *  打开无网络提醒页面
 */
-(void)openNetWorkFileRemindPage
{
    NetWorkFileRemindVC *remind = [[NetWorkFileRemindVC alloc]init];
    remind.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:remind animated:YES];
}
- (void)veryBadNetWork
{
    
}
- (void)noConnection
{
    
}
/**
 *  添加右侧返回按钮
 */
- (void)addBackItemAndAction
{
    UIBarButtonItem * leftItem = nil;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7){
        leftItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"back_black"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(backBefore)];
    } else {
        leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_black"] style:UIBarButtonItemStyleDone target:self action:@selector(backBefore)];
    }
    self.navigationItem.leftBarButtonItem =leftItem;
    
    
//    [self addCloseItem];
    
    //自定义leftbarbuttonitem会导致右划手势失效.
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
        
    }
}

/**
 *  添加右侧白色返回按钮
 */
- (void)addBackItemAndActionColorWithWhite
{
    UIBarButtonItem * leftItem = nil;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7){
        leftItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"back_whiteRoot"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(backBefore)];
    } else {
        leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_whiteRoot"] style:UIBarButtonItemStyleDone target:self action:@selector(backBefore)];
    }
    self.navigationItem.leftBarButtonItem =leftItem;
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     
  @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
//    [self addCloseItem];
    
    //自定义leftbarbuttonitem会导致右划手势失效.
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
        
    }
}



- (void)addCloseItem
{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithTitle:@"关闭" style:UIBarButtonItemStyleDone target:self action:@selector(closePage)];
    self.navigationItem.rightBarButtonItem = rightItem;
}
- (void)backBefore
{
    if ([[self.navigationController.viewControllers[0] class] isSubclassOfClass:[self class]]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)closePage
{
    if ([[self.navigationController.viewControllers[0] class] isSubclassOfClass:[self class]]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
- (void)showLineView:(BOOL)ishidden
{
    if (ishidden) {
        _navBarlineImageView.hidden = YES;
    }else{
        _navBarlineImageView.hidden = NO;
    }
}
- (UIImageView *)lineImageViewBar:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self lineImageViewBar:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];

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

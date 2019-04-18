//
//  ZHLocationManager.m
//  HealthApplicaton
//
//  Created by 涂欢 on 2018/9/19.
//  Copyright © 2018年 Beijing Tianjian Yuan Da Tecnology Co.,Ltd. All rights reserved.
//

#import "ZHLocationManager.h"
#import <CoreLocation/CoreLocation.h>
#import "UserConfig.h"
#import "CLLocation+YCLocation.h"
#define Location_Key @"Location_Key_2.2.1"
#define SelectLocation_Key @"SelectLocation_Key_2.2.1"
@interface ZHLocationManager ()<CLLocationManagerDelegate>

@property (nonatomic,strong) CLLocationManager *locationManager;

@end
@implementation ZHLocationManager
+ (ZHLocationManager *)manager {
    static ZHLocationManager *tjManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tjManager = [[ZHLocationManager alloc]init];
    });
    return tjManager;
}
-(instancetype)init {
    self = [super init];
    
    if (self) {
        _type = TJLocation_UnLocation;
        
        NSString *city = [[NSUserDefaults standardUserDefaults] objectForKey:Location_Key];
        if (city.length > 0) {
            _locality = city;
        }else{
            _locality = @"";
        }
    }
    return self;
}

#pragma mark  定位获取城市
-(CLLocationManager *)locationManager {
    if (!_locationManager) {
        // 初始化定位管理器
        _locationManager = [[CLLocationManager alloc] init];
        // 设置代理
        _locationManager.delegate = self;
        // 设置定位精确度到米
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        // 设置过滤器为无
        _locationManager.distanceFilter = kCLDistanceFilterNone;
        // 取得定位权限，有两个方法，取决于你的定位使用情况
        // 一个是requestAlwaysAuthorization，一个是requestWhenInUseAuthorization
        // 这句话ios8以上版本使用。
        [_locationManager requestWhenInUseAuthorization];
        [_locationManager startMonitoringSignificantLocationChanges];
    }
    return _locationManager;
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    CLLocation *cl = [locations objectAtIndex:0];
    CLLocation *sparkCl=[cl locationMarsFromEarth];
    DLog(@"地球纬度--%f  地球经度--%f  火星纬度--%f  火星经度--%f",cl.coordinate.latitude,cl.coordinate.longitude,sparkCl.coordinate.latitude,sparkCl.coordinate.longitude);
    _latitudeStr = [NSString stringWithFormat:@"%f",sparkCl.coordinate.latitude];
    _longitudeStr = [NSString stringWithFormat:@"%f",sparkCl.coordinate.longitude];
    
    
    
    // 保存 Device 的现语言 (英语 法语 ，，，)
    NSMutableArray *userDefaultLanguages = [[NSUserDefaults standardUserDefaults]
                                            objectForKey:@"AppleLanguages"];
    // 强制 成简体中文
    [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:@"zh-hans",nil]
                                              forKey:@"AppleLanguages"];
    // 获取当前所在的城市名
//    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    if (_latitudeStr.length>0&&_longitudeStr.length>0) {
        _type = TJLocation_Success;
    }else{
        _type = TJLocation_Fail;
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationLocation_End object:@[self.longitudeStr,self.latitudeStr]];
    // 还原Device 的语言
    [[NSUserDefaults standardUserDefaults] setObject:userDefaultLanguages forKey:@"AppleLanguages"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [_locationManager stopUpdatingLocation];
    
    //根据经纬度反向地理编译出地址信息
    //    CLLocation *l1 = [[CLLocation alloc] initWithLatitude:35.216895 longitude:113.247471];
    /*
    __weak typeof(self) weakSelf = self;
    //    locations.lastObject
    
    [geocoder reverseGeocodeLocation:locations.lastObject completionHandler:^(NSArray *array, NSError *error){
        if (_type == TJLocation_Success || _type == TJLocation_Fail) {
            return ;
        }
        if (array.count > 0){
            CLPlacemark *placemark = [array objectAtIndex:0];
            weakSelf.locality = @"";//定位成功取消记忆位置
            weakSelf.type = TJLocation_Success;
            weakSelf.nowlocality = placemark.locality.mutableCopy;
            weakSelf.nowSubLocality = placemark.subLocality.mutableCopy;
            if (weakSelf.nowlocality.length == 0) {
                weakSelf.nowlocality = @"";
                weakSelf.nowSubLocality = @"";
            }
        } else if (error == nil && [array count] == 0)
        {
            weakSelf.type = TJLocation_Fail;
            weakSelf.locality = @"";
            DLog(@"No results were returned.");
        }else if (error != nil)
        {
            weakSelf.type = TJLocation_Fail;
            weakSelf.locality = @"";
            DLog(@"An error occurred = %@", error);
        }else {
            weakSelf.type = TJLocation_Fail;
            weakSelf.locality = @"";
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:NotificationLocation_End object:@[weakSelf.nowlocality,weakSelf.nowSubLocality]];
        // 还原Device 的语言
        [[NSUserDefaults standardUserDefaults] setObject:userDefaultLanguages forKey:@"AppleLanguages"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }];
    */
    
}
-(void)setLocality:(NSString *)locality {
    _locality = locality;
    if (locality.length != 0) {
        [[NSUserDefaults standardUserDefaults] setObject:locality forKey:Location_Key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    _type = TJLocation_Fail;
    _latitudeStr = @"";
    _longitudeStr = @"";
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationLocation_End object:@""];
    UIAlertView *alvertView=[[UIAlertView alloc]initWithTitle:@"位置获取信息失败" message:@"需要开启定位服务,请到设置->隐私,打开定位服务" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去设置", nil];
    [alvertView show];
}
+ (void)getLocationWithBlock:(void (^)(TJLocationDataType type,NSString *longitude,NSString *latitude))block {
    if ([[self class] manager].type == TJLocation_UnLocation) {
        [[ZHLocationManager manager].locationManager startUpdatingLocation];
    }else if ([[self class] manager].type == TJLocation_BeLocation){
        //等待
    }else if ([[self class] manager].type == TJLocation_Fail) {//定位失败
        block(TJLocation_None, [ZHLocationManager manager].longitudeStr,[ZHLocationManager manager].latitudeStr);
    }else{//已经获取定位
        
    }
    
    if ([ZHLocationManager manager].longitudeStr.length > 0) {
        block(TJLocation_Now, [ZHLocationManager manager].longitudeStr,[ZHLocationManager manager].latitudeStr);
    }else{
        block(TJLocation_None, @"",@"");
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 100) {
        if (buttonIndex == 1) {
            NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            
            if([[UIApplication sharedApplication] canOpenURL:url]) {
                
                NSURL*url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
                [[UIApplication sharedApplication] openURL:url];
            }
        }else{
            
        }
    }
}
@end

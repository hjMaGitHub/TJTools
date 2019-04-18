//
//  ZHLocationManager.h
//  HealthApplicaton
//
//  Created by 涂欢 on 2018/9/19.
//  Copyright © 2018年 Beijing Tianjian Yuan Da Tecnology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum : NSUInteger {
    TJLocation_UnLocation,
    TJLocation_BeLocation,
    TJLocation_Success,
    TJLocation_Fail,
} TJLocationType;//定位状态
typedef enum : NSUInteger {
    TJLocation_None,//失败/无位置
    TJLocation_Cache,
    TJLocation_Now,
} TJLocationDataType;//定位数据

@interface ZHLocationManager : NSObject
@property (nonatomic,assign) TJLocationType type;
@property (nonatomic,copy) NSString *locality;//记录选择城市
@property (nonatomic,copy) NSString *nowlocality;//定位城市
@property (nonatomic,copy) NSString *nowSubLocality;//定位区域
@property (nonatomic,copy) NSString *oldLocality;//之前缓存城市
@property (nonatomic,copy) NSString *oldSubLocality;//之前缓存区域
@property (nonatomic,copy) NSString *latitudeStr;//纬度
@property (nonatomic,copy) NSString *longitudeStr;//经度

+ (ZHLocationManager *)manager;
+ (void)getLocationWithBlock:(void (^)(TJLocationDataType type,NSString *longitude,NSString *latitude))block;
@end

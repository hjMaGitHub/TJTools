//
//  EntityHelper.h
//  AreaApplication
//
//  Created by 涂婉丽 on 16/9/30.
//  Copyright © 2016年 Beijing Tianjian Yuan Da Tecnology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EntityHelper : NSObject
//字典对象转为实体对象
+ (void) dictionaryToEntity:(NSDictionary *)dict entity:(NSObject*)entity;

//实体对象转为字典对象
+ (NSDictionary *) entityToDictionary:(id)entity;
@end

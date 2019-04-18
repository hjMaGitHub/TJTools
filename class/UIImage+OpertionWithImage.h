//
//  UIImage+OpertionWithImage.h
//  AreaApplication
//
//  Created by 涂婉丽 on 16/11/3.
//  Copyright © 2016年 Beijing Tianjian Yuan Da Tecnology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (OpertionWithImage)
- (UIImage *)cutCircleImage:(CGSize)size;
- (UIImage *)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;
@end

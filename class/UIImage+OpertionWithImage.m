//
//  UIImage+OpertionWithImage.m
//  AreaApplication
//
//  Created by 涂婉丽 on 16/11/3.
//  Copyright © 2016年 Beijing Tianjian Yuan Da Tecnology Co.,Ltd. All rights reserved.
//

#import "UIImage+OpertionWithImage.h"

@implementation UIImage (OpertionWithImage)
- (UIImage *)cutCircleImage:(CGSize)size {
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    
    // 获取上下文
    
    CGContextRef ctr = UIGraphicsGetCurrentContext();
    
    // 设置圆形
    
    CGRect rect = CGRectMake(0, 0, self.size.width,self.size.height);
    
    CGContextAddEllipseInRect(ctr, rect);
    
    // 裁剪
    
    CGContextClip(ctr);
    
    // 将图片画上去
    
    [self drawInRect:rect];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}
//压缩图片尺寸
- (UIImage *)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}
@end

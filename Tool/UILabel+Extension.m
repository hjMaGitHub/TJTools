//
//  UILabel+Extension.m
//  AreaApplication
//
//  Created by apple on 2017/7/27.
//  Copyright © 2017年 Beijing Tianjian Yuan Da Tecnology Co.,Ltd. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)
-(CGFloat)getSpaceLabelHeight:(NSString *)str withWidh:(CGFloat)width
{
    
    NSMutableParagraphStyle *paragphStyle=[[NSMutableParagraphStyle alloc]init];
    
    paragphStyle.lineSpacing=0;//设置行距为0
    paragphStyle.firstLineHeadIndent=0.0;
    paragphStyle.hyphenationFactor=0.0;
    paragphStyle.paragraphSpacingBefore=0.0;
    
    NSDictionary *dic=@{
                        
                        NSFontAttributeName:[UIFont systemFontOfSize:15], NSParagraphStyleAttributeName:paragphStyle, NSKernAttributeName:@1.0f
                        
                        };
    CGSize size=[str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    return size.height;
    
}

@end

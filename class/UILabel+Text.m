//
//  UILabel+Text.m
//  AreaApplication
//
//  Created by Lv Qiang on 2016/11/15.
//  Copyright © 2016年 Beijing Tianjian Yuan Da Tecnology Co.,Ltd. All rights reserved.
//

#import "UILabel+Text.h"

@implementation UILabel (Text)

+(UILabel *)setX:(float)x setY:(float)y setW:(float)width setText:(NSString *)string setFont:(UIFont *)font setColor:(UIColor *)color 
{
    MyLabel *label = [[MyLabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    [label setNumberOfLines:0];
    label.lineBreakMode=NSLineBreakByWordWrapping;
    CGSize size=CGSizeMake(width, MAXFLOAT);
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:4];
    NSDictionary *dic = @{NSParagraphStyleAttributeName:paragraphStyle,
                          NSFontAttributeName:font,
                          NSForegroundColorAttributeName:color};
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:string attributes:dic];
    
    CGRect labelsize= [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];

    [label setFrame:CGRectMake(x, y, width, labelsize.size.height+5)];
    label.attributedText = attributedString;
    [label setVerticalAlignment:VerticalAlignmentTop];
    return label;
}

@end

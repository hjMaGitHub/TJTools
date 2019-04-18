//
//  MyLabel.h
//
//
//  Created by 吕强 on 15/10/28.
//  Copyright © 2015年 涂婉丽. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    VerticalAlignmentTop = 0, // default
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} VerticalAlignment;
@interface MyLabel : UILabel
{
@private
    VerticalAlignment _verticalAlignment;
}

@property (nonatomic) VerticalAlignment verticalAlignment;
- (void)setVerticalAlignment:(VerticalAlignment)verticalAlignment;
@end

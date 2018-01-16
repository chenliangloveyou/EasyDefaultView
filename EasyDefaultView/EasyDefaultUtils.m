//
//  EasyDefaultUtils.m
//  EasyDefaultViewDemo
//
//  Created by Mr_Chen on 2018/1/7.
//  Copyright © 2018年 chenliangloveyou. All rights reserved.
//

#import "EasyDefaultUtils.h"

@implementation EasyDefaultUtils

+ (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage*theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end

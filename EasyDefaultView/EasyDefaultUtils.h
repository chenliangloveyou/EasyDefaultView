//
//  EasyDefaultUtils.h
//  EasyDefaultViewDemo
//
//  Created by Mr_Chen on 2018/1/7.
//  Copyright © 2018年 chenliangloveyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
// 是否为空
#define ISEMPTY_D(_v) (_v == nil || _v.length == 0)

/*随机颜色*/   //[UIColor clearColor];//
#define kColorRandom_N  [UIColor clearColor];//kColor_N(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
#define kColor_N(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]


@interface EasyDefaultUtils : NSObject

+ (UIImage *)createImageWithColor:(UIColor *)color ;

@end

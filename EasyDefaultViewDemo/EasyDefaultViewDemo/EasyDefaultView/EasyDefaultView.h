//
//  EasyDefaultView.h
//  EasyDefaultViewDemo
//
//  Created by Mr_Chen on 17/9/26.
//  Copyright © 2017年 chenliangloveyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger , defaultViewType) {
    defaultViewTypeDefault ,
    defaultViewTypeLoding ,
    defaultViewTypeNoData ,
    defaultViewTypeNetError ,
};

@interface EasyDefaultView : NSObject

- (void)showDefaultViewWithTitle:(NSString *)title ;
- (void)showDefaultViewWithTitle:(NSString *)title inView:(UIView *)view ;
- (void)showDefaultViewWithTitle:(NSString *)title image:(UIImage *)image ;

@end

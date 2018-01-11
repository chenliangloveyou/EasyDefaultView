//
//  EasyDefaultView.h
//  EasyDefaultViewDemo
//
//  Created by Mr_Chen on 17/9/26.
//  Copyright © 2017年 chenliangloveyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class EasyDefaultView ;

typedef NS_ENUM(NSUInteger , callbackType) {
    callbackTypeBgView ,
    callbackTypeButton_1 ,
    callbackTypeButton_2 ,
};

typedef NS_ENUM(NSUInteger , defaultViewType) {
    defaultViewTypeLoding ,
    defaultViewTypeNoData ,
    defaultViewTypeNetError ,
//    defaultViewTypeCustom ,
};

typedef void (^defaultViewCallback)(EasyDefaultView *view , UIButton *button , callbackType callbackType);

@interface EasyDefaultView : UIScrollView


+ (void)defaultViewWithType:(defaultViewType)type
                     inview:(UIView *)superView
                      title:(NSString *)title ;

+ (void)defaultViewWithType:(defaultViewType)type
                     inview:(UIView *)superView
                      imageName:(NSString *)imageName ;

+ (void)defaultViewWithType:(defaultViewType)type
                     inview:(UIView *)superView
                      title:(NSString *)title
                   subTitle:(NSString *)subTitle ;

+ (void)defaultViewWithType:(defaultViewType)type
                     inview:(UIView *)superView
                      title:(NSString *)title
                   subTitle:(NSString *)subTitle
                  imageName:(NSString *)imageName ;

+ (void)defaultViewWithType:(defaultViewType)type
                     inview:(UIView *)superView
                      title:(NSString *)title
                   subTitle:(NSString *)subTitle
                  imageName:(NSString *)imageName
                   callback:(defaultViewCallback)callback;

+ (void)defaultViewWithType:(defaultViewType)type
                     inview:(UIView *)superView
                      title:(NSString *)title
                   subTitle:(NSString *)subTitle
                  imageName:(NSString *)imageName
           buttonTitleArray:(NSArray *)buttonTitleArray
                   callback:(defaultViewCallback)callback;



+ (void)hiddenInView:(UIView *)superView ;

@end












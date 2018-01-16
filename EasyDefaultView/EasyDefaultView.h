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
    callbackTypeBgView   = 0,
    callbackTypeButton_1 = 1,
    callbackTypeButton_2 = 2,
};

//typedef NS_ENUM(NSUInteger , defaultViewType) {
//    defaultViewTypeLoding ,
//    defaultViewTypeNoData ,
//    defaultViewTypeNetError ,
////    defaultViewTypeCustom ,
//};

typedef void (^defaultViewCallback)(EasyDefaultView *view , UIButton *button , callbackType callbackType);

@interface EasyDefaultView : UIScrollView


+ (instancetype)defaultViewWithDict:(NSDictionary *)dict
                           callback:(defaultViewCallback)callback ;

+ (void)defaultViewWithTitle:(NSString *)title
                      inview:(UIView *)superView;

+ (void)defaultViewWithImageName:(NSString *)imageName
                          inview:(UIView *)superView ;

+ (void)defaultViewWithTitle:(NSString *)title
                   subTitle:(NSString *)subTitle
                      inview:(UIView *)superView  ;

+ (void)defaultViewWithtitle:(NSString *)title
                    subTitle:(NSString *)subTitle
                   imageName:(NSString *)imageName
                      inview:(UIView *)superView;

+ (void)defaultViewWithTitle:(NSString *)title
                   subTitle:(NSString *)subTitle
                  imageName:(NSString *)imageName
                     inview:(UIView *)superView
                   callback:(defaultViewCallback)callback;

+ (void)defaultViewWithTitle:(NSString *)title
                   subTitle:(NSString *)subTitle
                  imageName:(NSString *)imageName
           buttonTitleArray:(NSArray *)buttonTitleArray
                     inview:(UIView *)superView
                   callback:(defaultViewCallback)callback;



+ (void)hiddenInView:(UIView *)superView ;

@end












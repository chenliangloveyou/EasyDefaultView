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

typedef void (^defaultViewTap)(EasyDefaultView *view);
typedef void (^defaultViewButtonClick)(EasyDefaultView *view , UIButton *button);

typedef NS_ENUM(NSUInteger , defaultViewType) {
    defaultViewTypeLoding ,
    defaultViewTypeNoData ,
    defaultViewTypeNetError ,
//    defaultViewTypeCustom ,
};

@interface EasyDefaultView : UIScrollView

+ (void)defaultViewWithType:(defaultViewType)type
                     inView:(UIView *)superView ;

+ (void)defaultViewWithTile:(NSString *)title
                       type:(defaultViewType)type
                     inView:(UIView *)superView ;

+ (void)defaultViewWithType:(defaultViewType)type
                     inView:(UIView *)superView
                tapCallback:(defaultViewTap)tapCallback;

+ (void)defaultViewWithTile:(NSString *)title
                       type:(defaultViewType)type
                     inView:(UIView *)superView
                tapCallback:(defaultViewTap)tapCallback ;

+ (void)defaultViewWithTile:(NSString *)title
                  imageName:(NSString *)imageName
                       type:(defaultViewType)type
                     inView:(UIView *)superView ;

+ (void)defaultViewWithTile:(NSString *)title
                   subTitle:(NSString *)subTitle
                       type:(defaultViewType)type
                     inView:(UIView *)superView ;

+ (void)defaultViewWithTile:(NSString *)title
                   subTitle:(NSString *)subTitle
                  imageName:(NSString *)imageName
                       type:(defaultViewType)type
                     inView:(UIView *)superView ;

+ (void)defaultViewWithTile:(NSString *)title
                   subTitle:(NSString *)subTitle
                  imageName:(NSString *)imageName
                buttonTitle:(NSString *)buttonTitle
                       type:(defaultViewType)type
                     inView:(UIView *)superView
                tapCallback:(defaultViewTap)tapCallback
        buttonClickCallback:(defaultViewButtonClick)buttonClick;


+ (void)defaultViewHiddenInView:(UIView *)superView ;

@end












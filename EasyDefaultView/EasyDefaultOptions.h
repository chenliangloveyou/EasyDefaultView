//
//  EasyDefaultOptions.h
//  EasyDefaultViewDemo
//
//  Created by Mr_Chen on 2018/1/7.
//  Copyright © 2018年 chenliangloveyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#define kSharedEasyDefaultOptions [EasyDefaultOptions sharedEasyDefaultOptions]

@interface EasyDefaultOptions : NSObject

@property (nonatomic,strong)UIFont *titleFount ;
@property (nonatomic,strong)UIColor *titleColor ;

@property (nonatomic,strong)UIFont *subTitleFount ;
@property (nonatomic,strong)UIColor *subTitleColor ;

@property (nonatomic,strong)UIFont *buttonFount ;
@property (nonatomic,strong)UIColor *buttonColor ;
@property (nonatomic,strong)UIColor *buttonBackgroundColor ;
//按钮往内缩的边距（按钮四边边缘距离文字的距离）
@property (nonatomic,assign)UIEdgeInsets buttonEdgeInsets ;

+ (instancetype)sharedEasyDefaultOptions ;

@end

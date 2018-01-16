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


extern NSString *const EasyDefaultTypeKey ;
extern NSString *const EasyDefaultSuperViewKey ; //当EasyShowView消失的时候会发送此通知。
extern NSString *const EasyDefaultTitleKey ;
extern NSString *const EasyDefaultSubTitleKey  ;
extern NSString *const EasyDefaultImageNameKey ;
extern NSString *const EasyDefaultButtonTitleArrayKey ;


@interface EasyDefaultOptions : NSObject

@property (nonatomic,strong)UIColor *defaultViewBgColor ;

@property (nonatomic,strong)UIFont *titleFount ;
@property (nonatomic,strong)UIColor *titleColor ;

@property (nonatomic,strong)UIFont *subTitleFount ;
@property (nonatomic,strong)UIColor *subTitleColor ;

@property (nonatomic,strong)UIFont *buttonFount ;
@property (nonatomic,strong)UIColor *buttonColor ;
@property (nonatomic,strong)UIColor *buttonBackgroundColor ;
//按钮往内缩的边距（按钮四边边缘距离文字的距离）
@property (nonatomic,assign)UIEdgeInsets buttonEdgeInsets ;


#pragma mark - 下面的属性和上面的属性是一样的，这些属性只会一次有效。在设置这些值之后展示完将会清空

@property (nonatomic,strong)UIFont *titleFount_once ;

+ (instancetype)sharedEasyDefaultOptions ;

@end

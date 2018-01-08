//
//  EasyDefaultOptions.h
//  EasyDefaultViewDemo
//
//  Created by Mr_Chen on 2018/1/7.
//  Copyright © 2018年 chenliangloveyou. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kSharedEasyDefaultOptions [EasyDefaultOptions sharedEasyDefaultOptions]

@interface EasyDefaultOptions : NSObject

//@property (nonatomic,strong)

@property (nonatomic,strong)NSString *LodingTitle ;
@property (nonatomic,strong)NSString *lodingSubTitle ;
@property (nonatomic,strong)NSString *lodingImageName ;
@property (nonatomic,strong)NSString *lodingButtonTitle ;

@property (nonatomic,strong)NSString *noDataTitle ;
@property (nonatomic,strong)NSString *noDataSubTitle ;
@property (nonatomic,strong)NSString *noDataImageName ;
@property (nonatomic,strong)NSString *noDataButtonTitle ;

@property (nonatomic,strong)NSString *netErrorTitle ;
@property (nonatomic,strong)NSString *netErrorSubTitle ;
@property (nonatomic,strong)NSString *netErrorImageName ;
@property (nonatomic,strong)NSString *netErrorButtonTitle ;

+ (instancetype)sharedEasyDefaultOptions ;

@end

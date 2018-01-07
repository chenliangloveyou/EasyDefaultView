//
//  EasyDefaultOptions.m
//  EasyDefaultViewDemo
//
//  Created by Mr_Chen on 2018/1/7.
//  Copyright © 2018年 chenliangloveyou. All rights reserved.
//

#import "EasyDefaultOptions.h"

@implementation EasyDefaultOptions


static EasyDefaultOptions *_showInstance;
+ (id)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _showInstance = [super allocWithZone:zone];
    });
    return _showInstance;
}
+ (instancetype)sharedEasyDefaultOptions{
    if (nil == _showInstance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _showInstance = [[[self class] alloc] init];
        });
    }
    return _showInstance;
}
- (id)copyWithZone:(NSZone *)zone{
    return _showInstance;
}
- (id)mutableCopyWithZone:(NSZone *)zone
{
    return _showInstance;
}


- (instancetype)init
{
    if (self = [super init]) {
        
        _noDataTitle = @"无数据";
        _noDataSubTitle = @"您没有血压数据";
        _noDataImageName = @"netError.png";
        _noDataButtonTitle = @"重新加载";
//        @property (nonatomic,strong)NSString *LodingTitle ;
//        @property (nonatomic,strong)NSString *lodingSubTitle ;
//        @property (nonatomic,strong)NSString *lodingImageName ;
//        @property (nonatomic,strong)NSString *lodingButtonTitle ;
//
//        @property (nonatomic,strong)NSString *noDataTitle ;
//        @property (nonatomic,strong)NSString *noDataSubTitle ;
//        @property (nonatomic,strong)NSString *noDataImageName ;
//        @property (nonatomic,strong)NSString *noDataButtonTitle ;
//
//        @property (nonatomic,strong)NSString *netErrorTitle ;
//        @property (nonatomic,strong)NSString *netErrorSubTitle ;
//        @property (nonatomic,strong)NSString *netErrorImageName ;
//        @property (nonatomic,strong)NSString *netErrorButtonTitle ;

        
    }
    return self ;
}
@end






















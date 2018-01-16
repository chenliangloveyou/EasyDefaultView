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
        
        _titleFount = [UIFont systemFontOfSize:18];
        _titleColor = [UIColor blackColor];
        
        _subTitleFount = [UIFont systemFontOfSize:15];
        _subTitleColor = [UIColor lightGrayColor] ;
        
        _buttonFount = [UIFont systemFontOfSize:16];
        _buttonColor = [UIColor darkTextColor];
        _buttonBackgroundColor = [UIColor lightGrayColor];
        _buttonEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    }
    return self ;
}
@end






















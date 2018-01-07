//
//  EasyDefaultView.m
//  EasyDefaultViewDemo
//
//  Created by Mr_Chen on 17/9/26.
//  Copyright © 2017年 chenliangloveyou. All rights reserved.
//

#import "EasyDefaultView.h"
#import "EasyDefaultOptions.h"
#import "EasyDefaultUtils.h"
#import "UIView+EasyShowExt.h"

@interface EasyDefaultView()

@property (nonatomic,strong)NSString *defaultTitle ;
@property (nonatomic,strong)NSString *defaultSubTitle ;
@property (nonatomic,strong)NSString *defaultImageName ;
@property (nonatomic,strong)NSString *defaultButtonTitle ;
@property (nonatomic,assign)defaultViewType defaultType ;

@property (nonatomic,strong)UIScrollView *bgScrollView ;

@property (nonatomic,strong)UILabel *defaultTitleLabel ;
@property (nonatomic,strong)UILabel *defaultSubTitleLabel ;
@property (nonatomic,strong)UIImageView *defaultImageView ;
@property (nonatomic,strong)UIButton *defaultButton ;

@property (nonatomic,strong)defaultViewButtonClick
@property (nonatomic,strong)EasyDefaultOptions *options ;

@end

@implementation EasyDefaultView

+ (void)defaultViewWithType:(defaultViewType)type
                     inView:(UIView *)superView
{
    [self defaultViewWithTile:nil subTitle:nil imageName:nil buttonTitle:nil type:type inView:superView tapCallback:nil buttonClickCallback:nil];
}

+ (void)defaultViewWithTile:(NSString *)title
                       type:(defaultViewType)type
                     inView:(UIView *)superView
{
    [self defaultViewWithTile:title subTitle:nil imageName:nil buttonTitle:nil type:type inView:superView tapCallback:nil buttonClickCallback:nil];
}

+ (void)defaultViewWithType:(defaultViewType)type
                     inView:(UIView *)superView
                tapCallback:(defaultViewTap)tapCallback
{
    [self defaultViewWithTile:nil subTitle:nil imageName:nil buttonTitle:nil type:type inView:superView tapCallback:tapCallback  buttonClickCallback:nil];
}

+ (void)defaultViewWithTile:(NSString *)title
                       type:(defaultViewType)type
                     inView:(UIView *)superView
                tapCallback:(defaultViewTap)tapCallback
{
    [self defaultViewWithTile:title subTitle:nil imageName:nil buttonTitle:nil type:type inView:superView tapCallback:tapCallback buttonClickCallback:nil];
}

+ (void)defaultViewWithTile:(NSString *)title
                  imageName:(NSString *)imageName
                       type:(defaultViewType)type
                     inView:(UIView *)superView
{
    [self defaultViewWithTile:title subTitle:nil imageName:imageName buttonTitle:nil type:type inView:superView tapCallback:nil buttonClickCallback:nil];
}

+ (void)defaultViewWithTile:(NSString *)title
                   subTitle:(NSString *)subTitle
                       type:(defaultViewType)type
                     inView:(UIView *)superView
{
    [self defaultViewWithTile:title subTitle:subTitle imageName:nil buttonTitle:nil type:type inView:superView tapCallback:nil buttonClickCallback:nil];
}

+ (void)defaultViewWithTile:(NSString *)title
                   subTitle:(NSString *)subTitle
                  imageName:(NSString *)imageName
                       type:(defaultViewType)type
                     inView:(UIView *)superView
{
    [self defaultViewWithTile:title subTitle:subTitle imageName:imageName buttonTitle:nil type:type inView:superView tapCallback:nil buttonClickCallback:nil];

}

+ (void)defaultViewWithTile:(NSString *)title
                   subTitle:(NSString *)subTitle
                  imageName:(NSString *)imageName
                buttonTitle:(NSString *)buttonTitle
                       type:(defaultViewType)type
                     inView:(UIView *)superView
                tapCallback:(defaultViewTap)tapCallback
        buttonClickCallback:(defaultViewButtonClick)buttonClick
{
    switch (type) {
        case defaultViewTypeLoding:
        {
            if (ISEMPTY_D(title)) {
                title = kSharedEasyDefaultOptions.LodingTitle ;
            }
            if (ISEMPTY_D(subTitle)) {
                subTitle = kSharedEasyDefaultOptions.lodingSubTitle ;
            }
            if (ISEMPTY_D(imageName)) {
                imageName = kSharedEasyDefaultOptions.lodingImageName ;
            }
            if (ISEMPTY_D(buttonTitle)) {
                buttonTitle = kSharedEasyDefaultOptions.lodingButtonTitle ;
            }
        }break;
        case defaultViewTypeNoData:
        {
            if (ISEMPTY_D(title)) {
                title = kSharedEasyDefaultOptions.noDataTitle ;
            }
            if (ISEMPTY_D(subTitle)) {
                subTitle = kSharedEasyDefaultOptions.noDataSubTitle ;
            }
            if (ISEMPTY_D(imageName)) {
                imageName = kSharedEasyDefaultOptions.noDataImageName ;
            }
            if (ISEMPTY_D(buttonTitle)) {
                buttonTitle = kSharedEasyDefaultOptions.noDataButtonTitle ;
            }
        }break ;
        case defaultViewTypeNetError:
        {
            if (ISEMPTY_D(title)) {
                title = kSharedEasyDefaultOptions.netErrorTitle ;
            }
            if (ISEMPTY_D(subTitle)) {
                subTitle = kSharedEasyDefaultOptions.netErrorSubTitle ;
            }
            if (ISEMPTY_D(imageName)) {
                imageName = kSharedEasyDefaultOptions.netErrorImageName ;
            }
            if (ISEMPTY_D(buttonTitle)) {
                buttonTitle = kSharedEasyDefaultOptions.netErrorButtonTitle ;
            }
        }break ;
        default:
            break;
    }
    
    EasyDefaultView *defaultView = [[EasyDefaultView alloc]init];
    defaultView.defaultTitle = title ;
    defaultView.defaultSubTitle = subTitle ;
    defaultView.defaultImageName = imageName ;
    defaultView.defaultButtonTitle = buttonTitle ;
    defaultView.defaultType = type ;
    [defaultView showViewWithSuperView:superView];

}
+ (void)defaultViewHiddenInView:(UIView *)superView
{
    NSEnumerator *subviewsEnum = [superView.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:self]) {
//            EasyDefaultView *defaultView = (EasyDefaultView *)subview ;
            
            NSAssert([NSThread isMainThread], @"needs to be accessed on the main thread.");
            
            if (![NSThread isMainThread]) {
                dispatch_async(dispatch_get_main_queue(), ^(void) {
                });
            }
            
            [subview.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [subview removeFromSuperview];
        }
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blueColor] ;
        [self addSubview:self.bgScrollView];
    }
    return self ;
}

- (void)showViewWithSuperView:(UIView *)superView
{
    self.frame = CGRectMake(0, 0, superView.frame.size.width, superView.frame.size.height) ;
    
    
    [self.bgScrollView addSubview:self.defaultImageView];
    UIImage *defaultImage = [UIImage imageNamed:self.defaultImageName];
    self.defaultImageView.image = defaultImage ;
    self.defaultImageView.frame = CGRectMake((self.width-defaultImage.size.width)/2, 10, defaultImage.size.width, defaultImage.size.height) ;
    
    [self.bgScrollView addSubview:self.defaultTitleLabel];
    self.defaultTitleLabel.text = self.defaultTitle ;
    self.defaultTitleLabel.frame = CGRectMake(0, self.defaultImageView.bottom+20, superView.frame.size.width, 30);
    
    [self.bgScrollView addSubview:self.defaultSubTitleLabel];
    self.defaultSubTitleLabel.text = self.defaultSubTitle ;
    self.defaultSubTitleLabel.frame = CGRectMake(0, self.defaultTitleLabel.bottom, superView.width, 50) ;
    
    [self.bgScrollView addSubview:self.defaultButton];
    [self.defaultButton setTitle:self.defaultButtonTitle forState:UIControlStateNormal];
    [self.defaultButton setFrame:CGRectMake((self.width-100)/2, self.defaultSubTitleLabel.bottom+20, 100, 40)];
    
    [superView addSubview:self];
}
- (void)defaultButtonClick
{
    
}
- (UIScrollView *)bgScrollView
{
    if (nil == _bgScrollView) {
        _bgScrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _bgScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight ;
        _bgScrollView.backgroundColor = [UIColor purpleColor];
        _bgScrollView.alwaysBounceVertical = YES ;
    }
    return _bgScrollView ;
}
- (UIButton *)defaultButton
{
    if (nil == _defaultButton) {
        _defaultButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_defaultButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_defaultButton setBackgroundColor:[UIColor blackColor]];
        [_defaultButton addTarget:self action:@selector(defaultButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _defaultButton ;
}
- (UIImageView *)defaultImageView
{
    if (nil == _defaultImageView) {
        _defaultImageView = [[UIImageView alloc]init];
        _defaultImageView.backgroundColor = [UIColor lightGrayColor];
    }
    return _defaultImageView ;
}
- (UILabel *)defaultSubTitleLabel
{
    if (nil == _defaultSubTitleLabel) {
        _defaultSubTitleLabel = [[UILabel alloc]init];
        _defaultSubTitleLabel.textColor = [UIColor grayColor];
        _defaultSubTitleLabel.textAlignment = NSTextAlignmentCenter ;
    }
    return _defaultSubTitleLabel ;
}
- (UILabel *)defaultTitleLabel
{
    if (nil == _defaultTitleLabel) {
        _defaultTitleLabel = [[UILabel alloc]init];
        _defaultTitleLabel.textColor = [UIColor blackColor];
        _defaultTitleLabel.textAlignment = NSTextAlignmentCenter ;
    }
    return _defaultTitleLabel ;
}
- (EasyDefaultOptions *)options
{
    if (nil == _options) {
        _options = [EasyDefaultOptions sharedEasyDefaultOptions];
    }
    return _options ;
}

@end

























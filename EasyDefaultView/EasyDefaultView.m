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
#import "EasyShowLabel.h"
#import "UIView+EasyShowExt.h"

@interface EasyDefaultView()

@property (nonatomic,strong)NSString *defaultTitle ;
@property (nonatomic,strong)NSString *defaultSubTitle ;
@property (nonatomic,strong)NSString *defaultImageName ;
@property (nonatomic,strong)NSString *defaultButtonTitle ;
@property (nonatomic,assign)defaultViewType defaultType ;

@property (nonatomic,strong)UIView *bgContentView ;
@property (nonatomic,strong)UILabel *defaultTitleLabel ;
@property (nonatomic,strong)UILabel *defaultSubTitleLabel ;
@property (nonatomic,strong)UIImageView *defaultImageView ;
@property (nonatomic,strong)UIButton *defaultButton ;

@property (nonatomic,strong)defaultViewTap defaultViewTap ;
@property (nonatomic,strong)defaultViewButtonClick defaultViewButtonClick ;

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
    defaultView.defaultViewTap = tapCallback ;
    defaultView.defaultViewButtonClick = buttonClick ;
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
            
            [UIView animateWithDuration:.3 animations:^{
                subview.alpha = 0.2 ;
            } completion:^(BOOL finished) {
                [subview removeFromSuperview];
            }] ;
        }
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight ;
//        self.backgroundColor = [UIColor purpleColor];
        self.alwaysBounceVertical = YES ;
    }
    return self ;
}
- (void)bgContentViewTap
{
    if (self.defaultViewTap) {
        self.defaultViewTap(self);
    }
}
- (void)showViewWithSuperView:(UIView *)superView
{
    
    if (self.defaultViewTap) {
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bgContentViewTap)];
        [self addGestureRecognizer:tapGesture];
    }
   
    self.frame = CGRectMake(0, 0, superView.width, superView.height) ;
    
    [self addSubview:self.bgContentView];

   
    CGFloat contentWidth = superView.width*0.7 ;//计算bgcontentview的宽度
    if (contentWidth < 200) {    //如果superview的宽度小于200 就应该是全部宽度
        contentWidth = superView.width ;
    }
    CGFloat contentHeight = 0 ;//计算bgcontentview的高度
    if (!ISEMPTY_D(self.defaultImageName)) {
        UIImage *defaultImage = [UIImage imageNamed:self.defaultImageName];
        self.defaultImageView.image = defaultImage ;
        self.defaultImageView.frame = CGRectMake((contentWidth-defaultImage.size.width)/2, contentHeight, defaultImage.size.width, defaultImage.size.height) ;
        contentHeight += defaultImage.size.height ;
    }
   
    if (!ISEMPTY_D(self.defaultTitle)) {
        self.defaultTitleLabel.text = self.defaultTitle ;
        
        CGSize titleLabelSize = [self.defaultTitleLabel sizeThatFits:CGSizeMake(contentWidth, MAXFLOAT)];
        self.defaultTitleLabel.frame = CGRectMake(0, contentHeight, contentWidth, titleLabelSize.height);

        contentHeight += self.defaultTitleLabel.height ;
    }
    
    if (!ISEMPTY_D(self.defaultSubTitle)) {
        self.defaultSubTitleLabel.text = self.defaultSubTitle ;
        
        CGSize titleLabelSize = [self.defaultSubTitleLabel sizeThatFits:CGSizeMake(contentWidth, MAXFLOAT)];
        self.defaultSubTitleLabel.frame = CGRectMake(0, contentHeight, contentWidth, titleLabelSize.height);
        
        contentHeight += self.defaultSubTitleLabel.height ;

    }
    
    if (!ISEMPTY_D(self.defaultButtonTitle)) {
        [self.defaultButton setTitle:self.defaultButtonTitle forState:UIControlStateNormal];
        [self.defaultButton setFrame:CGRectMake((contentWidth-100)/2, contentHeight, 100, 40)];
  
        contentHeight += self.defaultButton.height ;

    }
   
    self.bgContentView.frame = CGRectMake((superView.width-contentWidth)/2, (self.height-contentHeight)/2, contentWidth, contentHeight) ;

    [superView addSubview:self];
    self.alpha = 0.2 ;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1 ;
    }] ;
    
}
- (void)defaultButtonClick
{
    
}

- (UIView *)bgContentView
{
    if (nil == _bgContentView) {
        _bgContentView = [[UIView alloc]init];
        _bgContentView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight ;
//        _bgContentView.backgroundColor = [UIColor blueColor];
        
        [_bgContentView addSubview:self.defaultImageView];
        [_bgContentView addSubview:self.defaultTitleLabel];
        [_bgContentView addSubview:self.defaultSubTitleLabel];
        [_bgContentView addSubview:self.defaultButton];
    }
    return _bgContentView ;
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
//        _defaultImageView.backgroundColor = [UIColor lightGrayColor];
    }
    return _defaultImageView ;
}
- (UILabel *)defaultSubTitleLabel
{
    if (nil == _defaultSubTitleLabel) {
        _defaultSubTitleLabel =  [[EasyShowLabel alloc] initWithContentInset:UIEdgeInsetsMake(15, 0, 15, 0)];
        _defaultSubTitleLabel.textColor = [UIColor grayColor];
        _defaultSubTitleLabel.numberOfLines = 0 ;
        _defaultSubTitleLabel.textAlignment = NSTextAlignmentCenter ;
    }
    return _defaultSubTitleLabel ;
}
- (UILabel *)defaultTitleLabel
{
    if (nil == _defaultTitleLabel) {
        _defaultTitleLabel = [[EasyShowLabel alloc] initWithContentInset:UIEdgeInsetsMake(15, 0, 15, 0)];;
        _defaultTitleLabel.textColor = [UIColor blackColor];
        _defaultTitleLabel.numberOfLines = 0 ;
//        _defaultTitleLabel.backgroundColor = [UIColor blueColor];
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

























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

@property (nonatomic,strong)NSString *title ;
@property (nonatomic,strong)NSString *subTitle ;
@property (nonatomic,strong)NSString *imageName ;
@property (nonatomic,strong)NSArray *buttonTitleArray ;
@property (nonatomic,strong)defaultViewCallback callback ;

@property (nonatomic,strong)UIView *bgContentView ;
@property (nonatomic,strong)UILabel *defaultTitleLabel ;
@property (nonatomic,strong)UILabel *defaultSubTitleLabel ;
@property (nonatomic,strong)UIImageView *defaultImageView ;

@property (nonatomic,strong)EasyDefaultOptions *options ;

@end

@implementation EasyDefaultView

+ (instancetype)defaultViewWithDict:(NSDictionary *)dict callback:(defaultViewCallback)callback
{
    UIView *superView = [dict objectForKey:EasyDefaultSuperViewKey];
    NSString *title = [dict objectForKey:EasyDefaultTitleKey];
    NSString *subTitle = [dict objectForKey:EasyDefaultSubTitleKey] ;
    NSString *imageName= [dict objectForKey:EasyDefaultImageNameKey];
    NSArray *buttonArray = [dict objectForKey:EasyDefaultButtonTitleArrayKey];
    [self defaultViewWithTitle:title subTitle:subTitle imageName:imageName buttonTitleArray:buttonArray inview:superView callback:callback];
    
    return nil ;
}
+ (void)defaultViewWithTitle:(NSString *)title
                      inview:(UIView *)superView
{
    [self defaultViewWithTitle:title subTitle:nil imageName:nil buttonTitleArray:nil inview:superView callback:nil];
}

+ (void)defaultViewWithImageName:(NSString *)imageName
                          inview:(UIView *)superView
{
    [self defaultViewWithTitle:nil subTitle:nil imageName:imageName buttonTitleArray:nil inview:superView callback:nil];
}

+ (void)defaultViewWithTitle:(NSString *)title
                    subTitle:(NSString *)subTitle
                      inview:(UIView *)superView
{
    [self defaultViewWithTitle:title subTitle:subTitle imageName:nil buttonTitleArray:nil inview:superView callback:nil];
}

+ (void)defaultViewWithtitle:(NSString *)title
                    subTitle:(NSString *)subTitle
                   imageName:(NSString *)imageName
                      inview:(UIView *)superView
{
    [self defaultViewWithTitle:title subTitle:subTitle imageName:imageName buttonTitleArray:nil inview:superView callback:nil];
}

+ (void)defaultViewWithTitle:(NSString *)title
                    subTitle:(NSString *)subTitle
                   imageName:(NSString *)imageName
                      inview:(UIView *)superView
                    callback:(defaultViewCallback)callback
{
    [self defaultViewWithTitle:title subTitle:subTitle imageName:imageName buttonTitleArray:nil inview:superView callback:callback];
}
+ (void)defaultViewWithTitle:(NSString *)title
                    subTitle:(NSString *)subTitle
                   imageName:(NSString *)imageName
            buttonTitleArray:(NSArray *)buttonTitleArray
                      inview:(UIView *)superView
                    callback:(defaultViewCallback)callback
{
    NSAssert(buttonTitleArray.count<3, @"you can't set more than two button") ;
    
    EasyDefaultView *defaultView = [[EasyDefaultView alloc]init];
    defaultView.title = title ;
    defaultView.subTitle  = subTitle ;
    defaultView.imageName = imageName ;
    defaultView.buttonTitleArray = buttonTitleArray ;
    defaultView.callback = callback ;
    [superView addSubview:defaultView];
    
    [defaultView showView];
}

+ (void)hiddenInView:(UIView *)superView
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

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]  removeObserver:self name:UIApplicationWillChangeStatusBarFrameNotification object:nil];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight ;
        self.backgroundColor = self.options.defaultViewBgColor ;
        self.alwaysBounceVertical = YES ;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarChangeNoti:) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
    }
    return self ;
}
- (void)statusBarChangeNoti:(NSNotification *)notifycation
{
    [self layoutDefaultViewSubviews];
}
- (void)buttonClick:(UIButton *)button
{
    [EasyDefaultView hiddenInView:self.superview];

    if (self.callback) {
        if ([button isKindOfClass:[UIButton class]]) {
            self.callback(self, button, button.tag) ;
            return ;
        }
        self.callback(self, nil, callbackTypeBgView);
    }
}


- (void)layoutDefaultViewSubviews
{
    [self setFrame:CGRectMake(0, 0, self.superview.width, self.superview.height)] ;
    
    CGFloat contentWidth = [self bgViewWidth];//bgcontentview的高度
    __block CGFloat contentHeight = 0 ;//计算bgcontentview的高度
    if (!ISEMPTY_D(self.imageName)) {
        UIImage *defaultImage = [UIImage imageNamed:self.imageName];
        CGSize imageSize = defaultImage.size ;
        if (imageSize.width > contentWidth/2.0f) {
            imageSize.width=  contentWidth/2.0f ;
            imageSize.height = (imageSize.height*contentWidth/2.0f)/imageSize.width ;
        }
        self.defaultImageView.frame = CGRectMake((contentWidth-imageSize.width)/2.0f, contentHeight, imageSize.width, imageSize.height) ;
        contentHeight += imageSize.height+10 ;
    }
    
    if (!ISEMPTY_D(self.title)) {
        CGSize titleSize = [self.defaultTitleLabel sizeThatFits:CGSizeMake(contentWidth, MAXFLOAT)];
        self.defaultTitleLabel.frame = CGRectMake(0, contentHeight, contentWidth, titleSize.height);
        
        contentHeight += self.defaultTitleLabel.height ;
    }
    
    if (!ISEMPTY_D(self.subTitle)) {
        CGSize titleSize = [self.defaultSubTitleLabel sizeThatFits:CGSizeMake(contentWidth, MAXFLOAT)];
        self.defaultSubTitleLabel.frame = CGRectMake(0, contentHeight, contentWidth, titleSize.height);
        
        contentHeight += self.defaultSubTitleLabel.height ;
        
    }
    
    __weak typeof(NSArray *) weakButtonArray = self.buttonTitleArray ;
    [self.bgContentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIButton class]]) {
            CGRect buttonFrame = obj.frame ;
            buttonFrame.origin.y = contentHeight+10 ;
            
            CGFloat buttonX = (contentWidth-obj.width)/2;
            if (weakButtonArray.count == 2) {
                buttonX = (contentWidth/2-obj.width)/2 + ((obj.tag==2)?(contentWidth/2):0)  ;
            }
            buttonFrame.origin.x =buttonX ;
            [obj setFrame:buttonFrame];
            
            if (weakButtonArray.count==1 || (weakButtonArray.count==2&&obj.tag==2)) {
                contentHeight += buttonFrame.size.height+10 ;
            }

        }
    }] ;
    
    self.bgContentView.frame = CGRectMake((self.superview.width-contentWidth)/2, (self.superview.height-contentHeight)/2, contentWidth, contentHeight) ;
    
}
- (void)showView
{
    
    if (self.callback) {
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(buttonClick:)];
        [self addGestureRecognizer:tapGesture];
    }
    [self addSubview:self.bgContentView];

    if (!ISEMPTY_D(self.imageName)) {
        self.defaultImageView.image = [UIImage imageNamed:self.imageName] ;
    }
   
    if (!ISEMPTY_D(self.title)) {
        self.defaultTitleLabel.text = self.title ;
    }
    
    if (!ISEMPTY_D(self.subTitle)) {
        self.defaultSubTitleLabel.text = self.subTitle ;
    }
    
    for (int i = 0 ; i < self.buttonTitleArray.count; i++) {
        UIButton *button = [self defaultButtonWithIndex:i contentWidth:[self bgViewWidth]] ;
        [self.bgContentView addSubview:button];
    }
    
    [self layoutDefaultViewSubviews];

    self.alpha = 0.2 ;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1 ;
    }] ;
    
}

- (CGFloat)bgViewWidth
{
    CGFloat contentWidth = self.superview.width*0.7 ;//计算bgcontentview的宽度
    if (contentWidth < 200) {    //如果superview的宽度小于200 就应该是全部宽度
        contentWidth = self.superview.width ;
    }
    return contentWidth ;
}

- (UIButton *)defaultButtonWithIndex:(long)index contentWidth:(CGFloat)contentWidth
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:self.options.buttonColor forState:UIControlStateNormal];
    [button setTitleColor:[self.options.buttonColor colorWithAlphaComponent:0.5f] forState:UIControlStateHighlighted];
    [button setBackgroundImage:[EasyDefaultUtils createImageWithColor:self.options.buttonBackgroundColor] forState:UIControlStateNormal];
    [button setBackgroundImage:[EasyDefaultUtils createImageWithColor:[self.options.buttonBackgroundColor colorWithAlphaComponent:0.5f]]  forState:UIControlStateHighlighted];
    button.titleLabel.numberOfLines = 0 ;
    [button setTitleEdgeInsets:self.options.buttonEdgeInsets];
    button.titleLabel.font = self.options.buttonFount ;
    [button setTag:index+1];
    
    NSString *titleString = self.buttonTitleArray[index];
    CGFloat buttonMaxWidth = contentWidth/self.buttonTitleArray.count - self.options.buttonEdgeInsets.left - self.options.buttonEdgeInsets.right ;
    NSMutableAttributedString *astr = [[NSMutableAttributedString alloc] initWithString:titleString attributes:nil];
    [astr setAttributes:@{NSFontAttributeName:button.titleLabel.font} range:NSMakeRange(0, titleString.length)];
    CGSize buttonSize = [astr boundingRectWithSize:CGSizeMake(buttonMaxWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil].size;
    buttonSize = CGSizeMake(buttonSize.width+self.options.buttonEdgeInsets.left + self.options.buttonEdgeInsets.right, buttonSize.height+self.options.buttonEdgeInsets.top+self.options.buttonEdgeInsets.bottom) ;
    [button setFrame:CGRectMake(0, 0, buttonSize.width, buttonSize.height)];
    [button  setRoundedCorners:4];

    [button setTitle:titleString forState:UIControlStateNormal];
    
    return button ;
}
- (UIView *)bgContentView
{
    if (nil == _bgContentView) {
        _bgContentView = [[UIView alloc]init];
        _bgContentView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight ;
        _bgContentView.backgroundColor = kColorRandom_N ;
    }
    return _bgContentView ;
}

- (UIImageView *)defaultImageView
{
    if (nil == _defaultImageView) {
        _defaultImageView = [[UIImageView alloc]init];
        _defaultImageView.backgroundColor = kColorRandom_N ;
        [self.bgContentView addSubview:_defaultImageView];
    }
    return _defaultImageView ;
}
- (UILabel *)defaultSubTitleLabel
{
    if (nil == _defaultSubTitleLabel) {
        _defaultSubTitleLabel =  [[EasyShowLabel alloc] initWithContentInset:UIEdgeInsetsMake(10, 20, 10, 20)];
        _defaultSubTitleLabel.textColor = self.options.subTitleColor ;
        _defaultSubTitleLabel.font = self.options.subTitleFount ;
        _defaultSubTitleLabel.numberOfLines = 0 ;
        _defaultSubTitleLabel.textAlignment = NSTextAlignmentCenter ;
        _defaultSubTitleLabel.backgroundColor = kColorRandom_N ;
        [self.bgContentView addSubview:_defaultSubTitleLabel];
    }
    return _defaultSubTitleLabel ;
}
- (UILabel *)defaultTitleLabel
{
    if (nil == _defaultTitleLabel) {
        _defaultTitleLabel = [[EasyShowLabel alloc] initWithContentInset:UIEdgeInsetsMake(10, 30, 10, 30)];;
        _defaultTitleLabel.textColor = self.options.titleColor ;
        _defaultTitleLabel.font = self.options.titleFount ;
        _defaultTitleLabel.numberOfLines = 0 ;
        _defaultTitleLabel.backgroundColor = kColorRandom_N ;
        _defaultTitleLabel.textAlignment = NSTextAlignmentCenter ;
        [self.bgContentView addSubview:_defaultTitleLabel];
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

























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
    EasyDefaultView *defaultView = [[EasyDefaultView alloc]init];
    defaultView.title = [dict objectForKey:@"title"] ;
    defaultViewType type = [[dict objectForKey:@"type"] integerValue];
    return defaultView ;
}
+ (void)defaultViewWithType:(defaultViewType)type
                     inview:(UIView *)superView
                      title:(NSString *)title
{
    [self defaultViewWithType:type inview:superView title:title subTitle:nil imageName:nil buttonTitleArray:nil callback:nil];
}

+ (void)defaultViewWithType:(defaultViewType)type
                     inview:(UIView *)superView
                  imageName:(NSString *)imageName
{
    [self defaultViewWithType:type inview:superView title:nil subTitle:nil imageName:imageName buttonTitleArray:nil callback:nil];
}

+ (void)defaultViewWithType:(defaultViewType)type
                     inview:(UIView *)superView
                      title:(NSString *)title
                   subTitle:(NSString *)subTitle
{
    [self defaultViewWithType:type inview:superView title:title subTitle:subTitle imageName:nil buttonTitleArray:nil callback:nil];
}


+ (void)defaultViewWithType:(defaultViewType)type
                     inview:(UIView *)superView
                      title:(NSString *)title
                   subTitle:(NSString *)subTitle
                  imageName:(NSString *)imageName
{
    [self defaultViewWithType:type inview:superView title:title subTitle:subTitle imageName:imageName buttonTitleArray:nil callback:nil];
}


+ (void)defaultViewWithType:(defaultViewType)type
                     inview:(UIView *)superView
                      title:(NSString *)title
                   subTitle:(NSString *)subTitle
                  imageName:(NSString *)imageName
                   callback:(defaultViewCallback)callback
{
    [self defaultViewWithType:type
                       inview:superView
                        title:title
                     subTitle:subTitle
                    imageName:imageName
             buttonTitleArray:nil
                     callback:callback];
}


+ (void)defaultViewWithType:(defaultViewType)type
                     inview:(UIView *)superView
                      title:(NSString *)title
                   subTitle:(NSString *)subTitle
                  imageName:(NSString *)imageName
           buttonTitleArray:(NSArray *)buttonTitleArray
                   callback:(defaultViewCallback)callback
{
    
    NSAssert(buttonTitleArray.count<3, @"you can't set more than two button") ;
    
    EasyDefaultView *defaultView = [[EasyDefaultView alloc]init];
    defaultView.title = title ;
    defaultView.subTitle  = subTitle ;
    defaultView.imageName = imageName ;
    defaultView.buttonTitleArray = buttonTitleArray ;
    defaultView.callback = callback ;
    [defaultView showViewWithSuperView:superView type:type];

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

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight ;
        self.backgroundColor = [UIColor purpleColor];
        self.alwaysBounceVertical = YES ;
    }
    return self ;
}

- (void)buttonClick:(UIButton *)button
{
    if (self.callback) {
        if ([button isKindOfClass:[UIButton class]]) {
            self.callback(self, button, button.tag) ;
            return ;
        }
        self.callback(self, nil, callbackTypeBgView);
    }
}
- (void)showViewWithSuperView:(UIView *)superView type:(defaultViewType)type
{
    
    if (self.callback) {
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(buttonClick:)];
        [self addGestureRecognizer:tapGesture];
    }
   
    [self setFrame:CGRectMake(0, 0, superView.width, superView.height)] ;
    
    [self addSubview:self.bgContentView];

    CGFloat contentWidth = superView.width*0.7 ;//计算bgcontentview的宽度
    if (contentWidth < 200) {    //如果superview的宽度小于200 就应该是全部宽度
        contentWidth = superView.width ;
    }
    CGFloat contentHeight = 0 ;//计算bgcontentview的高度
    if (!ISEMPTY_D(self.imageName)) {
        UIImage *defaultImage = [UIImage imageNamed:self.imageName];
        CGSize imageSize = defaultImage.size ;
        if (imageSize.width > contentWidth/2.0f) {
            imageSize.width=  contentWidth/2.0f ;
            imageSize.height = (imageSize.height*contentWidth/2.0f)/imageSize.width ;
        }
        self.defaultImageView.image = defaultImage ;
        self.defaultImageView.frame = CGRectMake((contentWidth-imageSize.width)/2.0f, contentHeight, imageSize.width, imageSize.height) ;
        contentHeight += imageSize.height+10 ;
    }
   
    if (!ISEMPTY_D(self.title)) {
        self.defaultTitleLabel.text = self.title ;
        
        CGSize titleSize = [self.defaultTitleLabel sizeThatFits:CGSizeMake(contentWidth, MAXFLOAT)];
        self.defaultTitleLabel.frame = CGRectMake(0, contentHeight, contentWidth, titleSize.height);

        contentHeight += self.defaultTitleLabel.height ;
    }
    
    if (!ISEMPTY_D(self.subTitle)) {
        self.defaultSubTitleLabel.text = self.subTitle ;
        
        CGSize titleSize = [self.defaultSubTitleLabel sizeThatFits:CGSizeMake(contentWidth, MAXFLOAT)];
        self.defaultSubTitleLabel.frame = CGRectMake(0, contentHeight, contentWidth, titleSize.height);
        
        contentHeight += self.defaultSubTitleLabel.height ;

    }
    
    for (int i = 0 ; i < self.buttonTitleArray.count; i++) {
      
        UIButton *button = [self defaultButtonWithIndex:i contentWidth:contentWidth] ;
        CGRect buttonFrame = button.frame ;
        buttonFrame.origin.y = contentHeight+10 ;
        [button setFrame:buttonFrame];
        [button  setRoundedCorners:4];
        [self.bgContentView addSubview:button];
        
        if (i==self.buttonTitleArray.count-1) contentHeight += buttonFrame.size.height+10 ;
    }
    
    self.bgContentView.frame = CGRectMake((superView.width-contentWidth)/2, (superView.height-contentHeight)/2, contentWidth, contentHeight) ;

    [superView addSubview:self];
    self.alpha = 0.2 ;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1 ;
    }] ;
    
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

    [button setTag:index+1];
    
    NSString *titleString = self.buttonTitleArray[index];
    CGFloat buttonMaxWidth = contentWidth/self.buttonTitleArray.count - self.options.buttonEdgeInsets.left - self.options.buttonEdgeInsets.right ;
    NSMutableAttributedString *astr = [[NSMutableAttributedString alloc] initWithString:titleString attributes:nil];
    [astr setAttributes:@{NSFontAttributeName:button.titleLabel.font} range:NSMakeRange(0, titleString.length)];
    CGSize buttonSize = [astr boundingRectWithSize:CGSizeMake(buttonMaxWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil].size;
    buttonSize = CGSizeMake(buttonSize.width+self.options.buttonEdgeInsets.left + self.options.buttonEdgeInsets.right, buttonSize.height+self.options.buttonEdgeInsets.top+self.options.buttonEdgeInsets.bottom) ;
    CGFloat buttonX = (contentWidth-buttonSize.width)/2;
    if (self.buttonTitleArray.count == 2) {
        buttonX = (contentWidth/2-buttonSize.width)/2 + (index?(contentWidth/2):0)  ;
    }
    [button setFrame:CGRectMake(buttonX, 0, buttonSize.width, buttonSize.height)];

    [button setTitle:titleString forState:UIControlStateNormal];
    
    return button ;
}
- (UIView *)bgContentView
{
    if (nil == _bgContentView) {
        _bgContentView = [[UIView alloc]init];
        _bgContentView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight ;
        _bgContentView.backgroundColor = kColorRandom_N ;
        
        [_bgContentView addSubview:self.defaultImageView];
        [_bgContentView addSubview:self.defaultTitleLabel];
        [_bgContentView addSubview:self.defaultSubTitleLabel];
    }
    return _bgContentView ;
}

- (UIImageView *)defaultImageView
{
    if (nil == _defaultImageView) {
        _defaultImageView = [[UIImageView alloc]init];
        _defaultImageView.backgroundColor = kColorRandom_N ;
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

























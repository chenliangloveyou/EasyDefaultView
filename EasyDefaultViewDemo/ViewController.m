//
//  ViewController.m
//  EasyDefaultViewDemo
//
//  Created by Mr_Chen on 17/9/26.
//  Copyright © 2017年 chenliangloveyou. All rights reserved.
//

#import "ViewController.h"

#import "EasyDefault.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *redView = [[UIView alloc]initWithFrame:CGRectMake(50, 100, 300, 300)];
    redView.backgroundColor = [UIColor redColor ];
    [self.view addSubview:redView];
    [EasyDefaultView defaultViewWithType:defaultViewTypeNoData
                                  inview:redView
                                   title:@"无数据"
                                subTitle:@"点击刷新，重新获取数据..."
                               imageName:@"netError.png"
                                callback:^(EasyDefaultView *view, UIButton *button, callbackType callbackType) {
                                    [EasyDefaultView hiddenInView:redView];
                                }];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bgContentViewTap)];
    [self.view addGestureRecognizer:tapGesture];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)bgContentViewTap
{
    [EasyDefaultView defaultViewWithType:defaultViewTypeNetError inview:self.view title:@"网络错误" subTitle:@"请检查网络是否连接正常" imageName:@"noNetFlags.png" buttonTitleArray:@[@"回主页"] callback:^(EasyDefaultView *view, UIButton *button, callbackType callbackType) {
        [EasyDefaultView hiddenInView:self.view];
    }];
 
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

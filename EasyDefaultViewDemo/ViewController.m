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
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:7];
    [dict setObject:redView forKey:EasyDefaultSuperViewKey];
    [dict setObject:@"无数据" forKey:EasyDefaultTitleKey];
    [dict setObject:@"点击刷新，从新加载将会为您找你赶紧啊打开房间" forKey:EasyDefaultSubTitleKey];
    [dict setObject:@"netError.png" forKey:EasyDefaultImageNameKey];
    [dict setObject:@[@"回主页发链接"] forKey:EasyDefaultButtonTitleArrayKey ];
    [EasyDefaultView defaultViewWithDict:dict callback:^(EasyDefaultView *view, UIButton *button, callbackType callbackType) {
//            [EasyDefaultView hiddenInView:redView];
    }];
//    [EasyDefaultView defaultViewWithType:defaultViewTypeNoData
//                                  inview:redView
//                                   title:@"无数据"
//                                subTitle:@"点击刷新，重新获取数据，将会为您重新加载!"
//                               imageName:@"netError.png"
//                        buttonTitleArray:@[@"回主页发链接"]
//                                callback:^(EasyDefaultView *view, UIButton *button, callbackType callbackType) {
//                                    [EasyDefaultView hiddenInView:redView];
//                                }];
//
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bgContentViewTap)];
    [self.view addGestureRecognizer:tapGesture];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)bgContentViewTap
{
    [EasyDefaultView defaultViewWithTitle:@"网络错误" subTitle:@"请检查网络是否连接正常,点击重新刷新！" imageName:@"noNetFlags.png" buttonTitleArray:@[@"回主页",@"再次加载"] inview:self.view callback:^(EasyDefaultView *view, UIButton *button, callbackType callbackType) {
        
    }];
 
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

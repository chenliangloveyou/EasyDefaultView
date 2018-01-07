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
    [EasyDefaultView defaultViewWithType:defaultViewTypeNoData inView:redView tapCallback:^(EasyDefaultView *view) {
        [view removeFromSuperview];
    }];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

//
//  SecondViewController.m
//  TestDemo
//
//  Created by xiazhengcheng on 2023/4/2.
//  Copyright © 2023 etlfab. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType: UIButtonTypeSystem];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor yellowColor];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *blockButton = [UIButton buttonWithType: UIButtonTypeSystem];
    [blockButton setTitle:@"block返回" forState:UIControlStateNormal];
    blockButton.backgroundColor = [UIColor yellowColor];
    [blockButton addTarget:self action:@selector(blockBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:blockButton];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(100);
        make.center.equalTo(self.view);
    }];
    
    [blockButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(100);
        make.top.equalTo(button.mas_bottom).offset(50);
        make.centerX.equalTo(self.view);
    }];
}

- (void)back {
    if(_delegate && [_delegate respondsToSelector:@selector(passMessage:)]) {
        [_delegate passMessage:@"true"];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)blockBack {
    self.blockMessage(@"true");
    [self.navigationController popViewControllerAnimated:YES];

}

@end

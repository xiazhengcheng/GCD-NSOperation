//
//  FirstViewController.m
//  TestDemo
//
//  Created by xiazhengcheng on 2023/4/2.
//  Copyright © 2023 etlfab. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"


@interface FirstViewController ()<PassMessageDelegate>

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType: UIButtonTypeSystem];
    [button setTitle:@"delegate跳转" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor yellowColor];
    [button addTarget:self action:@selector(jump) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *blockbutton = [UIButton buttonWithType: UIButtonTypeSystem];
    [blockbutton setTitle:@"block跳转" forState:UIControlStateNormal];
    blockbutton.backgroundColor = [UIColor yellowColor];
    [blockbutton addTarget:self action:@selector(blockJump) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:blockbutton];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(100);
        make.center.equalTo(self.view);
    }];
    [blockbutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(100);
        make.top.mas_equalTo(button.mas_bottom).offset(50);
        make.centerX.equalTo(self.view);
    }];
}

- (void)blockJump {
    SecondViewController *svc = [[SecondViewController alloc] init];
    svc.blockMessage = ^(NSString * _Nonnull message) {
        if ([message isEqualToString:@"true"]) {
            self.view.backgroundColor = [UIColor systemPinkColor];

        }
    };
    [self.navigationController pushViewController:svc animated:YES];
}

- (void) jump {
    SecondViewController *svc = [[SecondViewController alloc] init];
    svc.delegate = self;
    [self.navigationController pushViewController:svc animated:YES];
}

- (void)passMessage:(NSString *)message {
    if([message isEqualToString:@"true"]) {
        self.view.backgroundColor = [UIColor systemPinkColor];
    }
}

@end

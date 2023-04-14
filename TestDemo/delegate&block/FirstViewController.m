//
//  FirstViewController.m
//  TestDemo
//
//  Created by xiazhengcheng on 2023/4/2.
//  Copyright © 2023 etlfab. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "OCNetWorkManager.h"
#import <AFNetworking/AFNetworking.h>
#import "UIImageView+WebCache.h"

@interface FirstViewController ()<PassMessageDelegate>
@end

@implementation FirstViewController
//使用synthesize的几种情况：
//1对属性进行重新命名
//2.重写了属性的setter和getter方法
//3.实现了带有property属性的protocol
//@synthesize name = newName;

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
    
    [OCNetWorkManager requestWithOject:@{} successBlock:^(NSDictionary * _Nonnull dict) {
        NSLog(@"response:%@",dict);
    } failureBlock:^(NSDictionary * _Nonnull dict) {
        NSLog(@"error");
    }];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.backgroundColor = [UIColor yellowColor];
    [imageView sd_setImageWithURL:[NSURL URLWithString:@"https://img1.baidu.com/it/u=413643897,2296924942&fm=253&fmt=auto&app=138&f=JPEG?w=800&h=500"] placeholderImage:[UIImage imageNamed:@""] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        NSLog(@"图片加载完成");
    }];
    
    [self.view addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(200);
        make.top.equalTo(blockbutton.mas_bottom).offset(20);
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

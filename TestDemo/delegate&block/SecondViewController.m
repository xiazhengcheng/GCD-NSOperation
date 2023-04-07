//
//  SecondViewController.m
//  TestDemo
//
//  Created by xiazhengcheng on 2023/4/2.
//  Copyright © 2023 etlfab. All rights reserved.
//

#import "SecondViewController.h"
#import "CodyProxy.h"
#import "TestProy.h"

@interface SecondViewController ()
@property (nonatomic,copy) NSTimer *timer;

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
    [self testBlock];
    [self testTimer];
    
}

//timer循环引用问题
- (void)testTimer {
    //第一种方式
    //    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target: [CodyProxy proxyWithTarget:self] selector:@selector(timerSelector) userInfo:nil repeats:YES];
    //第二种方式
//    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target: [TestProy proxyWithTarget:self] selector:@selector(timerSelector) userInfo:nil repeats:YES];
    //方式三：
    if (@available(iOS 10.0, *)) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            NSLog(@"1");
        }];
    } else {
        // Fallback on earlier versions
    };
}

- (void)timerSelector {
    NSLog(@"1");
}

- (void)testBlock {
    static int height = 30;
    __block int age = 20;
    void(^block)(void) = ^ {
        NSLog(@"height:%d---age:%d",height,age);
    };
    
    age = 25;
    height = 35;
    block();
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

-(void)dealloc {
    [_timer invalidate];
    NSLog(@"dealloc");
}

@end

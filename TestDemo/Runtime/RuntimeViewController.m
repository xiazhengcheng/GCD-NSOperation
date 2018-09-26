//
//  RuntimeViewController.m
//  TestDemo
//
//  Created by etlfab on 2018/9/14.
//  Copyright © 2018年 etlfab. All rights reserved.
//

#import "RuntimeViewController.h"
#import "UIControl+Button.h"
@interface RuntimeViewController ()

@end

@implementation RuntimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"runtime方法替换";
    self.runtimeBntton.backgroundColor = [UIColor redColor];
    [self setUpMasonaryConstrains];
    self.runtimeBntton.buttonIgnoreEvent = NO;
    self.runtimeBntton.buttonAcceptEventInterval = 3;
}

- (void)setUpMasonaryConstrains{
    
    [self.runtimeBntton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset((ScreenWidth - 100) / 2);
        make.top.mas_equalTo(self.view).offset(150);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btnClick:(id)sender {
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

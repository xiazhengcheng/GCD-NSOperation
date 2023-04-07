//
//  SelfKvoViewController.m
//  TestDemo
//
//  Created by xiazhengcheng on 2023/4/7.
//  Copyright © 2023 etlfab. All rights reserved.
//

#import "SelfKvoViewController.h"
#import "NSObject+Cody_KVO.h"

@interface SelfKvoViewController ()
@property (strong, nonatomic) UIView *colorView;
@property (nonatomic,strong) UILabel *textlabel;
@end

@implementation SelfKvoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _colorView = [[UIView alloc] init];
    _colorView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview: _colorView];
    
    _textlabel = [[UILabel alloc] init];
    _textlabel.text = @"123";
    [self.view addSubview:_textlabel];
    
    UIButton *button = [[UIButton alloc]init];
    [button setTitle:@"button" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"change" forState: UIControlStateNormal];
    [self.view addSubview:button];
    
    [_colorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(104);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(300);
    }];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_colorView.mas_bottom).offset(100);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(40);
    }];
    
    [_textlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_colorView).offset(100);
    }];
    
    [self.colorView cody_addObserver:self forKeyPath:@"backgroundColor" callBack:^(id  _Nonnull observe, NSString * _Nonnull keyPath, id  _Nonnull oldValue, id  _Nonnull newValue) {
        // 回到主线程刷新UI界面
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"colorView的颜色改变了!");
        });
    }];
}

- (void)buttonClick {
//    self.textlabel.text = @"456"
    self.colorView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
}



@end

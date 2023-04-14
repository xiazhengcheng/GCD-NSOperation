//
//  CategoryViewController.m
//  TestDemo
//
//  Created by xiazhengcheng on 2023/3/31.
//  Copyright © 2023 etlfab. All rights reserved.
//

#import "CategoryViewController.h"
#import "UIView+MyUIView.h"
#import "UIButton+MyUIButton.h"
#import "Student.h"
#import <objc/message.h>
#import "TestDemo-Swift.h"

@interface CategoryViewController () {
    UIButton *button;
}

@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *view = [[UIView alloc] init];
    view.tag = 101;
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    
    button = [[UIButton alloc]init];
    [button setTitle:@"button" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(100);
        make.center.equalTo(self.view);
    }];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(100);
        make.top.equalTo(view.mas_top).offset(50);
    }];
    
    Student *student = [[Student alloc] init];
    
    BOOL res1 = [(id)[NSObject class] isKindOfClass:[NSObject class]];
    BOOL res2 = [(id)[NSObject class] isMemberOfClass:[NSObject class]];
    
    NSLog(@"%@",[NSObject class]);
    NSLog(@"%@",[Student class]);
    
    
    id cls = [CategoryViewController class];
    void *obj = &cls;
    [(__bridge id)obj speak];
    
    Class tls = [self class];
    NSLog(@"%@",tls);
    
    Sort *sort = [[Sort alloc] init];
    
}

- (void)speak{
    NSLog(@"my name is %@",self.name);
}

- (void)buttonClick {
    button.name = @"关联对象";
    NSLog(@"%@", [NSString stringWithFormat:@"%@",button.name]);
    [button click];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UIView *view = [self.view viewWithTag:101];
    [view click];
}

- (void)dealloc {
    
}
@end



//
//  ISAExhangeViewController.m
//  TestDemo
//
//  Created by xiazhengcheng on 2023/4/4.
//  Copyright © 2023 etlfab. All rights reserved.
//

#import "ISAExhangeViewController.h"
#import <objc/runtime.h>

@interface ISAExhangeViewController ()

@end

@implementation ISAExhangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self test1];
}


//黑魔法交换ISA指针
+ (void)load {
    Method method_test1 = class_getInstanceMethod(self, @selector(test1));
    Method method_test2 = class_getInstanceMethod(self, @selector(test2));
    method_exchangeImplementations(method_test1, method_test2);
}
- (void)test1 {
    NSLog(@"test1");
}

- (void)test2 {
    NSLog(@"test2");
}

@end

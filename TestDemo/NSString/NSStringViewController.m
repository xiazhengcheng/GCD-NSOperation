//
//  NSStringViewController.m
//  TestDemo
//
//  Created by xiazhengcheng on 2023/4/4.
//  Copyright © 2023 etlfab. All rights reserved.
//

#import "NSStringViewController.h"

@interface NSStringViewController ()

@end

@implementation NSStringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _strongStr = @"123";
    _mutStr = [NSMutableString stringWithString:@"456"];
    _strongStr = _mutStr;
    NSLog(@"1---strongStr:%@-------mutStr:%@",self.strongStr,self.mutStr);
    [_mutStr appendString:@"789"];
    NSLog(@"2---strongStr:%@-------mutStr:%@",self.strongStr,self.mutStr);

    _strongArr = @[@1,@2,@3];
    _mutArr = [NSMutableArray arrayWithArray:@[@4,@5,@6]];
    _strongArr = _mutArr;
    NSLog(@"1---strongArr:%@-------mutArr:%@",self.strongArr,self.mutArr);

    [_mutArr addObject:@10];
    NSLog(@"2---strongArr:%@-------mutArr:%@",self.strongArr,self.mutArr);

    
    
    
}

@end

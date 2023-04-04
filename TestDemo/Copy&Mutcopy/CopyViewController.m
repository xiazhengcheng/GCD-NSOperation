//
//  CopyViewController.m
//  TestDemo
//
//  Created by xiazhengcheng on 2023/4/2.
//  Copyright © 2023 etlfab. All rights reserved.
//

#import "CopyViewController.h"

@interface CopyViewController ()

@end

@implementation CopyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.str = @"123";
    NSString *oldStr = [self.str copy];
    NSString *mutStr = [self.str mutableCopy];
    NSLog(@"str:%p---oldStr:%p---mutStr:%p",&_str,&oldStr, &mutStr);
}

@end

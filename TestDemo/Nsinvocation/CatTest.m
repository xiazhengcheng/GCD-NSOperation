//
//  CatTest.m
//  TestDemo
//
//  Created by etlfab on 2018/9/12.
//  Copyright © 2018年 etlfab. All rights reserved.
//

#import "CatTest.h"
#import "PAMultipleDelegateManager.h"

@implementation CatTest
-(void)addCatTarget {
    [[PAMultipleDelegateManager shareInstance].delegate addDelegate:self];
}

- (void)paBaseMultipleDelegateTest{
    NSLog(@"这只小猫好可爱！");
}
@end

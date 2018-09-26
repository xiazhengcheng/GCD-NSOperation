//
//  DogTest.m
//  TestDemo
//
//  Created by etlfab on 2018/9/12.
//  Copyright © 2018年 etlfab. All rights reserved.
//

#import "DogTest.h"
@implementation DogTest
- (void)addDogTarget {
    [[PAMultipleDelegateManager shareInstance].delegate addDelegate:self];
}

-(void)paBaseMultipleDelegateTest {
    NSLog(@"小狗好可爱！");
}
@end

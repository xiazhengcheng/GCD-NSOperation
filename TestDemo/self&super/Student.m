//
//  Student.m
//  TestDemo
//
//  Created by xiazhengcheng on 2023/3/31.
//  Copyright © 2023 etlfab. All rights reserved.
//

#import "Student.h"

@implementation Student

- (instancetype)init {
    self = [super init];
    if(self) {
        NSLog(@"selfClass:%@",NSStringFromClass([self class]));
        NSLog(@"superClass:%@",NSStringFromClass([super class]));
    }
    return  self;
}
@end

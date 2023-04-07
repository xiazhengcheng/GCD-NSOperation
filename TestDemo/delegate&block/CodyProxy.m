//
//  CodyProxy.m
//  TestDemo
//
//  Created by xiazhengcheng on 2023/4/7.
//  Copyright © 2023 etlfab. All rights reserved.
//

#import "CodyProxy.h"

@implementation CodyProxy

+ (instancetype)proxyWithTarget:(id)target {
    CodyProxy *proxy = [[CodyProxy alloc] init];
    proxy.target = target;
    return proxy;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return  self.target;
}
@end

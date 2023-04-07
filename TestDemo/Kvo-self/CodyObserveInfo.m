//
//  CodyObserveInfo.m
//  TestDemo
//
//  Created by xiazhengcheng on 2023/4/7.
//  Copyright © 2023 etlfab. All rights reserved.
//

#import "CodyObserveInfo.h"

@implementation CodyObserveInfo

- (instancetype)initWithObserver:(id)observer key:(NSString *)key callback:(CodyKVOCallBack)callback {
    if (self = [super init]) {
        _observer = observer;
        _key = key;
        _callback = callback;
    }
    return  self;
}
@end

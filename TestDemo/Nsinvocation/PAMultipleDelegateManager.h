//
//  PAMultiDelegate.h
//  TestDemo
//
//  Created by etlfab on 2018/9/11.
//  Copyright © 2018年 etlfab. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PABaseMultipleDelegate<NSObject>

@optional
- (void)paBaseMultipleDelegateTest;
@end

@interface PAMultiDelegate : NSObject
@property (nonatomic,strong,readonly)NSPointerArray *delgates;
- (void)addDelegate:(id)delegate;
- (void)removeDelegate:(id)delegate;
@end

@interface PAMultipleDelegateManager:NSObject
@property (nonatomic, strong) PAMultiDelegate<PABaseMultipleDelegate> *delegate;
+(instancetype)shareInstance;
@end

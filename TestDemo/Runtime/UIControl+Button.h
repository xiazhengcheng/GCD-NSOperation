//
//  UIControl+Button.h
//  TestDemo
//
//  Created by etlfab on 2018/9/15.
//  Copyright © 2018年 etlfab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/message.h>
@interface UIControl (Button)

@property(nonatomic,assign) NSTimeInterval buttonAcceptEventInterval;
@property(nonatomic,assign) BOOL buttonIgnoreEvent;

@end

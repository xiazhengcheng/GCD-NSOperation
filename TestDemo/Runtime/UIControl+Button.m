//
//  UIControl+Button.m
//  TestDemo
//
//  Created by etlfab on 2018/9/15.
//  Copyright © 2018年 etlfab. All rights reserved.
//

#import "UIControl+Button.h"

@implementation UIControl (Button)
static const char *UIControlAcceptEventInterval = "UIControlAcceptEventInterval";
static const char *UIcontrolIgnoreEvent="UIcontrolIgnoreEvent";

- (NSTimeInterval)buttonAcceptEventInterval {
    return [objc_getAssociatedObject(self, UIControlAcceptEventInterval) doubleValue];
}

- (void)setButtonAcceptEventInterval:(NSTimeInterval)buttonAcceptEventInterval {
    objc_setAssociatedObject(self, UIControlAcceptEventInterval, @(buttonAcceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)buttonIgnoreEvent {
    return [objc_getAssociatedObject(self, UIcontrolIgnoreEvent) boolValue];
}

- (void)setButtonIgnoreEvent:(BOOL)buttonIngoreEvent {
    objc_setAssociatedObject(self, UIcontrolIgnoreEvent, @(buttonIngoreEvent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)load{
    Method a = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    Method b = class_getInstanceMethod(self, @selector(zcSendAction:to:forEvent:));
    method_exchangeImplementations(a, b);
    
}

- (void)zcSendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    NSLog(@"新方法");
    if (self.buttonIgnoreEvent) {
        return;
    }
    if (self.buttonAcceptEventInterval > 0) {
        self.buttonIgnoreEvent = YES;
        [self performSelector:@selector(setButtonIgnoreEvent:) withObject:@(NO) afterDelay:self.buttonAcceptEventInterval];
    }
    [self zcSendAction:action to:target forEvent:event];
}

@end

//
//  UIButton+MyUIButton.m
//  TestDemo
//
//  Created by xiazhengcheng on 2023/3/31.
//  Copyright © 2023 etlfab. All rights reserved.
//

#import "UIButton+MyUIButton.h"
#import <objc/message.h>

@implementation UIButton (MyUIButton)
- (void)click {
    NSLog(@"UIButton Click");
}

- (void) setName:(NSString *)name {
    objc_setAssociatedObject(self, @selector(name), name, OBJC_ASSOCIATION_COPY);
}

- (NSString *)name {
    return objc_getAssociatedObject(self, @selector(name));
}
@end

//
//  PAMultiDelegate.m
//  TestDemo
//
//  Created by etlfab on 2018/9/11.
//  Copyright © 2018年 etlfab. All rights reserved.
//

#import "PAMultipleDelegateManager.h"

static PAMultipleDelegateManager *manage;

@interface PAMultipleDelegateManager()
@end
@implementation PAMultipleDelegateManager

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manage = [[PAMultipleDelegateManager alloc] init];
    });
    return manage;
}

- (instancetype)init{
    if (self = [super init]) {
        _delegate = [(PAMultiDelegate<PABaseMultipleDelegate> *)[PAMultiDelegate alloc] init];
    }
    return self;
}
@end

@implementation PAMultiDelegate
- (instancetype)init {
    if (self = [super init]) {
        /**
         NSPointerArray的用处   1. 说明 也许你对NSArray使用了如指掌,每个加入到NSArry的对象都会被NSArray持有.有时候,这种特性不是我们想要的结果. 有时候,我们想将对象存储起来,但是不想让数组增加了这个对象的引用计数,这个时候,NSPointArray才是你想要的.
         */
        _delgates = [NSPointerArray weakObjectsPointerArray];
    }
    return self;
}

- (void) addDelegate:(id)delegate {
    /**
     和 NSArray在概念上不一样的地方是，NSPointerArray需要添加的是对象的指针地址，尽管他俩都是在操作指针。所以在添加对象时，需要将其转换为指针类型，__bridge转换十分具有 CoreFoundation特色
     */
    if (delegate && ![_delgates.allObjects containsObject:delegate]) {
        [_delgates addPointer:(__bridge void *)(delegate)];
    }
}

- (void)removeDelegate:(id)delegate {
    NSUInteger index = [self indexOfDelegate:delegate];
    if (index != NSNotFound) {
        /**
         [_delegates compact]，这个方法可以帮助你去掉数组里面的野指针，避免你在快速遍历的时候拿到一个指向不存在对象的地址
         */
        [_delgates removePointerAtIndex:index];
    }
    [_delgates compact];
}

- (NSUInteger)indexOfDelegate:(id)delegate {
    for (NSUInteger i = 0; i < _delgates.count; i++) {
        if ([_delgates pointerAtIndex:i] == (__bridge void*)delegate) {
            
            return i;
        }
    }
    return NSNotFound;
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    if ([super respondsToSelector:aSelector]) {
        return YES;
    }
    for (id delegate in _delgates) {
        if (delegate && [delegate respondsToSelector:aSelector]) {
            return YES;
        }
    }
    return NO;
}

/**
 在给程序添加消息转发功能以前，必须覆盖两个方法，即methodSignatureForSelector:和forwardInvocation:。methodSignatureForSelector:的作用在于为另一个类实现的消息创建一个有效的方法签名，必须实现，并且返回不为空的methodSignature，否则会crash
 */
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    if (signature) {
        return signature;
    }
    [_delgates compact];
    
    for (id delegate in _delgates) {
        if (!delegate) {
            continue;
        }
        signature = [delegate methodSignatureForSelector:aSelector];
        if (signature) {
            break;
        }
    }
    return signature;
}
//备源接受者
/**
 当对象所属类不能动态添加方法后，runtime就会询问当前的接受者是否有其他对象可以处理这个未知的selector，
 */
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    SEL selector = [anInvocation selector];
    BOOL responed = NO;
    for (id delegate in _delgates) {
        if (delegate && [delegate respondsToSelector:selector]) {
            [anInvocation invokeWithTarget:delegate];
            responed = YES;
        }
    }
    if (!responed) {
        [self doesNotRecognizeSelector:selector];
    }
}

@end

//
//  NSObject+Cody_KVO.m
//  TestDemo
//
//  Created by xiazhengcheng on 2023/4/7.
//  Copyright © 2023 etlfab. All rights reserved.
//

#import "NSObject+Cody_KVO.h"
#import <objc/message.h>
#import "CodyObserveInfo.h"

#define CodyKVOClassPrefix @"CodyKVO_"
#define CodyAssociateArrayKey @"CodyAssociateArrayKey"

@implementation NSObject (Cody_KVO)

- (void)cody_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath callBack:(CodyKVOBlock)callBack{
    //1.检查对象有没有对应的setter方法，如果没有抛出异常
    SEL setterSelector = NSSelectorFromString([self setterForGetter:keyPath]);
    Method setterMethod = class_getInstanceMethod([self class], setterSelector);
    if(!setterSelector) {
        NSLog(@"找不到方法");
        return;
    }
    
    //2.检查对象的isa指针指向的是不是一个kvo类，如果不是新建一个新类继承至原来的类，并把原来类isa指针指向新建的类
    Class clazz = object_getClass(self);
    NSString *className = NSStringFromClass(clazz);
    if(![className hasPrefix:CodyKVOClassPrefix]) {
        clazz = [self cody_KVOClassWithOriginalClassName:className];
        object_setClass(self,clazz);
    }
    
    //3.为kvo_class添加setter方法实现
    const char *types = method_getTypeEncoding(setterMethod);
    class_addMethod(clazz, setterSelector, (IMP)cody_setter, types);
 
    //添加该属性到观察者列表中
    //4.1 创建观察者的信息
    CodyObserveInfo *info = [[CodyObserveInfo alloc] initWithObserver:observer key:keyPath callback: callBack];
    
    //4.2获取关联对象（装着所有监听者的数组）
    NSMutableArray *observers = objc_getAssociatedObject(self, CodyAssociateArrayKey);
    if(!observers) {
        observers = [NSMutableArray array];
        objc_setAssociatedObject(self, CodyAssociateArrayKey, observers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    [observers addObject:info];
}

/**
 *  重写setter方法, 新方法在调用原方法后, 通知每个观察者(调用传入的block)
 */
static void cody_setter(id self, SEL _cmd, id newValue)
{
    NSString *setterName = NSStringFromSelector(_cmd);
    NSString *getterName = [self getterForSetter:setterName];
    
    
    if (!getterName) {
        NSLog(@"找不到getter方法");
    }
    
    // 获取旧值
    id oldValue = [self valueForKey:getterName];
    
    // 调用原类的setter方法
    
    struct objc_super superClazz = {
        .receiver = self,
        .super_class = class_getSuperclass(object_getClass(self))
    };
    
    ((void (*)(void *, SEL, id))objc_msgSendSuper)(&superClazz, _cmd, newValue);
    
    // 为什么不能用下面方法代替上面方法?
    //    ((void (*)(id, SEL, id))objc_msgSendSuper)(self, _cmd, newValue);
    
    
    // 找出观察者的数组, 调用对应对象的callback
    NSMutableArray *observers = objc_getAssociatedObject(self, CodyAssociateArrayKey);
    // 遍历数组
    for (CodyObserveInfo *info in observers) {
        if ([info.key isEqualToString:getterName]) {
            // gcd异步调用callback
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                info.callback(info.observer, getterName, oldValue, newValue);
            });
        }
    }
}

- (void)cody_removeObserve:(id)observe key:(NSString *)key {
    
}

#pragma mark - 私有方法

/**
 *  根据getter方法名返回setter方法名
 */
- (NSString *)setterForGetter:(NSString *)key
{
    // name -> Name -> setName:
    
    // 1. 首字母转换成大写
    unichar c = [key characterAtIndex:0];
    NSString *str = [key stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[NSString stringWithFormat:@"%c", c-32]];
    
    // 2. 最前增加set, 最后增加:
    NSString *setter = [NSString stringWithFormat:@"set%@:", str];

    return setter;
    
}

/**
 *  根据setter方法名返回getter方法名
 */
- (NSString *)getterForSetter:(NSString *)key
{
    // setName: -> Name -> name
    
    // 1. 去掉set
    NSRange range = [key rangeOfString:@"set"];
    
    NSString *subStr1 = [key substringFromIndex:range.location + range.length];
    
    // 2. 首字母转换成大写
    unichar c = [subStr1 characterAtIndex:0];
    NSString *subStr2 = [subStr1 stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[NSString stringWithFormat:@"%c", c+32]];
    
    // 3. 去掉最后的:
    NSRange range2 = [subStr2 rangeOfString:@":"];
    NSString *getter = [subStr2 substringToIndex:range2.location];
    
    return getter;
}

- (Class)cody_KVOClassWithOriginalClassName:(NSString *)className
{
    NSString *kvoClassName = [CodyKVOClassPrefix stringByAppendingString:className];
    Class kvoClass = NSClassFromString(kvoClassName);
    
    // 如果kvo class存在则返回
    if (kvoClass) {
        return kvoClass;
    }
    
    // 如果kvo class不存在, 则创建这个类
    Class originClass = object_getClass(self);
    kvoClass = objc_allocateClassPair(originClass, kvoClassName.UTF8String, 0);
    
    // 修改kvo class方法的实现
    Method clazzMethod = class_getInstanceMethod(kvoClass, @selector(class));
    const char *types = method_getTypeEncoding(clazzMethod);
    class_addMethod(kvoClass, @selector(class), (IMP)cody_class, types);
    
    objc_registerClassPair(kvoClass);
    
    return kvoClass;
    
}

/**
 *  模仿Apple的做法, 欺骗人们这个kvo类还是原类
 */
Class cody_class(id self, SEL cmd)
{
    Class clazz = object_getClass(self);
    Class superClazz = class_getSuperclass(clazz);
    return superClazz;
}

@end

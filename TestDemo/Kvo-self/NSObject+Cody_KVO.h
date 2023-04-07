//
//  NSObject+Cody_KVO.h
//  TestDemo
//
//  Created by xiazhengcheng on 2023/4/7.
//  Copyright © 2023 etlfab. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^CodyKVOBlock) (id observe, NSString *keyPath,id oldValue, id newValue);

@interface NSObject (Cody_KVO)
- (void)cody_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath callBack:(CodyKVOBlock)callBack;
- (void)cody_removeObserve:(id) observe key:(NSString *)key;
@end

NS_ASSUME_NONNULL_END

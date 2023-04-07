//
//  CodyObserveInfo.h
//  TestDemo
//
//  Created by xiazhengcheng on 2023/4/7.
//  Copyright © 2023 etlfab. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^CodyKVOCallBack) (id observer, NSString *key, id oldValue, id newValue);;

@interface CodyObserveInfo : NSObject

/** 监听者 */
@property (nonatomic, weak) id observer;

/** 监听的属性 */
@property (nonatomic, copy) NSString *key;

/** 回调的block */
@property (nonatomic, copy) CodyKVOCallBack callback;


- (instancetype)initWithObserver:(id)observer key:(NSString *)key callback:(CodyKVOCallBack)callback;

@end

NS_ASSUME_NONNULL_END

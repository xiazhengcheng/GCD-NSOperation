//
//  OCNetWorkManager.h
//  TestDemo
//
//  Created by xiazhengcheng on 2023/4/8.
//  Copyright © 2023 etlfab. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

typedef void (^ComplationBlock) (NSDictionary *dict);

@interface OCNetWorkManager : NSObject
+ (void)requestWithOject: (NSDictionary *)params
            successBlock: (ComplationBlock) successBlock
            failureBlock:(ComplationBlock)failureBlock;

@end

NS_ASSUME_NONNULL_END

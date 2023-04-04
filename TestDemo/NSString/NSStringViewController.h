//
//  NSStringViewController.h
//  TestDemo
//
//  Created by xiazhengcheng on 2023/4/4.
//  Copyright © 2023 etlfab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSStringViewController : BaseViewController
@property (nonatomic, strong) NSString *strongStr;
@property (nonatomic, strong) NSMutableString *mutStr;

@property (nonatomic, strong) NSArray *strongArr;
@property (nonatomic, strong) NSMutableArray *mutArr;


@end

NS_ASSUME_NONNULL_END

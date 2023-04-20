//
//  UIButton+MyUIButton.h
//  TestDemo
//
//  Created by xiazhengcheng on 2023/3/31.
//  Copyright © 2023 etlfab. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (MyUIButton)
@property (nonatomic,copy) NSString *name;
- (void)addTarget:(nullable id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

@end

NS_ASSUME_NONNULL_END

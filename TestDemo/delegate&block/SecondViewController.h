//
//  SecondViewController.h
//  TestDemo
//
//  Created by xiazhengcheng on 2023/4/2.
//  Copyright © 2023 etlfab. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol PassMessageDelegate <NSObject>

- (void) passMessage:(NSString *)message;

@end

typedef void (^BlockPassMessage) (NSString *message);


@interface SecondViewController : UIViewController


@property (nonatomic,weak) id<PassMessageDelegate> delegate;
@property(nonatomic,copy) BlockPassMessage blockMessage;

@end

NS_ASSUME_NONNULL_END

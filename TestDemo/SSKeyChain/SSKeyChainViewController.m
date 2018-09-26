//
//  SSKeyChainViewController.m
//  TestDemo
//
//  Created by etlfab on 2018/9/26.
//  Copyright © 2018年 etlfab. All rights reserved.
//

#import "SSKeyChainViewController.h"
#import <SSKeychain.h>
#define appBundleId @"com.vinScan.TestDemo"
#define Account @"xiazhengcheng"

@interface SSKeyChainViewController ()

@end

@implementation SSKeyChainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"SSKeychain";
    [self saveStringToKeychain];
    [self getStringToKeychain];
}
/**
 /**
 
      *  SSKeychain 是一种本地存储方式
 不会因为程序卸载而清除 用于存储
 私密 及
 唯一 的标示
 
      *
 
      *  五个方法:(用到两个)
 
      *  + (NSArray *)allAccounts;
 
      
 
      *  + (NSArray *)accountsForService:(NSString *)serviceName;
 
      
 
      *  + (NSString *)passwordForService:(NSString *)serviceName account:(NSString *)account;
 
      
 
      *  + (BOOL)deletePasswordForService:(NSString *)serviceName account:(NSString *)account;
 
      
 
      *  + (BOOL)setPassword:(NSString *)password forService:(NSString *)serviceName account:(NSString *)account;
 
      
 
      */

- (void) saveStringToKeychain {
    NSString *pwdStr = @"1234";
    if (![SSKeychain passwordForService:appBundleId account:Account]) {
        //如果没设置密码则 设定密码 并存储
        
        [SSKeychain setPassword:pwdStr forService:appBundleId account:Account];
        //打印密码信息
        
        NSString *retrieveuuid = [SSKeychain
                                          passwordForService:appBundleId
                                          account:Account];
        
        NSLog(@"SSKeychain存储显示:未安装过:%@", retrieveuuid);
                      
    } else {
        NSString *retrieveuuid = [SSKeychain
                                  passwordForService:appBundleId
                                  account:Account];
        
        NSLog(@"SSKeychain存储显示 :已安装过:%@",retrieveuuid);
    }
}


- (void)getStringToKeychain {
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

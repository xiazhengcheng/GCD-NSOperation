//
//  InvocationViewController.m
//  TestDemo
//
//  Created by etlfab on 2018/9/11.
//  Copyright © 2018年 etlfab. All rights reserved.
//

#import "InvocationViewController.h"
#import "DogTest.h"
#import "CatTest.h"
@interface InvocationViewController (){
    DogTest *dog;
    CatTest *cat;
}

@end

@implementation InvocationViewController
- (IBAction)delegateClick:(id)sender {
    [[PAMultipleDelegateManager shareInstance].delegate paBaseMultipleDelegateTest];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"多代理的实现";
    dog = [[DogTest alloc] init];
    [dog addDogTarget];
    
    cat = [[CatTest alloc] init];
    [cat addCatTarget];
    
    [[PAMultipleDelegateManager shareInstance].delegate addDelegate:self];

}

#pragma mark delegate
- (void)paBaseMultipleDelegateTest
{
    NSLog(@"VCTap");
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

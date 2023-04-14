//
//  OCNetWorkManager.m
//  TestDemo
//
//  Created by xiazhengcheng on 2023/4/8.
//  Copyright © 2023 etlfab. All rights reserved.
//

#import "OCNetWorkManager.h"
#import <AFNetworking/AFNetworking.h>

@implementation OCNetWorkManager
+ (void)requestWithOject:(NSDictionary *)params successBlock:(ComplationBlock)successBlock failureBlock:(ComplationBlock)failureBlock{
    AFHTTPSessionManager *manage = [AFHTTPSessionManager manager];
    
    NSMutableArray *responseContentTypes = [[NSMutableArray alloc] init];
    [responseContentTypes addObjectsFromArray:@[@"text/html",@"application/json",@"text/json", @"text/plain",@"text/javascript",@"text/xml",@"image/*",@"multipart/form-data",@"application/octet-stream",@"application/zip"]];
    manage.responseSerializer.acceptableContentTypes = [NSSet setWithArray:responseContentTypes];
    
    [manage POST:@"https://www.finture.id/user/api/v1/open/version-config/iOS" parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject:%@",responseObject);
        successBlock((NSDictionary *)responseObject);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
        failureBlock(@{@"errorCode": @0, @"errorMessage":@"失败"});

    }];

}
@end

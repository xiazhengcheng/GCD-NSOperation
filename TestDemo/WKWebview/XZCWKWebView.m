//
//  XZCWKWebView.m
//  TestDemo
//
//  Created by etlfab on 2018/9/17.
//  Copyright © 2018年 etlfab. All rights reserved.
//

#import "XZCWKWebView.h"
@interface XZCWKWebView () {
    WKWebView *wkWebView;
}

@end

@implementation XZCWKWebView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"WKWebView与原生交互";
    
    UIBarButtonItem *myButton = [[UIBarButtonItem alloc] initWithTitle:@"点击" style:UIBarButtonItemStylePlain target:self action:@selector(clickEvent)];
    
    self.navigationItem.rightBarButtonItem = myButton;
    
   
    [self createWebView];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [wkWebView.configuration.userContentController removeScriptMessageHandlerForName:@"alertTest"];
}
- (void)clickEvent{
    NSString *jsStr = [NSString stringWithFormat:@"alertTest2()"];
    [wkWebView evaluateJavaScript:@"alertTest2()" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        NSLog(@"%@----%@",result, error);
//        [SVProgressHUD showSuccessWithStatus:@"调取成功"];
    }];
}


- (void)createWebView {
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.preferences.javaScriptCanOpenWindowsAutomatically = false;
    config.preferences.javaScriptEnabled = YES;
    config.userContentController = [[WKUserContentController alloc]init];
    [config.userContentController addScriptMessageHandler:self name:@"alertTest"];
    
    //JS注入 向网页中添加自己的JS方法
    WKUserScript *cookieScript = [[WKUserScript alloc] initWithSource:@"" injectionTime:WKUserScriptInjectionTimeAtDocumentStart forMainFrameOnly:NO];
    [config.userContentController addUserScript:cookieScript];
    
    wkWebView = [[WKWebView alloc] init];
    wkWebView.backgroundColor = [UIColor redColor];
    wkWebView.navigationDelegate = self;
    wkWebView.UIDelegate = self;
    
    NSURL *pathUrl = [[NSBundle mainBundle] URLForResource:@"WKWebViewTest.html" withExtension:nil];
    [wkWebView loadRequest:[NSURLRequest requestWithURL:pathUrl]];
    [self.view addSubview:wkWebView];
    
    [wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(64);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(ScreenHeight);
    }];
}

-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message

{
    
//    userContentController 注册message的WKUserContentController；
//
//    message：js传过来的数据
//
//    id body:消息携带的信息 Allowed types are NSNumber, NSString, NSDate, NSArray, NSDictionary, and NSNull.
//
//    NSString *name:消息的名字 如aaa
    
    //message.name  js发送的方法名称
    
    if([message.name  isEqualToString:@"alertTest"])
        
    {
        
        NSString * body = [message.body objectForKey:@"body"];
        
        //                           在这里写oc 实现协议的native方法
        NSLog(@"弹框");
        
    }
    
}

#pragma mark alert弹出框
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    NSLog(@"%s", __FUNCTION__);
    // 确定按钮
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }];
    // alert弹出框
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:alertAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark Confirm选择框
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(nonnull NSString *)message initiatedByFrame:(nonnull WKFrameInfo *)frame completionHandler:(nonnull void (^)(BOOL))completionHandler {
    NSLog(@"%s", __FUNCTION__);
    // 按钮
    UIAlertAction *alertActionCancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        // 返回用户选择的信息
        completionHandler(NO);
    }];
    UIAlertAction *alertActionOK = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }];
    // alert弹出框
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:alertActionCancel];
    [alertController addAction:alertActionOK];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

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

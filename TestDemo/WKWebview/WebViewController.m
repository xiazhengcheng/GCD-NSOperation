//
//  WebViewController.m
//  TestDemo
//
//  Created by etlfab on 2018/9/20.
//  Copyright © 2018年 etlfab. All rights reserved.
//

#import "WebViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    UIBarButtonItem *myButton = [[UIBarButtonItem alloc] initWithTitle:@"点击" style:UIBarButtonItemStylePlain target:self action:@selector(clickEvent)];
//
//    self.navigationItem.rightBarButtonItem = myButton;

    [self createWebView];
    // Do any additional setup after loading the view.
}

- (void)clickEvent {
    [self.webView stringByEvaluatingJavaScriptFromString:@"alertTest2()"];
}

- (void)createWebView {
    
    self.webView = [[UIWebView alloc] init];
    self.webView.backgroundColor = [UIColor redColor];
    NSURL *pathUrl = [[NSBundle mainBundle] URLForResource:@"WKWebViewTest.html" withExtension:nil];
    self.webView.delegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:pathUrl]];
    [self.view addSubview:self.webView];
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(ScreenHeight);
    }];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    [self addAlert:context];
}

- (void)addAlert:(JSContext *)context {
    context[@"alertTest3"] = ^(){
//        NSLog(@"快吃饭了！");
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"该吃饭了！"];

        });
    };
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

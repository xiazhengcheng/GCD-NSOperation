//
//  ViewController.m
//  TestDemo
//
//  Created by etlfab on 2018/9/11.
//  Copyright © 2018年 etlfab. All rights reserved.
//

#import "ViewController.h"
#import "InvocationViewController.h"
#import "ThreadViewController.h"
#import "RuntimeViewController.h"
#import "XZCWKWebView.h"
#import "WebViewController.h"
#import "SSKeyChainViewController.h"
#import "UIView+MyUIView.h"
#import "CategoryViewController.h"
#import "FirstViewController.h"
#import "CopyViewController.h"
#import "NSStringViewController.h"
#import "Isa-swizzling/ISAExhangeViewController.h"
#import "SelfKvoViewController.h"
#import "RacViewController.h"
#import "TestDemo-Swift.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"分类";
    _dataArray = [[NSMutableArray alloc] initWithObjects:@"多代理的实现",@"多线程",@"runtime方法替换",@"UIWebView",@"WKWebView",@"SSKeychain", @"Category", @"delegate&&block",@"copy",@"swiftClosure",@"字符串",@"ISA_change",@"自定义kvo",@"rxSwift",@"rxtableView",@"sectionTableView",@"rac",@"AlamofireRequest",nil];
    [self createTabView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)createTabView {
    self.tabView = [[UITableView alloc] init];
    //    self.tabView.backgroundColor = [UIColor redColor];
    self.tabView.delegate = self;
    self.tabView.dataSource = self;
    [self.view addSubview:self.tabView];
    
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.top.equalTo(self.view.mas_top);
        make.width.mas_equalTo(ScreenWidth);
        make.height.mas_equalTo(ScreenHeight);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = _dataArray[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:{
            InvocationViewController *ivc = [[InvocationViewController alloc] init];
            [self.navigationController pushViewController:ivc animated:YES];
        }
            break;
        case 1:{
            ThreadViewController *tvc = [[ThreadViewController alloc] init];
            [self.navigationController pushViewController:tvc animated:YES];
        }
            break;
        case 2:{
            RuntimeViewController *rvc = [[RuntimeViewController alloc] init];
            [self.navigationController pushViewController:rvc animated:YES];
        }
            break;
        case 3:{
            WebViewController *xvc = [[WebViewController alloc] init];
            [self.navigationController pushViewController:xvc animated:YES];
        }
            break;
        case 4:{
            XZCWKWebView *xvc = [[XZCWKWebView alloc] init];
            [self.navigationController pushViewController:xvc animated:YES];
        }
            break;
        case 5:{
            SSKeyChainViewController *svc = [[SSKeyChainViewController alloc] init];
            [self.navigationController pushViewController:svc animated:YES];
        }
            break;
        case 6:{
            CategoryViewController *cvc = [[CategoryViewController alloc] init];
            [self.navigationController pushViewController:cvc animated:YES];
        }
            break;
        case 7:{
            FirstViewController *fvc = [[FirstViewController alloc] init];
            [self.navigationController pushViewController:fvc animated:YES];
        }
            break;
        case 8:{
            CopyViewController *cvc = [[CopyViewController alloc] init];
            [self.navigationController pushViewController:cvc animated:YES];
        }
            break;
        case 9:{
            ClosuresViewController *cvc = [[ClosuresViewController alloc] init];
            [self.navigationController pushViewController:cvc animated:YES];
        }
            break;
        case 10:{
            NSStringViewController *nvc = [[NSStringViewController alloc] init];
            [self.navigationController pushViewController: nvc animated:YES];
        }
            break;
        case 11:{
            ISAExhangeViewController *ivc = [[ISAExhangeViewController alloc] init];
            [self.navigationController pushViewController: ivc animated:YES];
        }
            break;
        case 12:{
            SelfKvoViewController *ivc = [[SelfKvoViewController alloc] init];
            [self.navigationController pushViewController: ivc animated:YES];
        }
            break;
        case 13:{
            RxTextViewController *ivc = [[RxTextViewController alloc] init];
            [self.navigationController pushViewController: ivc animated:YES];
        }
            break;
        case 14:{
            RxTableViewController *ivc = [[RxTableViewController alloc] init];
            [self.navigationController pushViewController: ivc animated:YES];
        }
            break;
        case 15:{
            RxTableviewSectionViewController *ivc = [[RxTableviewSectionViewController alloc] init];
            [self.navigationController pushViewController: ivc animated:YES];
        }
            break;
        case 16:{
            RacViewController *ivc = [[RacViewController alloc] init];
            [self.navigationController pushViewController: ivc animated:YES];
        }
            break;
        case 17:{
            AlamofireRequestViewController *ivc = [[AlamofireRequestViewController alloc] init];
            [self.navigationController pushViewController: ivc animated:YES];
        }
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end

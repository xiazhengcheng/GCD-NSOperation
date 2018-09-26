//
//  ViewController.h
//  TestDemo
//
//  Created by etlfab on 2018/9/11.
//  Copyright © 2018年 etlfab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tabView;
@property (nonatomic,retain)NSMutableArray *dataArray;
@end


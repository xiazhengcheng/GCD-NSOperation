//
//  ThreadViewController.m
//  TestDemo
//
//  Created by etlfab on 2018/9/13.
//  Copyright © 2018年 etlfab. All rights reserved.
//

#import "ThreadViewController.h"

@interface ThreadViewController (){
    dispatch_queue_t conCurrentQueue;
    dispatch_queue_t serialQueue;
}

@end

@implementation ThreadViewController
/**
 多线程操作需要特别的注意线程安全问题，常用的解决线程安全的问题主要是有一下几种方法
 iOS 实现线程加锁有很多种方式
 NSLock、
 NSRecursiveLock、//递归锁http://www.cocoachina.com/ios/20150513/11808.html
 NSCondition、//条件锁
 NSConditionLock、
 pthread_mutex、//互斥锁
 如果互斥锁类型为 PTHREAD_MUTEX_NORMAL，则不提供死锁检测。尝试重新锁定互斥锁会导致死锁。如果某个线程尝试解除锁定的互斥锁不是由该线程锁定或未锁定，则将产生不确定的行为。
 如果互斥锁类型为 PTHREAD_MUTEX_ERRORCHECK，则会提供错误检查。如果某个线程尝试重新锁定的互斥锁已经由该线程锁定，则将返回错误。如果某个线程尝试解除锁定的互斥锁不是由该线程锁定或者未锁定，则将返回错误。
 如果互斥锁类型为 PTHREAD_MUTEX_RECURSIVE，则该互斥锁会保留锁定计数这一概念。线程首次成功获取互斥锁时，锁定计数会设置为 1。线程每重新锁定该互斥锁一次，锁定计数就增加 1。线程每解除锁定该互斥锁一次，锁定计数就减小 1。 锁定计数达到 0 时，该互斥锁即可供其他线程获取。如果某个线程尝试解除锁定的互斥锁不是由该线程锁定或者未锁定，则将返回错误。
 如果互斥锁类型是 PTHREAD_MUTEX_DEFAULT，则尝试以递归方式锁定该互斥锁将产生不确定的行为。对于不是由调用线程锁定的互斥锁，如果尝试解除对它的锁定，则会产生不确定的行为。如果尝试解除锁定尚未锁定的互斥锁，则会产生不确定的行为。
 
 dispatch_semaphore、 //信号量
 OSSpinLock、//自旋锁--苹果2014年已经不推荐使用，用pthread_mutex和dispatch_semaphore替换他俩的性能问题和OSSpinLock很相近，自旋锁的性能最高，nslock的性能最低
 
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"多线程";
    self.GCDBtn.backgroundColor = [UIColor redColor];
    self.nsOperationBtn.backgroundColor = [UIColor yellowColor];
    self.imageView1.backgroundColor = [UIColor yellowColor];
    self.imageView2.backgroundColor = [UIColor yellowColor];
    self.imageView3.backgroundColor = [UIColor yellowColor];

    [self setUpConstrance];
    
}

#pragma mark - masonary布局
- (void)setUpConstrance{
    [self.GCDBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset((ScreenWidth - 250)/2);
        make.top.mas_equalTo(self.view).offset(100);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
    }];
    
    [self.nsOperationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.GCDBtn).offset((ScreenWidth - 250)/2 + 100);
        make.top.mas_equalTo(self.GCDBtn);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
    }];
    
    [self.imageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset((ScreenWidth - 200)/2);
        make.top.mas_equalTo(self.nsOperationBtn).offset(70);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(150);
    }];
    
    [self.imageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset((ScreenWidth - 200)/2);
        make.top.mas_equalTo(self.imageView1).offset(160);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(150);
    }];
    
    [self.imageView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset((ScreenWidth - 200)/2);
        make.top.mas_equalTo(self.imageView2).offset(160);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(150);
    }];
}

- (IBAction)gcdBtnClick:(id)sender {
#if 0 //1并行执行 0串行执行
    conCurrentQueue = dispatch_queue_create("cn.itcast", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(conCurrentQueue, ^{
        NSURL *url = [NSURL URLWithString:@"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2063724715,1253364800&fm=27&gp=0.jpg"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        NSLog(@"123");

        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView1.image = image;
        });
//        sleep(2);
    });
    //栅栏函数的使用可以是上面的线程先执行完再去执行下面的线程
//    dispatch_barrier_async(conCurrentQueue, ^{
//        NSLog(@"----barrier-----%@", [NSThread currentThread]);
//    });
    dispatch_async(conCurrentQueue, ^{
        NSURL *url = [NSURL URLWithString:@"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2063724715,1253364800&fm=27&gp=0.jpg"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        NSLog(@"456");

        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView2.image = image;
        });
    });
    
    dispatch_async(conCurrentQueue, ^{
        NSURL *url = [NSURL URLWithString:@"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2063724715,1253364800&fm=27&gp=0.jpg"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        NSLog(@"789");

        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView3.image = image;
        });
    });
#else
    serialQueue = dispatch_queue_create("cn.itcast", DISPATCH_QUEUE_SERIAL);
    dispatch_sync(serialQueue, ^{
        NSURL *url = [NSURL URLWithString:@"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2063724715,1253364800&fm=27&gp=0.jpg"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        NSLog(@"123");
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView1.image = image;
        });
    });
    
    dispatch_sync(serialQueue, ^{
        NSURL *url = [NSURL URLWithString:@"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2063724715,1253364800&fm=27&gp=0.jpg"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        NSLog(@"456");
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView2.image = image;
        });
//        sleep(2);
    });
    
    dispatch_sync(serialQueue, ^{
        NSURL *url = [NSURL URLWithString:@"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2063724715,1253364800&fm=27&gp=0.jpg"];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        NSLog(@"789");

        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView3.image = image;
        });
    });
#endif
}

- (IBAction)nsOperationClick:(id)sender {
//    [self NSBlockOperationTask];
    [self NSInvocationOperationTask:@"12"];
}

- (void)NSInvocationOperationTask:(id)data {
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = 1;
    
    NSInvocationOperation *theOp1 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(theOpTask1:) object:data];
    
    NSInvocationOperation *theOp2 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(theOpTask2:) object:data];
    
    NSInvocationOperation *theOp3 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(theOpTask3:) object:data];
    

    //同时NSOperation可以添加线程依赖
//    [theOp1 addDependency:theOp3];
//    [theOp1 addDependency:theOp2];
    
    [queue addOperation:theOp1];
    [queue addOperation:theOp2];
    [queue addOperation:theOp3];
}

- (void)theOpTask1:(NSInvocationOperation *)op {
    NSLog(@"123");
    NSURL *url = [NSURL URLWithString:@"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2063724715,1253364800&fm=27&gp=0.jpg"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    NSLog(@"456");
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        self.imageView1.image = image;
    }];
}

- (void)theOpTask2:(NSInvocationOperation *)op {
    sleep(2);//模拟耗时操作
    NSLog(@"456");
    NSURL *url = [NSURL URLWithString:@"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2063724715,1253364800&fm=27&gp=0.jpg"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    NSLog(@"456");
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        self.imageView2.image = image;
    }];
}

- (void)theOpTask3:(NSInvocationOperation *)op {
    NSLog(@"789");
    NSURL *url = [NSURL URLWithString:@"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2063724715,1253364800&fm=27&gp=0.jpg"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    NSLog(@"456");
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        self.imageView3.image = image;
    }];

}
- (void)NSBlockOperationTask {
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"执行1操作，线程%@",[NSThread currentThread]);
    }];
    
    [operation addExecutionBlock:^{
        NSLog(@"执行2操作，线程%@",[NSThread currentThread]);

    }];
    
    [operation addExecutionBlock:^{
        NSLog(@"执行3操作，线程%@",[NSThread currentThread]);
        
    }];
    
    [operation addExecutionBlock:^{
        NSLog(@"执行4操作，线程%@",[NSThread currentThread]);
        
    }];
    [operation start];

}

/**
NSInvocationOperation
 */

/**
NSBlockOperation
 */

/**
 NSOperation
 */
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

//
//  ZJNSRunLoopViewController.m
//  ZJFoundation
//
//  Created by YunTu on 15/8/10.
//  Copyright (c) 2015年 YunTu. All rights reserved.
//

#import "ZJNSRunLoopViewController.h"

@interface ZJNSRunLoopViewController () {
    BOOL _isLoading;
    BOOL _end;
}

@end

@implementation ZJNSRunLoopViewController

/*
    Volatile 变量适用于独立变量的另一个内存限制类型。编译器优化代码通过加载这些变量的值进入寄存器。
    对于本地变量,这通常不会有什么问题。但是如果一个变量对另外一个线程可见,那么这种优化可能会阻止其他线程发现变量的任何变化。
    在变量之前加上关键字 volatile 可以强制编译器每次使用变量的时候都从内存里面加载。
    如果一个变量的值随时可能给编译器无法检测的外部源更改,那么你可以把该变量声明为 volatile 变量。
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    volatile int i = 10;
    NSLog(@"i = %d", i);
    
    NSArray *titles = @[@"addObserver", @"load", @"阻塞线程"];
    for (int i = 0; i < titles.count; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 200 + 100*i, 150, 50)];
        btn.backgroundColor = [UIColor redColor];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        if (i == 0) {
            [btn addTarget:self action:@selector(addObserverAction:) forControlEvents:UIControlEventTouchUpInside];
        }else if(i == 1) {
            [btn addTarget:self action:@selector(load:) forControlEvents:UIControlEventTouchUpInside];
        }else {
            [btn addTarget:self action:@selector(blockThread:) forControlEvents:UIControlEventTouchUpInside];
        }
        [self.view addSubview:btn];
    }

}

#pragma mark - addObserver

/*
    如果你要定义观察者并把它添加到 run loop 的话,那就只能使用 Core Fundation 了。
    为了创建一 个 run loop 观察者,你可以创建一个 CFRunLoopObserverRef 类型的实例。
    它会追踪 你自定义的回调函数以及其它你感兴趣的活动。
 */

- (IBAction)addObserverAction:(UIButton *)sender {
    [NSThread detachNewThreadSelector:@selector(addObserver) toTarget:self withObject:nil];
}

- (void)addObserver {
    NSRunLoop *myRunLoop = [NSRunLoop currentRunLoop];
    
    CFRunLoopObserverContext context = {0, (__bridge void *)(self), NULL, NULL, NULL};
    CFRunLoopObserverCallBack back = NULL;
    CFRunLoopObserverRef observer = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, back, &context);
    if (observer) {
        CFRunLoopRef cfLoop = [myRunLoop getCFRunLoop];
        CFRunLoopAddObserver(cfLoop, observer, kCFRunLoopDefaultMode);
    }
    
    [NSTimer scheduledTimerWithTimeInterval:0.0 target:self selector:@selector(doFireTimer:) userInfo:nil repeats:YES];
    NSInteger loopCount = 10;
    do {
        [myRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:.1]];
        loopCount--;
        NSLog(@"count = %zd", loopCount);
    } while (loopCount);
}

- (void)doFireTimer:(NSTimer *)timer {
    NSLog(@"timer : %@", timer);
}

#pragma mark - load

- (IBAction)load:(UIButton *)sender {
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.frame = CGRectMake(100, 200, 100, 100);
    [indicator startAnimating];
    [self.view addSubview:indicator];
    
    _isLoading = YES;
    
    [NSThread detachNewThreadSelector:@selector(backgroundAction) toTarget:self withObject:nil];
    
    while (_isLoading) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }
    [indicator stopAnimating];
}

- (void)backgroundAction {
    NSString *path = @"http://webservice.webxml.com.cn/webservices/qqOnlineWebService.asmx/qqCheckOnline?qqCode=727200399";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:path]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSLog(@"加载完成");
        _isLoading = NO;
    }];
}

#pragma mark - 阻塞线程

- (IBAction)blockThread:(UIButton *)sender {
    NSLog(@"start new thread....");
    
    [NSThread detachNewThreadSelector:@selector(runOnNewThread) toTarget:self withObject:nil];
    
    while (!_end) {
        NSLog(@"runLoop....");
        
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        
        NSLog(@"runLoop end.");
    }
    NSLog(@"OK.");
}

- (void)runOnNewThread {
    NSLog(@"run for new thread ...");

    sleep(1);
    
    /*
     _end = YES;
        但是这样做，运行时会发现，while循环 后执行的语句会在很长时间后才被执行。
        
        解决方法1:
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
        缩短runloop的休眠时间，看起来解决了上面出现的问题。
        不过这样也又问题，runloop对象被经常性的唤醒，这违背了runloop的设计初衷。runloop的作用就是要减少cpu做无谓的空转，cpu可在空闲的时候休眠，以节约电量。
     */
    
    /*
        解决方法2:
     
        造成while循环后语句延缓执行的原因是，runloop未被唤醒。因为，改变变量的值，runloop对象根本不知道。
        延缓的时长总是不定的，这是因为，有其他事件在某个时点唤醒了主线程，这才结束了while循环。那么，向主线程发送消息，将唤醒runloop，因此问题就解决了。
     */
    [self performSelectorOnMainThread:@selector(setEnd) withObject:nil waitUntilDone:NO];
    
    NSLog(@"end.");
}

- (void)setEnd {
    _end = YES;
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

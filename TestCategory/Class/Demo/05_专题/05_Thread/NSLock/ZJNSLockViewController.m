//
//  ZJNSLockViewController.m
//  ZJFoundation
//
//  Created by YunTu on 15/8/12.
//  Copyright (c) 2015年 YunTu. All rights reserved.
//

#import "ZJNSLockViewController.h"
#import <pthread.h>

@interface ZJNSLockViewController ()

@property (nonatomic) int sellCount;
@property (nonatomic, strong) NSLock *lock;

@end

pthread_mutex_t mutex;

static const NSInteger TicketCount = 10;

@implementation ZJNSLockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self test1];
    
    NSArray *titles = @[@"testLock", @"testRecursiveLock"];
    for (int i = 0; i < titles.count; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 200 + 100*i, 150, 50)];
        btn.backgroundColor = [UIColor redColor];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        if (i == 0) {
            [btn addTarget:self action:@selector(test3:) forControlEvents:UIControlEventTouchUpInside];
        }else {
            [btn addTarget:self action:@selector(testRecursiveLock:) forControlEvents:UIControlEventTouchUpInside];
        }
        [self.view addSubview:btn];
    }
}

#pragma mark - @synchronized指令 and Lock Example

- (void)synchronizedAndLockTestExample {
    self.lock = [[NSLock alloc]init];
    
    NSThread *thread1 = [[NSThread alloc]initWithTarget:self selector:@selector(sellTicket) object:nil];
    thread1.name = @"one";
    [thread1 start];
    
    NSThread *thread2 = [[NSThread alloc]initWithTarget:self selector:@selector(sellTicket) object:nil];
    thread2.name = @"two";
    [thread2 start];       //多线程的异步执行, 导致结果出错; solve:线程同步
}

- (void)sellTicket {
    NSLog(@"%s", __func__);
    
    while (1) {   // 无限循环
        /*
            为临界区加锁(互斥访问临界区)
         */
        
        // method1:synchronized
//        @synchronized(self) {    //任意类型的 同一个对象
//            NSString *name = [NSThread currentThread].name;
//            NSLog(@"%@开始卖票", name);
//            
//            [NSThread sleepForTimeInterval:.1];
//            
//            self.sellCount++;
//            NSLog(@"%@卖票结束, 卖了%d张还剩%d张", name, self.sellCount, TicketCount - self.sellCount);
//        }
        
        // method2:lock

        [self.lock lock];
        
        if (self.sellCount >= TicketCount) {
            break;      // 跳出无限循环
        }
        NSString *name = [NSThread currentThread].name;
        NSLog(@"%@开始卖票", name);
        
        [NSThread sleepForTimeInterval:.1];
        
        self.sellCount++;
        NSLog(@"%@卖票结束, 卖了%zd张还剩%zd张", name, self.sellCount, TicketCount - self.sellCount);
        
        [self.lock unlock];
    }
}

#pragma mark - NSLock

- (void)test1 {
    NSLock *lock = [[NSLock alloc] init];
    NSMutableArray *ary = [NSMutableArray arrayWithObjects:@0, @1, @2, @3, nil];
    
    [lock lock];
    
    NSObject *obj = ary[0];

    [lock unlock];
    [self doSOmethingWithObj:obj];
    /*
     但是上面显式的例子有一个问题。
     如果当你释放该锁,而在你有机会执行 doSomething 方法前其他线程到来并从数组中删除所有对象,那会发生什么呢?
     对于没有使用垃圾回收的应用程序,你代码用户的对象可能已经释放了,让 anObject 对象指向一个非法的内存地址。
     要修正该问题,你可能决定简单的重新安排你的代码, 让它在调用 doSomething 之后才释放锁.
     */
}

- (void)test2 {
    NSLock *lock = [[NSLock alloc] init];
    NSMutableArray *ary = [NSMutableArray arrayWithObjects:@0, @1, @2, @3, nil];
    
    [lock lock];
    
    NSObject *obj = ary[0];
    [self doSOmethingWithObj:obj];
    
    [lock unlock];
    /*
     通过把 doSomething 的调用移到锁的内部,你的代码可以保证该方法被调用的时候该对象还是有效的。
     不幸的是,如果 doSomething 方法需要耗费很长的时间,这有可能导致你的代码保持拥有该锁很长时间,
     这会产生一个性能瓶颈。所以对于ARC程序来讲,使用test1就好
     */
}

- (void)doSOmethingWithObj:(NSObject *)obj {
    NSLog(@"%@ do something", obj);
}

- (void)test3:(UIButton *)sender {
    BOOL moreToDo = YES;
    NSLock *lock = [[NSLock alloc] init];
    
    int i = 10000;
    while (moreToDo) {
        NSLog(@"doing....");
        i--;
        if (i < 0) {
            moreToDo = NO;
        }
        
        if ([lock tryLock]) {
            [lock unlock];
        }
    }
}

#pragma mark - NSRecursiveLock
- (void)testRecursiveLock:(UIButton *)sender {
    NSRecursiveLock *recursiveLock = [[NSRecursiveLock alloc] init];
    [self recursiveFunction:10 withLock:recursiveLock];
}

- (void)recursiveFunction:(NSInteger)value withLock:(NSRecursiveLock *)recursiveLock {
    [recursiveLock lock];
    if (value != 0) {
        --value;
        NSLog(@"value = %zd", value);
        [self recursiveFunction:value withLock:recursiveLock];
    }
    [recursiveLock unlock];
}

#pragma mark - POSIX互斥锁
/*
 POSIX 表示可移植操作系统接口（Portable Operating System Interface ，缩写为 POSIX ）
 */
void myInitFunction () {
    pthread_mutex_init(&mutex, NULL);
}

void lockFunction() {
    pthread_mutex_lock(&mutex);
    
    // Do Work
    
    pthread_mutex_unlock(&mutex);
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

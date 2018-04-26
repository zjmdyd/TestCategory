//
//  ZJNSKeyedArchiverViewController.m
//  ZJFoundation
//
//  Created by YunTu on 15/7/3.
//  Copyright (c) 2015年 YunTu. All rights reserved.
//

#import "ZJNSKeyedArchiverViewController.h"
#import "AppDelegate.h"
#import "Person.h"
#import "ZJLover.h"

@interface ZJNSKeyedArchiverViewController () {
    AppDelegate *_appDelegate;
}

@end

@implementation ZJNSKeyedArchiverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self testSystemArchiver];
    [self testCustomArchiver];
//    [self testCoreDataArchiver];
}

- (void)testSystemArchiver {
    NSArray *arr = @[@"张三", @"李四", @"王五"];
    
    /**
     *  归档解档: 方式一
     */
    
    /*
     归档:把对象--->data
     */
    //1.创建一个可变长度的data
    NSMutableData *md = [NSMutableData data];
    //2.创建归档对象
    NSKeyedArchiver *arch = [[NSKeyedArchiver alloc]initForWritingWithMutableData:md];
    //3.开始编码
    [arch encodeObject:arr forKey:@"names"];
    //4.完成编码
    [arch finishEncoding];
    
    NSError *error;
    BOOL isSuccess = [md writeToFile:@"/Users/yuntu/Desktop/names" atomically:YES];
    if (isSuccess) {        // 在模拟器会成功, 真机写入不成功, why???
        NSLog(@"归档成功");
    }else {
        NSLog(@"归档失败 error = %@", error);
    }
    /*
     反归档:把Data-->对象
     */
    NSData *data = [NSData dataWithContentsOfFile:@"/Users/yuntu/Desktop/names"];
    //1.创建反归档对象
    NSKeyedUnarchiver *unArch = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
    //2.解码:把对象解出来
    NSArray *newNames = [unArch decodeObjectForKey:@"names"];
    for (NSString *name in newNames) {
        NSLog(@"%@", name);
    }
    
    NSLog(@"\n\n**************\n\n");
    
    /**
     *  归档解档: 方式二
     */
    NSData *d = [NSKeyedArchiver archivedDataWithRootObject:arr];
    NSArray *n = [NSKeyedUnarchiver unarchiveObjectWithData:d];
    for (NSString *name in n) {
        NSLog(@"%@", name);
    }
    
    NSLog(@"\n\n**************\n\n");
}

- (void)testCustomArchiver {
    ZJLover *lover = [[ZJLover alloc] init];
    lover.name = @"aa";
    lover.age = 11;
    
    ZJLover *lover2 = [[ZJLover alloc] init];
    lover2.name = @"bb";
    lover2.age = 22;
    
    NSArray *ary = @[lover, lover2];
    
    /*
     归档:把对象---> data
     */
    //1.创建一个可变长度的data
    NSMutableData *md = [NSMutableData data];
    //2.创建归档对象
    NSKeyedArchiver *arch = [[NSKeyedArchiver alloc]initForWritingWithMutableData:md];
    //3.开始编码
    [arch encodeObject:ary forKey:@"lover"];
    //4.完成编码
    [arch finishEncoding];
    
    NSError *error;
    BOOL isSuccess = [md writeToFile:@"/Users/ZJ/Desktop/custom" options:NSDataWritingAtomic error:&error];
    if (isSuccess) {        // 在模拟器会成功
        NSLog(@"归档成功");
    }else {
        NSLog(@"归档失败 error = %@", error);
    }
    
    /*
     反归档:把Data-->对象
     */
    NSData *data = [NSData dataWithContentsOfFile:@"/Users/ZJ/Desktop/custom"];
    //1.创建反归档对象
    NSKeyedUnarchiver *unArch = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    //2.解码:把对象解出来
    
    NSArray *deAry = [unArch decodeObjectForKey:@"lover"];
    NSLog(@"deAry = %@", deAry);
    for (ZJLover *lv in deAry) {
        NSLog(@"name = %@, age = %ld", lv.name, (long)lv.age);
    }
    
//    ZJLover *newLover = [unArch decodeObjectForKey:@"lover"];
//    NSLog(@"name = %@, age = %ld", newLover.name, (long)newLover.age);
}

- (void)testCoreDataArchiver {
    _appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    Person *p = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:_appDelegate.persistentContainer.viewContext];
    p.name = @"Martin";
    p.age = @100;
    p.color = [UIColor redColor];
    p.lover = @[@"a", @"b", @"c"];
    [_appDelegate saveContext];
    
    [self search];
}

- (void)search {
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Person"];
    // 执行查询请求 并得到查询出来的结果
    NSArray *persons = [_appDelegate.persistentContainer.viewContext executeFetchRequest:request error:nil];
    for (Person *p in persons) {
        NSLog(@"%@  %@  %@  %@", p.name, p.age, p.color, p.lover);
    }
    
    /*
     NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K = %@", @"age", @20];
     NSLog(@"Age 20 : %@", [persons filteredArrayUsingPredicate:predicate]);
     
     NSFetchRequest *request = [[NSFetchRequest alloc] init];
     NSEntityDescription *entity = [NSEntityDescription entityForName:@"Employee"
     inManagedObjectContext:managedObjectContext];
     [request setEntity:entity];
     
     NSNumber *salaryLimit = A number representing the limit;
     NSPredicate *predicate = [NSPredicate predicateWithFormat:@"salary > %@", salaryLimit];
     [request setPredicate:predicate];
     NSError *error;
     NSArray *array = [managedObjectContext executeFetchRequest:request error:&error];
     
     */
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

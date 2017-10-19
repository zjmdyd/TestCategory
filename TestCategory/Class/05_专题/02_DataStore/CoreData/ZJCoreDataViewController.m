//
//  ZJCoreDataViewController.m
//  ZJFoundation
//
//  Created by YunTu on 15/6/13.
//  Copyright (c) 2015年 YunTu. All rights reserved.
//

#import "ZJCoreDataViewController.h"
#import "Person.h"
#import "AppDelegate.h"
@interface ZJCoreDataViewController () {
    AppDelegate *_appDelegate;
}

@end

@implementation ZJCoreDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _appDelegate = [UIApplication sharedApplication].delegate;
    
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

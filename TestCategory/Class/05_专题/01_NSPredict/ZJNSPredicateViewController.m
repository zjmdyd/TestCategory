//
//  ZJNSPredicateViewController.m
//  ZJFoundation
//
//  Created by YunTu on 15/9/6.
//  Copyright (c) 2015年 YunTu. All rights reserved.
//

#import "ZJNSPredicateViewController.h"
#import "ZJPerson.h"

@interface ZJNSPredicateViewController ()

@end

@implementation ZJNSPredicateViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSArray *firstNames = @[@"Alich", @"Bob", @"Charlie", @"Quentin"];
    NSArray *lastNames = @[@"Smith", @"Jones", @"Smith", @"Alberts"];
    NSArray *ages = @[@24, @27, @33, @31];
    
    NSMutableArray *persons = [NSMutableArray array];
    
    [firstNames enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ZJPerson *person = [ZJPerson new];
        person.firstName = firstNames[idx];
        person.lastName = lastNames[idx];
        person.age = ages[idx];
        [persons addObject:person];
    }];
    
    NSPredicate *bobPredicate = [NSPredicate predicateWithFormat:@"firstName = 'Bob'"];
    NSPredicate *smithPredicte = [NSPredicate predicateWithFormat:@"lastName = %@", @"Smith"];
    NSPredicate *thirtiesPredicte = [NSPredicate predicateWithFormat:@"age >= 30"];
    
    NSLog(@"Bobs = %@", [persons filteredArrayUsingPredicate:bobPredicate]);
    NSLog(@"smith = %@", [persons filteredArrayUsingPredicate:smithPredicte]);
    NSLog(@"30's = %@", [persons filteredArrayUsingPredicate:thirtiesPredicte]);
    
    /*  谓词语法:
     %@是对值为字符串，数字或者日期的对象的替换值。
     %K是key path的替换值。(区分大小写)
     
     
     Important: Use a %@ format specifier only to represent an expression. Do not use it to represent an entire predicate.
     If you attempt to use a format specifier to represent an entire predicate, the system raises an exception.
     
     */
    
    NSPredicate *age33Predicate = [NSPredicate predicateWithFormat:@"%K = %@", @"age", @33];    // age = 33
    NSLog(@"Age 33 = %@", [persons filteredArrayUsingPredicate:age33Predicate]);
    
    //like
    NSString *attributeName  = @"firstName";
    NSString *attributeValue = @"Alich";
    NSPredicate *predicateLike   = [NSPredicate predicateWithFormat:@"%K like %@", attributeName, attributeValue];  // firstName like Alich
    NSLog(@"predicateLike = %@", [persons filteredArrayUsingPredicate:predicateLike]);
    
    NSPredicate *aPredicte = [NSPredicate predicateWithFormat:@"SELF beginswith[c] 'a'"];       // 数组索引的含义: c/C--> case-insensitive and d/D--> diacritic-insensitive
    NSLog(@"aPredicte = %@", [firstNames filteredArrayUsingPredicate:aPredicte]);
    
    NSPredicate *ePredicte = [NSPredicate predicateWithFormat:@"SELF contains[c] 'e'"];
    NSLog(@"ePredicte = %@", [firstNames filteredArrayUsingPredicate:ePredicte]);
    
    //   $VARIABLE_NAME是可以被NSPredicate -predicateWithSubstitutionVariables:替换的值。
    NSPredicate *nameWithLetterPredicate = [NSPredicate predicateWithFormat:@"(firstName BEGINSWITH[cd] $letter) OR (lastName BEGINSWITH[cd] $letter)"];
    NSLog(@"'A' Names : %@", [persons filteredArrayUsingPredicate:[nameWithLetterPredicate predicateWithSubstitutionVariables:@{@"letter":@"A"}]]);
    
    /*
     - evaluateWithObject:
     Returns a Boolean value that indicates whether a given object matches the conditions specified by the receiver.
     */
    
    // IN
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF IN %@", @[@"Stig", @"Shaffiq", @"Chris"]];     // 不区分大小写
    BOOL result = [predicate evaluateWithObject:@"Shaffiq"];
    NSLog(@"result = %d", result);
    
    // BETWEEN
    NSPredicate *betweenPredicate = [NSPredicate predicateWithFormat:@"attributeValue BETWEEN %@", @[@0, @10]];
    NSDictionary *dic = @{@"attributeValue":@5};
    if ([betweenPredicate evaluateWithObject:dic]) {
        NSLog(@"BETWEEN");
    }else {
        NSLog(@"NOT BETTWEEN");
    }
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

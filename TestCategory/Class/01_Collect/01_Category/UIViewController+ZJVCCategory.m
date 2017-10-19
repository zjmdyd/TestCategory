//
//  UIViewController+ZJVCCategory.m
//  TestCategory
//
//  Created by ZJ on 12/05/2017.
//  Copyright © 2017 ZJ. All rights reserved.
//

#import "UIViewController+ZJVCCategory.h"
#import <objc/runtime.h>

static void * MyCustomPorpertyKey = (void *)@"MyCustomPorpertyKey";

@implementation UIViewController (ZJVCCategory)

@dynamic value;

- (void)addMethod {
    NSLog(@"分类的方法执行了");
}

- (NSString *)value {
    return objc_getAssociatedObject(self, MyCustomPorpertyKey);
}

- (void)setValue:(NSString *)value {
    objc_setAssociatedObject(self, MyCustomPorpertyKey, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

//
//  ZJRunLoopContext.m
//  ZJFoundation
//
//  Created by YunTu on 15/8/11.
//  Copyright (c) 2015年 YunTu. All rights reserved.
//

#import "ZJRunLoopContext.h"
#import "AppDelegate.h"

void RunLoopSourceScheduleRoutine(void *info, CFRunLoopRef rl, CFStringRef mode) {
    ZJRunLoopSource *obj = (__bridge ZJRunLoopSource *)info;
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    
    ZJRunLoopContext *theContext = [[ZJRunLoopContext alloc] initWithSource:obj andLoop:rl];
    [appDelegate performSelectorOnMainThread:@selector(registerSource:) withObject:theContext waitUntilDone:NO];
}

void RunLoopSourcePerformRoutine(void *info) {
    ZJRunLoopSource *obj = (__bridge ZJRunLoopSource *)info;
    [obj sourceFired];
}

void RunLoopSourceCancelRoutine(void *info, CFRunLoopRef rl, CFStringRef mode) {
    ZJRunLoopSource *obj = (__bridge ZJRunLoopSource *)info;
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;

    ZJRunLoopContext *theContext = [[ZJRunLoopContext alloc] initWithSource:obj andLoop:rl];
    [appDelegate performSelectorOnMainThread:@selector(removeSource:) withObject:theContext waitUntilDone:YES];
}

@implementation ZJRunLoopContext

- (instancetype)initWithSource:(ZJRunLoopSource *)src andLoop:(CFRunLoopRef)loop {
    if (self = [super init]) {
        
    }
    
    return self;
}

@end

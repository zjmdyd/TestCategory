//
//  ZJRunLoopSource.m
//  ZJFoundation
//
//  Created by YunTu on 15/8/11.
//  Copyright (c) 2015年 YunTu. All rights reserved.
//

#import "ZJRunLoopSource.h"
#import "ZJRunLoopContext.h"

@implementation ZJRunLoopSource 

- (instancetype)init {
    self = [super init];
    if (self) {
        CFRunLoopSourceContext context = {0, (__bridge void *)(self), NULL, NULL, NULL, NULL, NULL, &RunLoopSourceScheduleRoutine, RunLoopSourceCancelRoutine, RunLoopSourcePerformRoutine};
        runLoopSource = CFRunLoopSourceCreate(NULL, 0, &context);
        commands = [NSMutableArray array];
    }
    
    return self;
}

- (void)addToCurrentRunLoop {
    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    CFRunLoopAddSource(runLoop, runLoopSource, kCFRunLoopDefaultMode);
}

- (void)addCommand:(NSString *)command withData:(NSData *)data {
    
}

- (void)sourceFired {

}

- (void)invalidate {

}

- (void)firedAllCommandOnRunLoop:(CFRunLoopRef)runLoop {
    CFRunLoopSourceSignal(runLoopSource);
    CFRunLoopWakeUp(runLoop);
}

@end

//
//  ZJRunLoopContext.h
//  ZJFoundation
//
//  Created by YunTu on 15/8/11.
//  Copyright (c) 2015年 YunTu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZJRunLoopSource.h"

// RunLoopContext is a container object used during registration of the input source.

void RunLoopSourceScheduleRoutine(void *info, CFRunLoopRef rl, CFStringRef mode);
void RunLoopSourcePerformRoutine(void *info);
void RunLoopSourceCancelRoutine(void *info, CFRunLoopRef rl, CFStringRef mode);

@interface ZJRunLoopContext : NSObject {
    CFRunLoopRef _runLoop;
    ZJRunLoopSource *_source;
}

@property (readonly) CFRunLoopRef runLoop;
@property (readonly) ZJRunLoopSource *source;

- (instancetype)initWithSource:(ZJRunLoopSource *)src andLoop:(CFRunLoopRef)loop;

@end

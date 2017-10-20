//
//  ZJRunLoopSource.h
//  ZJFoundation
//
//  Created by YunTu on 15/8/11.
//  Copyright (c) 2015年 YunTu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZJRunLoopSource : NSObject {
    CFRunLoopSourceRef runLoopSource;
    NSMutableArray *commands;
}

- (instancetype)init;

- (void)addToCurrentRunLoop;

- (void)invalidate;

// handler method

- (void)sourceFired;

// client interface for registering commands to process

- (void)addCommand:(NSString *)command withData:(NSData *)data;

- (void)firedAllCommandOnRunLoop:(CFRunLoopRef)runLoop;

@end

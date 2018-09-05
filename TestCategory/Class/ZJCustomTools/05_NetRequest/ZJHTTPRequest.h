//
//  ZJHTTPRequest.h
//  CanShengHealth
//
//  Created by ZJ on 03/02/2018.
//  Copyright © 2018 HY. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HTTPRequestType) {
    HTTPRequestTypeOfGet,
    HTTPRequestTypeOfPost,
    HTTPRequestTypeOfDelete,
    HTTPRequestTypeOfPut,
};

typedef void(^HTTPRequestCompletionHandle)(id obj, BOOL hasLogin);

static NSString *const kComDomain = @"http://193.112.176.180:8444";
static NSString *const kNetDomain = @"https://api.aoshitong.doorguard.hanyouapp.com";

@interface ZJHTTPRequest : NSObject

@property (nonatomic, strong) NSDictionary *shareParams;
@property (nonatomic, strong) NSDictionary *shareHeaders;

+ (NSString *)kDomain;
+ (instancetype)shareHTTPRequest;

- (void)requestWithPath:(NSString *)path params:(NSDictionary *)params requestType:(HTTPRequestType)type mentionText:(NSString *)text needShareParams:(BOOL)need  completion:(HTTPRequestCompletionHandle)completion;
- (void)requestWithPath:(NSString *)path params:(NSDictionary *)params requestType:(HTTPRequestType)type mentionText:(NSString *)text needShareParams:(BOOL)need isJsonFormData:(BOOL)isJsonFormData completion:(HTTPRequestCompletionHandle)completion;

- (void)requestWithPath:(NSString *)path hasDomain:(BOOL)has params:(NSDictionary *)params requestType:(HTTPRequestType)type mentionText:(NSString *)text needShareParams:(BOOL)need  completion:(HTTPRequestCompletionHandle)completion;
- (void)requestWithPath:(NSString *)path hasDomain:(BOOL)has params:(NSDictionary *)params requestType:(HTTPRequestType)type mentionText:(NSString *)text needShareParams:(BOOL)need isJsonFormData:(BOOL)isJsonFormData completion:(HTTPRequestCompletionHandle)completion;

@end

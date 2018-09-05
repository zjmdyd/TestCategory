//
//  ZJHTTPRequest.m
//  CanShengHealth
//
//  Created by ZJ on 03/02/2018.
//  Copyright © 2018 HY. All rights reserved.
//

#import "ZJHTTPRequest.h"
#import "ZJFondationCategory.h"
#import "ZJNSObjectCategory.h"

static NSString *defaultRequestMention = @"请稍后";
static NSString *defaultFailMention = @"网络故障";
static NSInteger SuccessCode = 0;
static NSInteger NoLoginCode = 401;

#define RequestTypes @[@"GET", @"POST", @"DELETE", @"PUT"]
#define TimeOutDuration 15

@interface ZJHTTPRequest()

@end

static ZJHTTPRequest *_requestManage = nil;

@implementation ZJHTTPRequest

+ (instancetype)shareHTTPRequest {
    if (!_requestManage) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _requestManage = [[self alloc] init];
        });
    }
    
    return _requestManage;
}

- (NSURLCache *)defaultURLCache {
    return [[NSURLCache alloc] initWithMemoryCapacity:20 * 1024 * 1024
                                         diskCapacity:150 * 1024 * 1024
                                             diskPath:@"com.alamofire.imagedownloader"];
}

- (NSURLSessionConfiguration *)defaultURLSessionConfiguration {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    //TODO set the default HTTP headers
    
    configuration.HTTPShouldSetCookies = YES;
    configuration.HTTPShouldUsePipelining = NO;
    
    configuration.requestCachePolicy = NSURLRequestUseProtocolCachePolicy;
    configuration.allowsCellularAccess = YES;
    configuration.timeoutIntervalForRequest = TimeOutDuration;
    configuration.URLCache = [self defaultURLCache];
    
    return configuration;
}

- (void)requestWithPath:(NSString *)path params:(NSDictionary *)params requestType:(HTTPRequestType)type mentionText:(NSString *)text needShareParams:(BOOL)need completion:(HTTPRequestCompletionHandle)completion {
    [self requestWithPath:path hasDomain:NO params:params requestType:type mentionText:text needShareParams:need completion:completion];
}

- (void)requestWithPath:(NSString *)path params:(NSDictionary *)params requestType:(HTTPRequestType)type mentionText:(NSString *)text needShareParams:(BOOL)need isJsonFormData:(BOOL)isJsonFormData completion:(HTTPRequestCompletionHandle)completion {
    [self requestWithPath:path hasDomain:NO params:params requestType:type mentionText:text needShareParams:need isJsonFormData:isJsonFormData completion:completion];
}

- (void)requestWithPath:(NSString *)path hasDomain:(BOOL)has params:(NSDictionary *)params requestType:(HTTPRequestType)type mentionText:(NSString *)text needShareParams:(BOOL)need completion:(HTTPRequestCompletionHandle)completion {
    [self requestWithPath:path hasDomain:has params:params requestType:type mentionText:text needShareParams:need isJsonFormData:NO completion:completion];
}

- (void)requestWithPath:(NSString *)path hasDomain:(BOOL)has params:(NSDictionary *)params requestType:(HTTPRequestType)type mentionText:(NSString *)text needShareParams:(BOOL)need isJsonFormData:(BOOL)isJsonFormData completion:(HTTPRequestCompletionHandle)completion {
#ifdef HiddenProgress
    HiddenProgressView(NO, text.length ? text:defaultRequestMention, NO);
#endif
    NSURLSessionConfiguration *configuration = [self defaultURLSessionConfiguration];
    
    NSURLSessionDataTask *dataTask;
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSMutableDictionary *mParams = params.mutableCopy;
    NSString *urlString = path, *domain = [ZJHTTPRequest kDomain];
    if (need && self.shareParams) [mParams addEntriesFromDictionary:[self shareParams]];
    
    if ([[ZJHTTPRequest kDomain] hasSuffix:@"/"]) domain = [domain substringToIndex:domain.length-1];
    
    if (![path hasPrefix:@"/"]) path = [@"/" stringByAppendingString:path];
    
    if (!has) urlString = [NSString stringWithFormat:@"%@%@", domain, path];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    if (type == HTTPRequestTypeOfGet) {
        NSString *paramUrlString = [NSString stringWithFormat:@"%@?%@", urlString, [mParams httpParamsString]];
        url = [NSURL URLWithString:[paramUrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:TimeOutDuration];
    if (type != HTTPRequestTypeOfGet) {
        [request setHTTPMethod:RequestTypes[type]];
        [request setHTTPShouldHandleCookies:YES];
        
        NSData *data; NSString *contentValue;
        if (isJsonFormData) {
            contentValue = @"application/json;charset=utf-8";
            data = [NSJSONSerialization dataWithJSONObject:params options:0 error:nil];
        }else {
            contentValue = @"application/x-www-form-urlencoded;charset=utf-8";
            data = [[mParams httpParamsString] dataUsingEncoding:NSUTF8StringEncoding];
        }
        [request setValue:contentValue forHTTPHeaderField:@"Content-Type"];
        request.HTTPBody = data;
    }
    if (isJsonFormData) {
        for (NSString *key in self.shareHeaders.allKeys) {
            [request addValue:[self shareHeaders][key] forHTTPHeaderField:key];
        }
    }
    
    dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [self handleRequestBack:data response:response error:error completion:completion];
    }];
    
    [dataTask resume];
}

- (void)handleRequestBack:(NSData *)data response:(NSURLResponse *)response error:(NSError *)error completion:(HTTPRequestCompletionHandle)completion {
#ifdef DEBUG_LOG
    NSLog(@"response = %@", response);
    NSLog(@"error = %@", error);
#endif
    if (data) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
#ifdef DEBUG_LOG
        NSLog(@"dic = %@", dic);
        NSLog(@"string = %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
#endif
        NSInteger code = [dic[@"code"] integerValue];
        BOOL success = code == SuccessCode;
        if (success) {
            completion(dic, YES);
        }else if(code == NoLoginCode) {
            completion(nil, NO);
        }else {
            completion(nil, YES);
        }
#ifdef HiddenProgress
        HiddenProgressView(YES, dic[@"msg"] ?: @"", success == NO);
#endif
    }else {
#ifdef HiddenProgress
        HiddenProgressView(YES, defaultFailMention, YES);
#endif
        completion(nil, YES);
    }
}

+ (void)setCookie:(NSURL *)url {
    NSHTTPCookieStorage* cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray<NSHTTPCookie *> *cookies = [cookieStorage cookiesForURL:url];
    [cookies enumerateObjectsUsingBlock:^(NSHTTPCookie * _Nonnull cookie, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableDictionary *properties = [[cookie properties] mutableCopy];
        //将cookie过期时间设置为一年后
        NSDate *expiresDate = [NSDate dateWithTimeIntervalSinceNow:3600*24*30*12];
        properties[NSHTTPCookieExpires] = expiresDate;
        //下面一行是关键,删除Cookies的discard字段，应用退出，会话结束的时候继续保留Cookies
        [properties removeObjectForKey:NSHTTPCookieDiscard];
        //重新设置改动后的Cookies
        [cookieStorage setCookie:[NSHTTPCookie cookieWithProperties:properties]];
    }];
}

+ (NSString *)kDomain {
    if ([UIApplication isComBundleIdentifier]) {
        return kComDomain;
    }else {
        return kNetDomain;
    }
}

@end

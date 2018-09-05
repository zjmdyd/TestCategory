//
//  ZJRequestManager.h
//  ButlerSugar
//
//  Created by ZJ on 3/4/16.
//  Copyright © 2016 csj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZJHTTPRequest.h"

typedef void(^RequestCompletionHandle)(id obj);

#define LoginBaseUrl @"/api/user/login"
#define AuthBaseUrl @"/api/authcode"

#define MineBaseUrl @"/action/api/mineApi.jsp"
#define TestBaseUrl @"/action/api/checkApi.jsp"
#define ColumnBaseUrl @"/action/api/pediaApi.jsp"

@interface ZJRequestManager : NSObject

+ (instancetype)shareManager;

#pragma mark - 首页

//- (void)requestApplyHistory:(NSDictionary *)params mentionText:(NSString *)text completion:(RequestCompletionHandle)completion;

#pragma mark - 公共

- (void)requestNoParseWithParams:(NSDictionary *)params baseUrl:(NSString *)url requestType:(HTTPRequestType)type completion:(RequestCompletionHandle)completion;
- (void)requestNoParseWithParams:(NSDictionary *)params baseUrl:(NSString *)url requestType:(HTTPRequestType)type mentionText:(NSString *)text needShareParams:(BOOL)need completion:(RequestCompletionHandle)completion;

- (void)requestNoParseWithParams:(NSDictionary *)params hasDomain:(BOOL)has baseUrl:(NSString *)url requestType:(HTTPRequestType)type completion:(RequestCompletionHandle)completion;
- (void)requestNoParseWithParams:(NSDictionary *)params hasDomain:(BOOL)has baseUrl:(NSString *)url requestType:(HTTPRequestType)type mentionText:(NSString *)text needShareParams:(BOOL)need completion:(RequestCompletionHandle)completion;

- (void)uploadImageWithParams:(NSDictionary *)params imgPaths:(NSArray *)paths completion:(RequestCompletionHandle)completion;
- (void)uploadImageWithParams:(NSDictionary *)params imgPaths:(NSArray *)paths mentionText:(NSString *)text completion:(RequestCompletionHandle)completion;

@end

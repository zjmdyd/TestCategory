//
//  ZJRequestManager.m
//  ButlerSugar
//
//  Created by ZJ on 3/4/16.
//  Copyright © 2016 csj. All rights reserved.
//

#import "ZJRequestManager.h"
#import "ZJHTTPRequest.h"
#import "ZJParseManager.h"
//#import "AppDelegate+HYAppDelegate.h"

@interface ZJRequestManager ()

@end

static ZJRequestManager *_manager = nil;

@implementation ZJRequestManager

+ (instancetype)shareManager {
    if (!_manager) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _manager = [[self alloc] init];
        });
    }
    
    return _manager;
}

#pragma mark - 首页

#pragma mark - 公共

- (void)requestNoParseWithParams:(NSDictionary *)params baseUrl:(NSString *)url requestType:(HTTPRequestType)type completion:(RequestCompletionHandle)completion {
    [self requestNoParseWithParams:params hasDomain:NO baseUrl:url requestType:type mentionText:nil needShareParams:NO completion:completion];
}

- (void)requestNoParseWithParams:(NSDictionary *)params baseUrl:(NSString *)url requestType:(HTTPRequestType)type mentionText:(NSString *)text needShareParams:(BOOL)need completion:(RequestCompletionHandle)completion {
    [self requestNoParseWithParams:params hasDomain:NO baseUrl:url requestType:type mentionText:text needShareParams:need completion:completion];
}

- (void)requestNoParseWithParams:(NSDictionary *)params hasDomain:(BOOL)has baseUrl:(NSString *)url requestType:(HTTPRequestType)type completion:(RequestCompletionHandle)completion {
    [self requestNoParseWithParams:params hasDomain:NO baseUrl:url requestType:type mentionText:nil needShareParams:NO completion:completion];
}

- (void)requestNoParseWithParams:(NSDictionary *)params hasDomain:(BOOL)has baseUrl:(NSString *)url requestType:(HTTPRequestType)type mentionText:(NSString *)text needShareParams:(BOOL)need completion:(RequestCompletionHandle)completion {
    [[ZJHTTPRequest shareHTTPRequest] requestWithPath:url hasDomain:has params:params requestType:type mentionText:text needShareParams:need isJsonFormData:YES completion:^(id obj,  BOOL hasLogin) {
        if (hasLogin == NO) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [AppDelegate showRootVCWithType:RootViewControllerTypeOfLogin];
            });
        }else {
            completion(obj);
        }
    }];
}

// －－－－－－－－－－－－－－－－－－－－－－－－－－－－ 上传图片 －－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－


- (void)uploadImageWithParams:(NSDictionary *)params imgPaths:(NSArray *)paths completion:(RequestCompletionHandle)completion {
    [self uploadImageWithParams:params imgPaths:paths mentionText:nil completion:completion];
}

- (void)uploadImageWithParams:(NSDictionary *)params imgPaths:(NSArray *)paths mentionText:(NSString *)text completion:(RequestCompletionHandle)completion {
#ifdef HiddenProgress
    HiddenProgressView(NO, text.length?text:@"正在上传...", NO);
#endif
    
#ifdef ZJAFNetworking

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
    for (NSString *key in [[ZJHTTPRequest shareHTTPRequest] shareHeaders]) {
        [manager.requestSerializer setValue:[[ZJHTTPRequest shareHTTPRequest] shareHeaders][key] forHTTPHeaderField:key];
    }
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 15;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    
    // 在parameters里存放照片以外的对象
    NSString *path = [NSString stringWithFormat:@"%@/api/upload", [ZJHTTPRequest kDomain]];
    [manager POST:path parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // formData: 专门用于拼接需要上传的数据,在此位置生成一个要上传的数据体
        // 这里的_photoArr是你存放图片的数组
        for (int i = 0; i < paths.count; i++) {
            UIImage *image = [[UIImage alloc] initWithContentsOfFile:paths[i]];
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            
            // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
            // 要解决此问题，
            // 可以在上传时使用当前的系统时间作为文件名
            NSString *fileName = [NSString hy_stringFromDate:[NSDate date] withFormat:@"yyyyMMddHHmmss"];
            
            /*
             *该方法的参数
             1. appendPartWithFileData：要上传的照片[二进制流]
             2. name：对应网站上[upload.php中]处理文件的字段（比如upload）
             3. fileName：要保存在服务器上的文件名
             4. mimeType：上传的文件的类型
             */
            [formData appendPartWithFileData:imageData name:@"file" fileName:[NSString stringWithFormat:@"%@.jpg", fileName] mimeType:@"image/jpeg"]; //
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"---上传进度--- %@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"```上传成功``` %@", responseObject);
        if ([responseObject isKindOfClass:[NSData class]]) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
#ifdef DEBUG_LOG
            NSLog(@"dic = %@", dic);
            NSLog(@"string = %@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
#endif
            
            NSInteger code = [dic[@"code"] integerValue];
            BOOL success = code == 0;
            
            if (success) {
                completion(dic);
            }else if(code == 401) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [AppDelegate showRootVCWithType:RootViewControllerTypeOfLogin];
                });
                completion(nil);
            }else {
                completion(nil);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"xxx上传失败xxx %@", error);
#ifdef HiddenProgress
        HiddenProgressView(YES, text.length?text:@"上传失败", YES);
#endif
    }];
#endif
}

@end

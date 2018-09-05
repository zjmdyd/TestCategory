//
//  ZJParseManager.m
//  ButlerSugar
//
//  Created by ZJ on 3/4/16.
//  Copyright © 2016 csj. All rights reserved.
//

#import "ZJParseManager.h"
#define DefaultText @"--"

static ZJParseManager *_manager = nil;

@implementation ZJParseManager

+ (instancetype)shareManager {
    if (!_manager) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _manager = [[ZJParseManager alloc] init];
        });
    }
    
    return _manager;
}

#pragma mark - 申请历史

//+ (ZJPageSizeObjectInfo *)parseApplyHistory:(id)info {
//    ZJPageSizeObjectInfo *pObj = [ZJPageSizeObjectInfo new];
//    pObj.pageSize = [info[@"totalPage"] integerValue];
//
//    NSMutableArray *ary = [NSMutableArray array];
//    for (NSDictionary *dic in info[@"list"]) {
//        NSDictionary *noNullDic = [dic noNullDic];
//        HYApplyInfo *obj = [HYApplyInfo new];
//        [noNullDic jsonToModel:obj];
//        if (obj.applyStatus.integerValue == 0) {    // 等待审核
//            pObj.accessoryInfo = @{@"status" : @1};
//        }
//
//        [ary addObject:obj];
//    }
//
//    pObj.objects = ary;
//
//    return pObj;
//}


@end


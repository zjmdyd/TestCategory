//
//  ZJLocalizableController.m
//  TestEn
//
//  Created by ZJ on 08/08/2017.
//  Copyright © 2017 HY. All rights reserved.
//

#import "ZJLocalizableController.h"

ZJUserLanguageName const ZJUserLanguageEnglish = @"en-CN";
ZJUserLanguageName const ZJUserLanguageChinese = @"zh-Hans-CN";

ZJUserLanguageResourceName const ZJUserLanguageEnglishResource = @"en";
ZJUserLanguageResourceName const ZJUserLanguageChineseResource = @"zh-Hans";

ZJLanguageNotificationName const ZJLanguageChangedNotificationName = @"zjLanguageChanged";

#define ZJLanguageKey @"userLanguage"

static ZJLocalizableController *currentLanguage;
static NSBundle *bundle = nil;

@implementation ZJLocalizableController

// 获取当前资源文件
+ (NSBundle *)bundle {
    return bundle;
}

// 初始化语言文件
+ (void)initUserLanguage {
    ZJUserLanguageName language = [self userLanguage];   // en-CN, zh-Hans-CN
    
    if(language.length == 0 || !ZJUserIsSettingLanguage) {
        // 获取系统当前语言版本
        NSArray *languagesArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
        language = languagesArray.firstObject;
        [self synchronizeLanguageWithName:language];
        
//        if () {
//            
//        }
    }
    
    ZJUserLanguageResourceName resource = [self currentResourceWithLanguage:language];
    
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:resource ofType:@"lproj"];
    // 生成bundle
    bundle = [NSBundle bundleWithPath:path];
}

// 设置当前语言
+ (void)setUserlanguage:(ZJUserLanguageName)language {
    if([[self userLanguage] isEqualToString:language]) return;
    
    // 持久化
    [self synchronizeLanguageWithName:language];
    
    
    ZJUserLanguageResourceName resource = [self currentResourceWithLanguage:language];

    // 改变bundle的值
    NSString *path = [[NSBundle mainBundle] pathForResource:resource ofType:@"lproj"];
    bundle = [NSBundle bundleWithPath:path];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:ZJLanguageChangedNotificationName object:currentLanguage];
}

// 获取应用当前语言
+ (ZJUserLanguageName)userLanguage {
    return [[NSUserDefaults standardUserDefaults] valueForKey:ZJLanguageKey];
}

+ (void)synchronizeLanguageWithName:(NSString *)name {
    [[NSUserDefaults standardUserDefaults] setValue:name forKey:ZJLanguageKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (ZJUserLanguageResourceName)currentResourceWithLanguage:(NSString *)language {
    if ([language isEqualToString:ZJUserLanguageEnglish]) {
        return ZJUserLanguageEnglishResource;
    }else {
        return ZJUserLanguageChineseResource;
    }
}

+ (BOOL)isEnglishLanguage {
    return [[ZJLocalizableController userLanguage] isEqualToString:ZJUserLanguageEnglish];
}

@end

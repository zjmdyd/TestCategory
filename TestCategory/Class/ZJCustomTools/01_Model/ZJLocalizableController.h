//
//  ZJLocalizableController.h
//  TestEn
//
//  Created by ZJ on 08/08/2017.
//  Copyright © 2017 HY. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ZJLocalizedString(key)  [[ZJLocalizableController bundle] localizedStringForKey:(key) value:@"" table:nil]

#ifdef __cplusplus
#define ZJ_EXTERN		extern "C" __attribute__((visibility ("default")))
#else
#define ZJ_EXTERN	        extern __attribute__((visibility ("default")))
#endif

typedef NSString *ZJUserLanguageName NS_EXTENSIBLE_STRING_ENUM;
typedef NSString *ZJUserLanguageResourceName NS_EXTENSIBLE_STRING_ENUM;
typedef NSString *ZJLanguageNotificationName NS_EXTENSIBLE_STRING_ENUM;

ZJ_EXTERN ZJUserLanguageName const ZJUserLanguageEnglish;
ZJ_EXTERN ZJUserLanguageName const ZJUserLanguageChinese;

ZJ_EXTERN ZJUserLanguageResourceName const ZJUserLanguageEnglishResource;
ZJ_EXTERN ZJUserLanguageResourceName const ZJUserLanguageChineseResource;

ZJ_EXTERN ZJLanguageNotificationName const ZJLanguageChangedNotificationName;

#define kZJUserIsSettingLanguage @"userIsSettingLanguage"
#define ZJUserIsSettingLanguage [[NSUserDefaults standardUserDefaults] objectForKey:kZJUserIsSettingLanguage]

@interface ZJLocalizableController : NSObject

/**
 *  获取当前资源文件
 */
+ (NSBundle *)bundle;

/**
 *  初始化语言文件
 */
+ (void)initUserLanguage;

/**
 *  获取应用当前语言
 */
+ (ZJUserLanguageName)userLanguage;

/**
 *  设置当前语言
 */
+ (void)setUserlanguage:(ZJUserLanguageName)language;

+ (BOOL)isEnglishLanguage;

@end

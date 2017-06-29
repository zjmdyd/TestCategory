//
//  ZJFondationCategory.h
//  ZJCustomTools
//
//  Created by ZJ on 6/13/16.
//  Copyright © 2016 ZJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZJFondationCategory : NSObject

@end

@interface NSParagraphStyle (ZJParagraphStyle)

+ (NSParagraphStyle *)styleWithHeadIndent:(CGFloat)headIndent;
+ (NSParagraphStyle *)styleWithLineSpacing:(CGFloat)lineSpacing;
+ (NSParagraphStyle *)styleWithIndentSpacing:(CGFloat)indentSpacing lineSpace:(CGFloat)lineSpacing;
+ (NSParagraphStyle *)styleWithTextAlignment:(NSTextAlignment)alignment;
+ (NSParagraphStyle *)styleWithTextAlignment:(NSTextAlignment)alignment lineSpacing:(CGFloat)lineSpacing;

@end


#pragma mark - NSString

@interface NSString (ZJString)

+ (NSString *)stringWithFileName:(NSString *)name;

+ (NSArray *)sexStrings;

/**
 汉字转拼音
 */
- (NSString *)pinYin;

#pragma mark - 属性字符串

/**
 文字颜色
 */
- (NSAttributedString *)attrWithForegroundColor:(UIColor *)color;

/**
 文字字体
 */
- (NSAttributedString *)attrWithFont:(UIFont *)font;

/**
 文字对齐
 */
- (NSAttributedString *)attrWithTextAlignment:(NSTextAlignment)alignment;

/**
 文字缩进
 */
- (NSAttributedString *)attrWithFirstLineHeadIndent:(CGFloat)headIndent;

/**
 文字颜色、字体
 */
- (NSAttributedString *)attrWithForegroundColor:(UIColor *)color font:(UIFont *)font;

/**
 文字颜色、对齐
 */
- (NSAttributedString *)attrWithForegroundColor:(UIColor *)color textAlignment:(NSTextAlignment)alignment;

/**
 文字字体、对齐
 */
- (NSAttributedString *)attrWithFont:(UIFont *)font textAlignment:(NSTextAlignment)alignment;

/**
 文字颜色、字体、对齐
 */
- (NSAttributedString *)attrWithForegroundColor:(UIColor *)color font:(UIFont *)font textAlignment:(NSTextAlignment)alignment;

#pragma mark - 为指定的字符串添加属性

/**
 *  为指定range的string添加属性
 */
- (NSAttributedString *)attributedWithRange:(NSRange)range attr:(NSDictionary *)attr;

/**
 *  为指定字符串添加属性
 
 @param precises 是否是精确匹配搜索字符
 */
- (NSAttributedString *)attrWithMatchString:(NSString *)string attr:(NSDictionary *)attr precises:(BOOL)precises;

#pragma mark - 时间字符串

/**
 *  得到一个小时时间区域字符串
 *
 *  @return eg: 8:00 ---> 08:00-09:00
 */
- (NSString *)timeForOneHourRegioString;

#pragma mark - 填充字符串

/**
 *  字符串填充0
 
 @param count 数的位数, 1代表2位,2代表3位....
 @return eg: 8 ---> 08
 */
- (NSString *)fillZeroStringOfDigitCount:(NSInteger)count;

/**
 *  @"8" --> 08:00
 */
- (NSString *)fillTimeString;

#pragma mark - 翻转字符串

/**
 *  字符串翻转
 */
- (NSString *)invertString;

#pragma mark - 进制转换

/**
 *  十进制 --> 十六进制
 */
+ (NSString *)ToHex:(uint16_t)tmpid;

/**
 *  二进制 --> 十六进制
 */
+ (NSString *)binaryToHex:(NSString *)binary;

/**
 *  NSData<Byte*> --> 十六进制
 */
+ (NSString *)dataToHex:(NSData *)data;

/**
 *  十六进制 --> 二进制
 */
+ (NSString *)HexToBinary:(NSString *)hexString;

/**
 *  十六进制 --> NSData<Byte*>
 */
+ (NSData *)hexToBytes:(NSString *)hexString;

/**
 *  二进制字符串取反
 */
+ (NSString *)oppositiveBinary:(NSString *)binary;

- (BOOL)isPureInt;
- (BOOL)isPureFloat;

@end


#pragma mark - NSMutableAttributedString

@interface NSMutableAttributedString (ZJMutableAttributedString)

- (void)setLineSpacing:(CGFloat)space range:(NSRange)range;

@end


#pragma mark - NSArray

@interface NSArray (ZJNSArray)

#pragma mark - 处理数据

- (BOOL)containNumber:(NSNumber *)obj;
- (BOOL)containString:(NSString *)obj;

/**
 *  获取数组中的最值,元素须为NSNumber类型
 */
- (NSNumber *)maxValue;
- (NSNumber *)minValue;
- (NSNumber *)average;

#pragma mark - 处理数组

/**
 *  多维数组的mutableCopy
 */
- (NSArray *)multiDimensionalArrayMutableCopy;

@end


#pragma mark - NSMutableArray

@interface NSMutableArray (ZJMutableArray)

/**
 用某个特定的对象初始化数组
 */
+ (NSMutableArray *)arrayWithObject:(id)obj count:(NSInteger)count;

/**
 *  向子数组中添加元素
 */
- (void)addObject:(id)obj toSubAry:(NSMutableArray *)subAry;

- (void)replaceDicInfoAtIndex:(NSIndexPath *)indexPath value:(NSString *)value;

@end


#pragma mark - NSDictionary

@interface NSDictionary (ZJDictionary)

- (BOOL)containsKey:(NSString *)key;
- (BOOL)containsKeyCaseInsensitive:(NSString *)key;

/**
 十六进制字典
 
 @return @{
 @"0" : @"0000",
 @"1" : @"0001",....
 }*/
+ (NSDictionary *)HexDictionary;

@end


#pragma mark - NSDate

@interface NSDate (ZJDate)

- (NSDateComponents *)components;

/**
 *  判断两日期是否相等   精确到年月日
 */
- (BOOL)isEqualToDate:(NSDate *)date;

- (NSString *)timestampString;

#pragma mark - 年龄

/**
 *  日期转化成年龄
 *
 *  @return 周岁
 */
- (NSInteger)age;

/**
 *  时间戳转化成年龄
 *
 *  @return 周岁
 */
+ (NSInteger)ageWithTimeIntervel:(NSInteger)timeInterval;

#pragma mark - 天数

/**
 *  获取天数
 *
 *  @param unit > NSCalendarUnitDay
 */
- (NSInteger)numberOfDayInUnit:(NSCalendarUnit)unit;

/**
 *  获取两个日期的间隔日期
 *  @param date1 开始日期
 *  @param date2 结束日期
 */
+ (NSInteger)daySpanFromDate:(NSDate *)date1 toDate:(NSDate *)date2;

+ (NSDate *)dateWithDaySpan:(NSInteger)daySpan sinceDate:(NSDate *)date;

#pragma mark - 星期

/**
 *  @1 ---> 周一
 */
+ (NSString *)weekdayToChinese:(id)weekday;

/**
 *  格林威治时间星期
 *  @1 --> 周日
 */
+ (NSString *)gregorianWeekdayToChinese:(id)weekday;

@end


#pragma mark - NSData

@interface NSData (ZJData)

#pragma mark - Byte数值操作

- (NSInteger)valueWithIdx:(NSInteger)idx;
- (NSInteger)valueWithIdx1:(NSInteger)idx1 idx2:(NSInteger)idx2;

@end

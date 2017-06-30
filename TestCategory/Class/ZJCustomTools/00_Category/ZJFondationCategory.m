//
//  ZJFondationCategory.m
//  ZJCustomTools
//
//  Created by ZJ on 6/13/16.
//  Copyright © 2016 ZJ. All rights reserved.
//

#import "ZJFondationCategory.h"

@implementation ZJFondationCategory

@end

#pragma mark - NSParagraphStyle

@implementation NSParagraphStyle (ZJParagraphStyle)

+ (NSParagraphStyle *)styleWithHeadIndent:(CGFloat)headIndent {
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.firstLineHeadIndent = headIndent;
    
    return style;
}

+ (NSParagraphStyle *)styleWithLineSpacing:(CGFloat)lineSpacing {
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = lineSpacing;
    
    return style;
}

+ (NSParagraphStyle *)styleWithIndentSpacing:(CGFloat)indentSpacing lineSpace:(CGFloat)lineSpacing {
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = lineSpacing;
    style.headIndent = indentSpacing;
    style.firstLineHeadIndent = indentSpacing;
    style.tailIndent = -indentSpacing;
    
    return style;
}

+ (NSParagraphStyle *)styleWithTextAlignment:(NSTextAlignment)alignment {
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = alignment;
    
    return style;
}

+ (NSParagraphStyle *)styleWithTextAlignment:(NSTextAlignment)alignment lineSpacing:(CGFloat)lineSpacing {
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = alignment;
    style.lineSpacing = lineSpacing;
    
    return style;
}

@end


#pragma mark - NSString

@implementation NSString (ZJString)

+ (NSString *)stringWithFileName:(NSString *)name {
    NSError *error;
    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:name];
    NSString *string = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        NSLog(@"error = %@", error);
    }
    return string;
}

+ (NSArray *)sexStrings {
    return @[@"男", @"女"];
}

- (NSString *)pinYin {
    NSMutableString *mutableString = [NSMutableString stringWithString:self];
    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, false);
    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformStripDiacritics, false);
    
    return mutableString;
}

#pragma mark - 属性字符串 1

/**
 文字颜色
 */
- (NSAttributedString *)attrWithForegroundColor:(UIColor *)color {
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self];
    [str addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(0, str.length)];
    
    return [str copy];
}

/**
 文字字体
 */
- (NSAttributedString *)attrWithFont:(UIFont *)font {
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self];
    [str addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, str.length)];
    
    return [str copy];
}

/**
 文字对齐
 */
- (NSAttributedString *)attrWithTextAlignment:(NSTextAlignment)alignment {
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self];
    NSParagraphStyle *style = [NSParagraphStyle styleWithTextAlignment:alignment];
    [str addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, str.length)];
    
    return [str copy];
}

/**
 文字缩进
 */
- (NSAttributedString *)attrWithFirstLineHeadIndent:(CGFloat)headIndent {
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self];
    NSParagraphStyle *style = [NSParagraphStyle styleWithHeadIndent:headIndent];
    [str addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, str.length)];
    
    return str;
}

/**
 行间距
 */
- (NSAttributedString *)attrWithLineSpace:(CGFloat)lineSpace {
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self];
    NSParagraphStyle *style = [NSParagraphStyle styleWithLineSpacing:lineSpace];
    [str addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, str.length)];
    
    return str;
}

/**
 行间距 对齐
 */
- (NSAttributedString *)attrWithLineSpace:(CGFloat)lineSpace textAlignment:(NSTextAlignment)alignment {
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self];
    NSRange range = NSMakeRange(0, str.length);
    
    NSParagraphStyle *style = [NSParagraphStyle styleWithLineSpacing:lineSpace];
    [str addAttribute:NSParagraphStyleAttributeName value:style range:range];
    
    NSParagraphStyle *style2 = [NSParagraphStyle styleWithTextAlignment:alignment];
    [str addAttribute:NSParagraphStyleAttributeName value:style2 range:range];
    
    return str;
}

/**
 文字颜色、字体
 */
- (NSAttributedString *)attrWithForegroundColor:(UIColor *)color font:(UIFont *)font {
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self];
    
    NSRange range = NSMakeRange(0, str.length);
    [str addAttribute:NSForegroundColorAttributeName value:color range:range];
    [str addAttribute:NSFontAttributeName value:font range:range];
    
    return [str copy];
}

/**
 文字颜色、对齐
 */
- (NSAttributedString *)attrWithForegroundColor:(UIColor *)color textAlignment:(NSTextAlignment)alignment {
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self];
    
    NSRange range = NSMakeRange(0, str.length);
    [str addAttribute:NSForegroundColorAttributeName value:color range:range];
    
    NSParagraphStyle *style = [NSParagraphStyle styleWithTextAlignment:alignment];
    [str addAttribute:NSParagraphStyleAttributeName value:style range:range];
    
    return [str copy];
}

/**
 文字字体、对齐
 */
- (NSAttributedString *)attrWithFont:(UIFont *)font textAlignment:(NSTextAlignment)alignment {
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self];
    
    NSRange range = NSMakeRange(0, str.length);
    [str addAttribute:NSFontAttributeName value:font range:range];
    
    NSParagraphStyle *style = [NSParagraphStyle styleWithTextAlignment:alignment];
    [str addAttribute:NSParagraphStyleAttributeName value:style range:range];
    
    return [str copy];
}

/**
 文字颜色、字体、对齐
 */
- (NSAttributedString *)attrWithForegroundColor:(UIColor *)color font:(UIFont *)font textAlignment:(NSTextAlignment)alignment {
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:self];
    
    NSRange range = NSMakeRange(0, str.length);
    [str addAttribute:NSForegroundColorAttributeName value:color range:range];
    [str addAttribute:NSFontAttributeName value:font range:range];
    
    NSParagraphStyle *style = [NSParagraphStyle styleWithTextAlignment:alignment];
    [str addAttribute:NSParagraphStyleAttributeName value:style range:range];
    
    return [str copy];
}

#pragma mark - 属性字符串 2

- (NSAttributedString *)attributedWithRange:(NSRange)range attr:(NSDictionary *)attr {
    NSMutableAttributedString *backStr = [[NSMutableAttributedString alloc] initWithString:self];
    [backStr setAttributes:attr range:range];
    
    return [backStr copy];
}

- (NSAttributedString *)attrWithMatchString:(NSString *)string attr:(NSDictionary *)attr precises:(BOOL)precises {
    NSMutableArray *indexs = [NSMutableArray array];
    NSMutableAttributedString *backStr = [[NSMutableAttributedString alloc] initWithString:self];
    
    if (precises) {
        for (int i = 0; i < self.length;) {
            NSRange range = NSMakeRange(i, string.length);
            if (range.length + range.location <= backStr.length) {
                NSString *str = [self substringWithRange:range];
                if ([str isEqualToString:string]) {
                    [backStr setAttributes:attr range:range];
                    i += string.length;
                }else {
                    i++;
                }
            }else {     // 未找到匹配字符串则退出
                break;
            }
        }
    }else {
        for (int i = 0; i < string.length; i++) {
            NSString *s1 = [string substringWithRange:NSMakeRange(i, 1)];
            for (int j = 0; j < backStr.length; j++) {
                NSRange range = NSMakeRange(j, 1);
                NSString *s2 = [self substringWithRange:range];
                if ([s1 isEqualToString:s2] && [indexs containNumber:@(j)] == NO) {
                    [backStr setAttributes:attr range:range];
                    [indexs addObject:@(j)];
                    
                    break;
                }
            }
        }
    }
    
    
    return [backStr copy];
}

#pragma mark - 时间字符串

- (NSString *)timeForOneHourRegioString {
    NSArray *strs = [self componentsSeparatedByString:@":"];
    
    NSString *s0 = [NSString stringWithFormat:@"%zd", [strs.firstObject integerValue] + 1];
    return [NSString stringWithFormat:@"%@:%@-%@:%@", [strs[0] fillZeroStringOfDigitCount:1], strs[1], [s0 fillZeroStringOfDigitCount:1], strs[1]];
}

#pragma mark - 填充字符串

- (NSString *)fillZeroStringOfDigitCount:(NSInteger)count {
    NSMutableString *str = [NSMutableString stringWithFormat:@"%@", self];
    
    if (self.integerValue < powl(10, count)) {
        NSInteger len = count + 1 - self.length;
        for (int i = 0; i < len; i++) {
            [str insertString:@"0" atIndex:0];
        }
    }
    return [str mutableCopy];
}

- (NSString *)fillTimeString {
    NSString *str = [self fillZeroStringOfDigitCount:1];
    return [NSString stringWithFormat:@"%zd:00", str];
}

#pragma mark - 翻转字符串

- (NSString *)invertString {
    NSMutableString *str = [NSMutableString string];
    for (NSUInteger i = self.length; i > 0; i--) {
        [str appendString:[self substringWithRange:NSMakeRange(i-1, 1)]];
    }
    return [str mutableCopy];
}

#pragma mark - 进制转换

+ (NSString *)ToHex:(uint16_t)tmpid {
    NSString *nLetterValue;
    NSString *str = @"";
    uint16_t ttmpig;
    for (int i = 0; i < 9; i++) {
        ttmpig = tmpid % 16; // 256 % 16 = 0;  --> 0 --> 0
        tmpid = tmpid / 16;  // 256 / 16 = 16; --> 1 --> 0
        switch (ttmpig) {
            case 10:
                nLetterValue = @"A"; break;
            case 11:
                nLetterValue = @"B"; break;
            case 12:
                nLetterValue = @"C"; break;
            case 13:
                nLetterValue = @"D"; break;
            case 14:
                nLetterValue = @"E"; break;
            case 15:
                nLetterValue = @"F"; break;
            default:
                nLetterValue = [NSString stringWithFormat:@"%u", ttmpig];    //0 ----> 0 ----> 1
        }
        str = [nLetterValue stringByAppendingString:str];   // 0 ----> 00 ----> 100
        if (tmpid == 0) {
            break;
        }
    }
    return [str mutableCopy];
}

+ (NSString *)binaryToHex:(NSString *)binary {
    NSDictionary *hexDic = [NSDictionary HexDictionary];
    
    NSMutableString *HexString = [[NSMutableString alloc] init];
    for (int i = 0; i < binary.length; i+=4) {
        NSString *value = [binary substringWithRange:NSMakeRange(i, 4)];       // 取出二进制里面的每4位数对应的value
        for (NSString *key in hexDic.allKeys) {
            if ([[hexDic objectForKey:key] isEqualToString:value]) {
                [HexString appendString:key];
                break;
            }
        }
    }
    
    return [HexString mutableCopy];
}

+ (NSString *)dataToHex:(NSData *)data {
    if (!data) return nil;
    
    Byte *bytes = (Byte *)[data bytes];
    NSMutableString *str = [NSMutableString stringWithCapacity:data.length * 2];
    for (int i = 0; i < data.length; i++){
        [str appendFormat:@"%0x", bytes[i]];
    }
    return [str mutableCopy];
}

+ (NSString *)HexToBinary:(NSString *)hexString {
    NSDictionary *hexDic = [NSDictionary HexDictionary];
    
    NSMutableString *binaryString = [[NSMutableString alloc] init];
    
    for (int i = 0; i < hexString.length; i++) {
        NSString *key = [hexString substringWithRange:NSMakeRange(i, 1)];       // 取出16进制里面的每一位数对应的key
        NSString *value = [NSString stringWithFormat:@"%@", [hexDic objectForKey:[key uppercaseString]]];
        binaryString = [NSString stringWithFormat:@"%@%@", binaryString, value].mutableCopy;
    }
    
    return [binaryString mutableCopy];
}

+ (NSData *)hexToBytes:(NSString *)hexString {
    NSMutableData* data = [NSMutableData data];
    int idx;
    for (idx = 0; idx+2 <= hexString.length; idx += 2) {
        NSRange range = NSMakeRange(idx, 2);
        NSString *hexStr = [hexString substringWithRange:range];
        NSScanner *scanner = [NSScanner scannerWithString:hexStr];
        unsigned int intValue;
        [scanner scanHexInt:&intValue];
        [data appendBytes:&intValue length:1];
    }
    return data;
}

+ (NSString *)oppositiveBinary:(NSString *)binary {
    NSMutableString *str = [NSMutableString string];
    for (int i = 0; i < binary.length; i++) {
        NSRange range = NSMakeRange(i, 1);
        NSUInteger value = [binary substringWithRange:range].integerValue;
        [str appendString:[NSString stringWithFormat:@"%zd", (value+1)%2]];
    }
    return [str mutableCopy];
}

// 1. 整形判断
- (BOOL)isPureInt {
    NSScanner* scan = [NSScanner scannerWithString:self];
    NSInteger val;
    return [scan scanInteger:&val] && [scan isAtEnd];
}

// 2.浮点形判断：
- (BOOL)isPureFloat {
    NSScanner* scan = [NSScanner scannerWithString:self];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

@end


#pragma mark - NSMutableAttributedString

@implementation NSMutableAttributedString (ZJMutableAttributedString)

- (void)setLineSpacing:(CGFloat)space range:(NSRange)range {
    if (self) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:space];
        [self addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    }
}

@end


#pragma mark - NSArray

@implementation NSArray (ZJNSArray)

#pragma mark - 处理数据

- (BOOL)containNumber:(NSNumber *)obj {
    for (NSNumber *num in self) {
        if ([obj isEqualToNumber:num]) {
            return YES;
        }
    }
    
    return NO;
}

- (BOOL)containString:(NSString *)obj {
    for (NSString *str in self) {
        if ([obj isEqualToString:str]) {
            return YES;
        }
    }
    
    return NO;
}

- (NSNumber *)maxValue {
    CGFloat max = FLT_MIN;
    for (int i = 0; i < self.count; i++) {
        NSNumber *value = self[i];
        if ([value isKindOfClass:[NSNumber class]]) {
            if (max < value.floatValue) {
                max = value.floatValue;
                break;
            }
        }
    }
    
    return @(max);
}

- (NSNumber *)minValue {
    CGFloat min = FLT_MAX;
    for (int i = 0; i < self.count; i++) {
        NSNumber *value = self[i];
        if ([value isKindOfClass:[NSNumber class]]) {
            if (min > value.floatValue) {
                min = value.floatValue;
                break;
            }
        }
    }
    
    return @(min);
}

- (NSNumber *)average {
    CGFloat sum = 0.0;
    for (int i = 0; i < self.count; i++) {
        NSNumber *value = self[i];
        if ([value isKindOfClass:[NSNumber class]]) {
            sum += value.floatValue;
        }
    }
    
    return @(sum/self.count);
}

#pragma mark - 处理数组

- (NSArray *)multiDimensionalArrayMutableCopy {
    NSMutableArray *array = [NSMutableArray array];
    for (id obj in self) {
        if ([obj isKindOfClass:[NSArray class]]) {
            [array addObject:[obj multiDimensionalArrayMutableCopy]];
        }else {
            [array addObject:[obj mutableCopy]];
        }
    }
    
    return [array mutableCopy];
}

@end


#pragma mark - NSMutableArray

@implementation NSMutableArray (ZJMutableArray)

+ (NSMutableArray *)arrayWithObject:(id)obj count:(NSInteger)count {
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        [array addObject:obj?:@""];
    }
    
    return array;
}

- (void)addObject:(id)obj toSubAry:(NSMutableArray *)subAry {
    if (subAry) {
        [subAry addObject:obj];
        if (![self containsObject:subAry]) {
            [self addObject:subAry];
        }
    }else {
        subAry = [NSMutableArray array];
        [subAry addObject:obj];
        [self addObject:subAry];
    }
}

- (void)replaceDicInfoAtIndex:(NSIndexPath *)indexPath value:(NSString *)value {
    NSDictionary *dic = self[indexPath.row];
    NSString *val = dic[dic.allKeys.firstObject];
    if ([val isEqualToString:value]) {  // 如果相同就不需要更新
        return;
    }
    
    dic = @{dic.allKeys.firstObject : value};
    [self replaceObjectAtIndex:indexPath.row withObject:dic];
}

@end


#pragma mark - NSDictionary

@implementation NSDictionary (ZJDictionary)

- (BOOL)containsKey:(NSString *)key {
    for (NSString *str in self.allKeys) {
        if ([str isEqualToString:key]) {
            return YES;
        }
    }
    
    return NO;
}

- (BOOL)containsKeyCaseInsensitive:(NSString *)key {
    for (NSString *str in self.allKeys) {
        if ([str caseInsensitiveCompare:key] == NSOrderedSame) {
            return YES;
        }
    }
    
    return NO;
}

+ (NSDictionary *)HexDictionary {
    NSMutableDictionary *hexDic = [[NSMutableDictionary alloc] init];
    hexDic = [[NSMutableDictionary alloc] initWithCapacity:16];
    NSArray *keys = @[@"A", @"B", @"C", @"D", @"E", @"F"];
    NSArray *values = @[@"0000", @"0001", @"0010", @"0011", @"0100", @"0101", @"0110", @"0111", @"1000", @"1001", @"1010", @"1011", @"1100", @"1101", @"1110", @"1111"];
    for (int i = 0; i < values.count; i++) {
        [hexDic setObject:values[i] forKey:[NSString stringWithFormat:@"%@", i<10?@(i):keys[i-10]]];
    }
    
    return [hexDic mutableCopy];
}

@end


#pragma mark - NSDate

@implementation NSDate (CompareDate)

- (NSDateComponents *)components {
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday fromDate:self];
    
    return comps;
}

- (BOOL)isEqualToDate:(NSDate *)date {
    NSDateComponents *componentsA = self.components;
    NSDateComponents *componentsB = date.components;
    return componentsA.year == componentsB.year && componentsA.month == componentsB.month && componentsA.day == componentsB.day;
}

- (NSString *)timestampString {
    return @((NSInteger)[[NSDate date] timeIntervalSince1970]).stringValue;
}

#pragma mark - 年龄

- (NSInteger)age {
    // 出生日期转换 年月日
    NSDateComponents *comp1 = [self components];
    NSInteger brithYear  = [comp1 year];
    NSInteger brithMonth = [comp1 month];
    NSInteger brithDay   = [comp1 day];
    
    // 获取系统当前 年月日
    NSDateComponents *comp2 = [[NSDate date] components];
    NSInteger currentYear  = [comp2 year];
    NSInteger currentMonth = [comp2 month];
    NSInteger currentDay   = [comp2 day];
    
    // 计算年龄
    NSInteger iAge = currentYear - brithYear - 1;
    if ((currentMonth > brithMonth) || (currentMonth == brithMonth && currentDay >= brithDay)) {
        iAge++;
    }
    
    return iAge;
}

+ (NSInteger)ageWithTimeIntervel:(NSInteger)timeInterval {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    return [date age];
}

#pragma mark - 天数

- (NSInteger)numberOfDayInUnit:(NSCalendarUnit)unit {
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSRange range = [cal rangeOfUnit:NSCalendarUnitDay inUnit:unit forDate:self];
    
    return range.length;
}

+ (NSInteger)daySpanFromDate:(NSDate *)date1 toDate:(NSDate *)date2 {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [gregorian setFirstWeekday:2];  // 设置每周的第一天从星期几开始，比如：1代表星期日开始，2代表星期一开始，以此类推。默认值是1
    
    NSDate *fromDate, *toDate;
    
    [gregorian rangeOfUnit:NSCalendarUnitDay startDate:&fromDate interval:NULL forDate:date1];
    [gregorian rangeOfUnit:NSCalendarUnitDay startDate:&toDate interval:NULL forDate:date2];
    
    NSDateComponents *dayComponents = [gregorian components:NSCalendarUnitDay fromDate:fromDate toDate:toDate options:0];
    return dayComponents.day;
}

+ (NSDate *)dateWithDaySpan:(NSInteger)daySpan sinceDate:(NSDate *)date {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    return [gregorian dateByAddingUnit:NSCalendarUnitDay value:daySpan toDate:date options:NSCalendarMatchStrictly];
}

#pragma mark - 星期

+ (NSString *)weekdayToChinese:(id)weekday {
    NSArray *weekdays = @[@"周一", @"周二", @"周三", @"周四", @"周五", @"周六", @"周日"];
    for (int i = 0; i <= weekdays.count; i++) {
        if (i+1 == [weekday integerValue]) return weekdays[i];
    }
    
    return @"参数错误";
}

+ (NSString *)gregorianWeekdayToChinese:(id)weekday {
    NSArray *weekdays = @[@"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六"];
    for (int i = 1; i <= weekdays.count; i++) {
        if (i+1 == [weekday integerValue]) return weekdays[i];
    }
    
    return @"参数错误";
}

@end


#pragma mark - NSData

@implementation NSData (ZJData)

#pragma mark - Byte数值操作


- (NSInteger)valueWithIdx:(NSInteger)idx {
    Byte *bytes = (Byte *)self.bytes;
    
    return bytes[idx];
}

- (NSInteger)valueWithIdx1:(NSInteger)idx1 idx2:(NSInteger)idx2 {
    Byte *bytes = (Byte *)self.bytes;
    
    char chs[2];
    chs[0] = bytes[idx1];
    chs[1] = bytes[idx2];
    return *(short *)chs;
}

@end

//
//  NSString+JJNSStringExt.m
//  JJNSStringTool
//
//  Created by lucy on 2017/12/15.
//  Copyright © 2017年 com.daoKeLegend. All rights reserved.
//

#import "NSString+JJNSStringExt.h"

@implementation NSString (JJNSStringExt)

//json转数组

- (NSArray *)jj_jsonToArray
{
    id json = [self jsonValue];
    return [json isKindOfClass:NSArray.class] ? json : nil;
}

- (id)jsonValue
{
    NSError *error = nil;
    id jsonObj = [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:&error];
    if (error) {
        NSLog(@"JSON: %@\nparse error: %@", self, error);
        return jsonObj;
    }
    return jsonObj;
}


//字符串转义

- (NSString *)jj_encodedString
{
    NSString *result = CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, NULL, CFSTR("!*'();:@&=+$,/?%#[]"), kCFStringEncodingUTF8));
    return result;
}

- (NSString *)jj_decodedString
{
    NSString *result = CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault, (CFStringRef)self, CFSTR(""), kCFStringEncodingUTF8));
    return result;
}

//URL 转义

- (NSURL *)jj_encodeURL
{
    NSString *collectUrl = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *urlEncodeString = [collectUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlEncodeString];
    return url;
}


//密码太弱

- (BOOL)jj_isPasswordWeak
{
    if ([self isEqualToString:@"112233"] ||
        [self isEqualToString:@"123123"] ||
        [self isEqualToString:@"123321"] ||
        [self isEqualToString:@"abcabc"] ||
        [self isEqualToString:@"abc123"] ||
        [self isEqualToString:@"a1b2c3"] ||
        [self isEqualToString:@"aaa111"] ||
        [self isEqualToString:@"123qwe"] ||
        [self isEqualToString:@"qweasd"] ||
        [self isEqualToString:@"admin"]  ||
        [self isEqualToString:@"password"] ||
        [self isEqualToString:@"p@ssword"] ||
        [self isEqualToString:@"passwd"] ||
        [self isEqualToString:@"iloveyou"] ||
        [self isEqualToString:@"5201314"]||
        [self isEqualToString:@"asdfghjkl"]||
        [self isEqualToString:@"qwerty"]) {
        return YES;
    }
    NSString *CT_NUM = @"^(0{6,16})|(1{6,16})|(2{6,16})|(3{6,16})|(4{6,16})|(5{6,16})|(6{6,16})|(7{6,16})|(8{6,16})|(9{6,16})|(a{6,16})|(b{6,16})|(c{6,16})|(d{6,16})|(e{6,16})|(f{6,16})|(g{6,16})|(h{6,16})|(i{6,16})|(j{6,16})|(k{6,16})|(l{6,16})|(m{6,16})|(n{6,16})|(o{6,16})|(p{6,16})|(q{6,16})|(r{6,16})|(s{6,16})|(t{6,16})|(u{6,16})|(v{6,16})|(w{6,16})|(x{6,16})|(y{6,16})|(z{6,16})|(A{6,16})|(B{6,16})|(C{6,16})|(D{6,16})|(E{6,16})|(F{6,16})|(G{6,16})|(H{6,16})|(I{6,16})|(J{6,16})|(K{6,16})|(L{6,16})|(M{6,16})|(N{6,16})|(O{6,16})|(P{6,16})|(Q{6,16})|(R{6,16})|(S{6,16})|(T{6,16})|(U{6,16})|(V{6,16})|(W{6,16})|(X{6,16})|(Y{6,16})|(Z{6,16})$";//
    NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
    BOOL isMatch1 = [pred1 evaluateWithObject:self];
    if (isMatch1==YES) {
        return YES;
    }
    NSString *model = @"0123456789";
    NSString *alphe = @"abcdefghijklmnopqrstuvwxyz";
    NSString *alphe2 = @"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    if ([model rangeOfString:self].location != NSNotFound) {
        return YES;
    }
    
    if ([alphe rangeOfString:self].location != NSNotFound) {
        return YES;
    }
    
    if ([alphe2 rangeOfString:self].location != NSNotFound) {
        return YES;
    }
    return NO;
}

//获取多行文字的宽高

- (CGSize)jj_sizeWithFont:(UIFont *)font andMaxSize:(CGSize)maxSzie
{
    if (![font isKindOfClass:[UIFont class]]) {
        font = [UIFont systemFontOfSize:13];
    }
    if (NSFontAttributeName == nil || font == nil) {
        return CGSizeZero;
    }
    NSDictionary *atte = @{NSFontAttributeName : font};
    return  [self boundingRectWithSize:maxSzie options:NSStringDrawingUsesLineFragmentOrigin attributes:atte context:nil].size;
}

//获取拼音的首字母

- (NSString *)jj_gainPinYinFirstCharacter
{
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:self];
    
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    
    //转化为大写拼音
    NSString *pinYin = [str capitalizedString];
    
    //获取并返回首字母
    return [pinYin substringToIndex:1];
}

//判断是否是小数

- (BOOL)jj_isFloatNumber
{
    NSString *regex = @"^-?([1-9]\\d*\\.\\d*|0\\.\\d*[1-9]\\d*|0?\\.0+|0)$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:self];
}

// 判断是否是整数

- (BOOL)jj_isIntNumber
{
    NSString *regex = @"^-?[0-9]\\d*$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:self];
}

//身份证号码验证

- (BOOL)jj_isCardIdValid
{
    NSString * cardId = self;
    cardId = [cardId stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSUInteger length =0;
    if (!cardId) {
        return NO;
    }
    else {
        length = cardId.length;
        
        if (length !=15 && length !=18) {
            return NO;
        }
    }
    // 省份代码
    NSArray *areasArray =@[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41", @"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
    
    NSString *valueStart2 = [cardId substringToIndex:2];
    BOOL areaFlag =NO;
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag =YES;
            break;
        }
    }
    
    if (!areaFlag) {
        return false;
    }
    
    
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    
    int year =0;
    switch (length) {
        case 15:
            year = [cardId substringWithRange:NSMakeRange(6,2)].intValue +1900;
            
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }
            else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:cardId
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, cardId.length)];
            
            
            if(numberofMatch >0) {
                return YES;
            }
            else {
                return NO;
            }
        case 18:
            
            year = [cardId substringWithRange:NSMakeRange(6,4)].intValue;
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }
            else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:cardId
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, cardId.length)];
            
            
            if(numberofMatch >0) {
                int S = ([cardId substringWithRange:NSMakeRange(0,1)].intValue + [cardId substringWithRange:NSMakeRange(10,1)].intValue) *7 +
                ([cardId substringWithRange:NSMakeRange(1,1)].intValue + [cardId substringWithRange:NSMakeRange(11,1)].intValue) *9 +
                ([cardId substringWithRange:NSMakeRange(2,1)].intValue + [cardId substringWithRange:NSMakeRange(12,1)].intValue) *10 +
                ([cardId substringWithRange:NSMakeRange(3,1)].intValue + [cardId substringWithRange:NSMakeRange(13,1)].intValue) *5 +
                ([cardId substringWithRange:NSMakeRange(4,1)].intValue + [cardId substringWithRange:NSMakeRange(14,1)].intValue) *8 +
                ([cardId substringWithRange:NSMakeRange(5,1)].intValue + [cardId substringWithRange:NSMakeRange(15,1)].intValue) *4 +
                ([cardId substringWithRange:NSMakeRange(6,1)].intValue + [cardId substringWithRange:NSMakeRange(16,1)].intValue) *2 +
                [cardId substringWithRange:NSMakeRange(7,1)].intValue *1 + [cardId substringWithRange:NSMakeRange(8,1)].intValue *6 +
                [cardId substringWithRange:NSMakeRange(9,1)].intValue *3;
                int Y = S %11;
                NSString *M =@"F";
                NSString *JYM =@"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y,1)];// 判断校验位
                if ([M isEqualToString:[cardId substringWithRange:NSMakeRange(17,1)]]) {
                    return YES;// 检测ID的校验位
                }
                else {
                    return NO;
                }
            }
            else {
                return NO;
            }
        default:
            return NO;
    }
    return NO;
}

/*
 是否是手机号的判定
 
 移动：139 138 137 136 135 134 147 188 187 184 183 182 178 159 158 157 152 151 150 1703 1705 1706 198
 联通：186 185 176 145 156 155 132 131 130 175 176 1704 1707 1708 1709 171 166
 电信：189 181 180 177 153 133 173 1700 1701 1702 199
 */

- (BOOL)jj_isPhoneNumberWithStr:(NSString *)str
{
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (str.length != 11) {
        return NO;
    }
    else {
        
        //移动
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8])|(198))\\d{8}|(170[3,5,6])\\d{7}$";
        //联通
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(17[5,6])|(18[5,6])|(166))\\d{8}|(170[4,7-9])\\d{7}|171[0-9]\\d{7}$";
        //电信
        NSString *CT_NUM = @"^((133)|(153)|(17[3,7])|(18[0,1,9])|(199))\\d{8}|(170[0-2])\\d{7}$";
        
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:str];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:str];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:str];
        if (isMatch1 || isMatch2 || isMatch3) {
            return YES;
        }
        else {
            return NO;
        }
    }
}

//根据字符串长度获取字符串尺寸

- (CGSize)jj_textSizeWithFont:(UIFont *)font
            constrainedToSize:(CGSize)size
{
    CGSize textSize;
    
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
        textSize = [self sizeWithAttributes:attributes];
        textSize = CGSizeMake(floor(size.width), floor(size.height));
    }
    else {
        NSStringDrawingOptions option = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
        
        //NSStringDrawingTruncatesLastVisibleLine如果文本内容超出指定的矩形限制，文本将被截去并在最后一个字符后加上省略号。 如果指定了NSStringDrawingUsesLineFragmentOrigin选项，则该选项被忽略 NSStringDrawingUsesFontLeading计算行高时使用行间距。（译者注：字体大小+行间距=行高）
        
        NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
        
        CGRect rect = [self boundingRectWithSize:size options:option attributes:attributes context:nil];
        textSize = rect.size;
        
        //注意：当字符串同时存在@和&字符时，使用NSStringDrawingUsesLineFragmentOrigin时rect会变为零
        if (CGSizeEqualToSize(textSize, CGSizeZero)) {
            option = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading;
            rect = [self boundingRectWithSize:size options:option attributes:attributes context:nil];
            textSize = rect.size;
        }
    }
    return textSize;
}

@end

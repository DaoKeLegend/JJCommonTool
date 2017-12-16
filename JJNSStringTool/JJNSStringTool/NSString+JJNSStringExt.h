//
//  NSString+JJNSStringExt.h
//  JJNSStringTool
//
//  Created by lucy on 2017/12/15.
//  Copyright © 2017年 com.daoKeLegend. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (JJNSStringExt)

//json转NSString

//+ (NSString *)jj_stringWithJSONObject:(id)object;

//json转数组

- (NSArray *)jj_jsonToArray;

//字符串转义

- (NSString *)jj_encodedString;

- (NSString *)jj_decodedString;

//URL转义

- (NSURL *)jj_encodeURL;

//密码太弱

- (BOOL)jj_isPasswordWeak;

//获取多行文字的宽高

- (CGSize)jj_sizeWithFont:(UIFont *)font andMaxSize:(CGSize)maxSzie;

//获取拼音的首字母

- (NSString *)jj_gainPinYinFirstCharacter;

//判断是否是小数

- (BOOL)jj_isFloatNumber;

// 判断是否是整数

- (BOOL)jj_isIntNumber;

//身份证号码验证

- (BOOL)jj_isCardIdValid;

//根据字符串长度获取字符串尺寸

- (CGSize)jj_textSizeWithFont:(UIFont *)font
            constrainedToSize:(CGSize)size;

//是否是手机号的判定

- (BOOL)jj_isPhoneNumberWithStr:(NSString *)str;

@end

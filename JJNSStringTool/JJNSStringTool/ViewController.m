//
//  ViewController.m
//  JJNSStringTool
//
//  Created by lucy on 2017/12/15.
//  Copyright © 2017年 com.daoKeLegend. All rights reserved.
//

#import "ViewController.h"
#import "NSString+JJNSStringExt.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - Override Base Function

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self jsonToNSArray];
}

//json转数组

- (void)jsonToNSArray
{
    NSString *str = @"one, two, three";
    NSArray *arr = [str jj_jsonToArray];
    NSLog(@"arr = %@", arr);
}

// json转NSString

- (void)jsonToNSString
{
//    id object = {"v":"4.13.0","fr":8,"ip":0};
//    NSString *result = [NSString jj_stringWithJSONObject:object];
//    NSLog(@"result = %@", result);
}

- (void)decodeString
{
    NSString *str = @"womendejia";
    NSString *result = [str jj_decodedString];
    NSLog(@"result = %@", result);
    
    NSString *str1 = @"ode%E5%AE%B6";
    NSString *result1 = [str1 jj_decodedString];
    NSLog(@"result1 = %@", result1);
}


- (void)encodeString
{
    NSString *str = @"womendejia";
    NSString *result = [str jj_encodedString];
    NSLog(@"result = %@", result);
    
    NSString *str1 = @"ode家";
    NSString *result1 = [str1 jj_encodedString];
    NSLog(@"result1 = %@", result1);
}

// URL 转义

- (void)encodeURL
{
    NSString *str = @"http://www.baidu.com?a=我的家";
    NSURL *result = [str jj_encodeURL];
    NSLog(@"result = %@", result);
    
    NSString *str1 = @"http://www.baidu.com?a=b";
    NSURL *result1 = [str1 jj_encodeURL];
    NSLog(@"result1 = %@", result1);
}

//密码太弱

- (void)evaluateWeakPassword
{
    NSString *str = @"123456";
    BOOL result = [str jj_isPasswordWeak];
    NSLog(@"result = %d", result);
    
    NSString *str1 = @"eoowehohowh";
    BOOL result1 = [str1 jj_isPasswordWeak];
    NSLog(@"result1 = %d", result1);
}

//计算多行文本的尺寸

- (void)calculateMultiLineSize
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100.0, 100.0, 250, 500)];
    label.backgroundColor = [UIColor blueColor];
    label.text = @"这是什么鬼👻☺这是什么鬼👻☺这是什么鬼👻☺这是什么鬼👻☺这是什么鬼👻☺这是什么鬼👻☺这是什么鬼👻☺这是什么鬼👻☺";
    label.numberOfLines = 0;
    [label sizeToFit];
    [self.view addSubview:label];
    
    CGSize size = [label.text jj_sizeWithFont:[UIFont systemFontOfSize:20.0] andMaxSize:CGSizeMake(250, MAXFLOAT)];
    NSLog(@"%lf --- %lf", size.width, size.height);
}

//获取拼音首字母

- (void)gainPinYinFirstChracter
{
    NSString *str = @"womendejia";
    NSString *result = [str jj_gainPinYinFirstCharacter];
    NSLog(@"result = %@", result);
    
    NSString *str1 = @"ǎi";
    NSString *result1 = [str1 jj_gainPinYinFirstCharacter];
    NSLog(@"result1 = %@", result1);
}

//是否是小数

- (void)isFloatNumber
{
    NSString *str = @"12.13";
    BOOL result = [str jj_isFloatNumber];
    NSLog(@"result = %d", result);
    
    NSString *str1 = @"999";
    BOOL result1 = [str1 jj_isFloatNumber];
    NSLog(@"result1 = %d", result1);
}

//身份证号验证

- (void)isCardValid
{
    NSString *str = @"230606198808143611";
    BOOL result = [str jj_isCardIdValid];
    NSLog(@"result = %d", result);
    
    NSString *str1 = @"990606198808183611";
    BOOL result1 = [str1 jj_isCardIdValid];
    NSLog(@"result1 = %d", result1);
}

//是否是手机号的判定

- (void)isPhoneNumber
{
    NSString *str = @"18613546782";
    BOOL result = [str jj_isPhoneNumberWithStr:str];
    NSLog(@"result = %d", result);
    
    NSString *str1 = @"11111111111";
    BOOL result1 = [str1 jj_isPhoneNumberWithStr:str1];
    NSLog(@"result1 = %d", result1);
}

//计算字符串宽度

- (void)calculateStrWidth
{
    NSString *str = @"我们是一家人";
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:button];
    [button setTitle:str forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:17.0];
    button.backgroundColor = [UIColor blueColor];
    CGSize size = [str jj_textSizeWithFont:button.titleLabel.font constrainedToSize:CGSizeMake(MAXFLOAT, 22.0)];
    button.frame = CGRectMake(100.0, 150.0, size.width + 20.0, 30.0);
    NSLog(@"button = %@", button);
}

@end

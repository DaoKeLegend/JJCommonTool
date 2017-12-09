//
//  ViewController.m
//  JJDigitalDetection
//
//  Created by lucy on 2017/12/9.
//  Copyright © 2017年 com.daoKeLegend. All rights reserved.
//

#import "ViewController.h"
#include <ctype.h>

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - Override Base Function

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self numberDetectionViaCFunctionWithStr:@"women我 * & 们1213,,,---"];
    
    [self numberDetectionViaScannerFunctionWithStr:@"99"];
    
    [self numberDetectionViaScannerFunctionWithStr:@"8BBA9"];
    
    [self numberDetectionViaScannerFunctionWithStr:@"PPP0BBA9"];
}

#pragma mark - Object Private Function

//整形判断，用于判断指定的字符串是否是数组

- (void)numberDetectionViaScannerFunctionWithStr:(NSString *)str
{
    int number = 0;
    NSScanner *scanner = [NSScanner scannerWithString:str];
    if ([scanner scanInt:&number]) {
        NSLog(@"YES");
    }
    else {
        NSLog(@"NO");
    }
    NSLog(@"整形判断_number = %d", number);
}

//C语言监测

- (void)numberDetectionViaCFunctionWithStr:(NSString *)str
{
    NSInteger number = 0;
    for (NSInteger i = 0; i < str.length; i ++) {
        unichar cChar = [str characterAtIndex:i];
        if (isdigit(cChar)) {
            number ++;
        }
    }
    NSLog(@"C语言监测_number = %ld", number);
}

@end
























//
//  ViewController.m
//  JJCommonTool
//
//  Created by lucy on 2017/12/7.
//  Copyright © 2017年 com.daoKeLegend. All rights reserved.
//

#import "ViewController.h"
#import "JJCommonTool.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - Override Base Function

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self isNSStringChinessWithStr:@"我是个汉字吗？aaa"];
    [self isNSStringChinessWithStr:@"我是个111汉字拉吗？aaa"];
    [self isNSStringChinessWithStr:@"--  我是个汉字谷歌吗？aaa"];
}

#pragma mark - Object Private Function

- (void)isNSStringChinessWithStr:(NSString *)str
{
    NSInteger number = 0;
    for (int i = 0; i < str.length; i++)
    {
        unichar aChar = [str characterAtIndex:i];
        
        if ([JJCommonTool isChinese:aChar])
        {
            number ++;
        }
    }
    NSLog(@"number = %ld", number);
}

@end

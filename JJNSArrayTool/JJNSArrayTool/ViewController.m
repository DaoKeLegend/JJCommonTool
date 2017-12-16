//
//  ViewController.m
//  JJNSArrayTool
//
//  Created by lucy on 2017/12/16.
//  Copyright © 2017年 com.daoKeLegend. All rights reserved.
//

#import "ViewController.h"
#import "NSArray+JJTool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self deleteSameElements];
}

#pragma mark - Object Private Function

//数组的去重

- (void)deleteSameElements
{
    NSArray *arr = @[@"one", @"two", @"three", @"one"];
    NSArray *result = [arr jj_distinctSameElements];
    NSLog(@"result = %@", result);
}

@end

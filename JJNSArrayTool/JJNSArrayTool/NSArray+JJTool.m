//
//  NSArray+JJTool.m
//  JJNSArrayTool
//
//  Created by lucy on 2017/12/16.
//  Copyright © 2017年 com.daoKeLegend. All rights reserved.
//

#import "NSArray+JJTool.h"

@implementation NSArray (JJTool)

//数组去重

- (NSArray *)jj_distinctSameElements
{
    NSMutableOrderedSet *set = [NSMutableOrderedSet orderedSetWithArray:self];
    return [set array];
}

@end

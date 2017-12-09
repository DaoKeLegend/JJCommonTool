//
//  JJCommonTool.m
//  JJCommonTool
//
//  Created by lucy on 2017/12/9.
//  Copyright © 2017年 com.daoKeLegend. All rights reserved.
//

#import "JJCommonTool.h"

@implementation JJCommonTool

//是否为汉字

+ (BOOL)isChinese:(unichar)aChar
{
    if (0x4e00 <= aChar && aChar <= 0x9fa5)
        return YES;
    else if (0x2e80 <= aChar && aChar <= 0x2eff)
        return YES;
    else if (0x31c0 <= aChar && aChar < 0x31ef)
        return YES;
    else if (0x2f00 <= aChar && aChar <= 0x2fdf)
        return YES;
    
    return NO;
}

@end

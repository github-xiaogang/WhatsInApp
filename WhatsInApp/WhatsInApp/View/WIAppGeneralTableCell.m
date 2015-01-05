//
//  GeneralTableCell.m
//  ShiShangQuan
//
//  Created by 张 小刚 on 13-9-9.
//  Copyright (c) 2013年 duohuo. All rights reserved.
//

#import "WIAppGeneralTableCell.h"

@implementation WIAppGeneralTableCell

- (void)setData: (id)data
{
    NSLog(@"This is General Table Cell, You should override all my method");
}

+ (CGFloat)heightForData: (id)data
{
    NSLog(@"This is General Table Cell, You should override all my method");
    return 100.0f;
}

@end

//
//  WIAppModule.m
//  WhatsInApp
//
//  Created by 张小刚 on 14/12/27.
//  Copyright (c) 2014年 DuoHuo Network Technology. All rights reserved.
//

#import "WIAppModule.h"

@implementation WIAppModule

+ (instancetype)sharedModule
{
    static WIAppModule * sharedModule = nil;
    if(!sharedModule){
        sharedModule = [[self alloc] init];
    }
    return sharedModule;
}

+ (NSString *)moduleName
{
    return @"";
}


@end

//
//  WIAppUserDefaultsModule.m
//  WhatsInApp
//
//  Created by 张小刚 on 14/12/27.
//  Copyright (c) 2014年 DuoHuo Network Technology. All rights reserved.
//

#import "WIAppUserDefaultsModule.h"
#import "WIAppKVUtil.h"

@implementation WIAppUserDefaultsModule

+ (NSString *)moduleName
{
    return @"User Defaults";
}

+ (void)displayInConsole
{
    NSString * bundleId = [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleIdentifier"];
    NSString * mainPersistentDomainName = bundleId;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * userDefaultsData = [userDefaults persistentDomainForName:mainPersistentDomainName];
    NSArray * kvModels = [WIAppKVUtil constructKVModel:userDefaultsData];
    NSLog(@"%@",kvModels);
}

+ (id)loadContent
{
    NSString * bundleId = [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleIdentifier"];
    NSString * mainPersistentDomainName = bundleId;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary * userDefaultsData = [userDefaults persistentDomainForName:mainPersistentDomainName];
    return userDefaultsData;
}

@end

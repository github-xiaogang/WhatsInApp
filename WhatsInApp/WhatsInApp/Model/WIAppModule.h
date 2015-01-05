//
//  WIAppModule.h
//  WhatsInApp
//
//  Created by 张小刚 on 14/12/27.
//  Copyright (c) 2014年 DuoHuo Network Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WIAppModule : NSObject

+ (instancetype)sharedModule;
+ (NSString *)moduleName;

@end
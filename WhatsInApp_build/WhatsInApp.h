//
//  WhatsInApp.h
//  WhatsInApp
//
//  Created by 张小刚 on 14/12/27.
//  Copyright (c) 2014年 DuoHuo Network Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WhatsInApp : NSObject

+ (void)start;
+ (void)stop;

@end


@interface WhatsInApp (ConsoleDisplay)

+ (void)showUserDefaults;
+ (void)showKeyChain;
+ (void)showLocalNotification;

+ (void)setAssistantLogOff: (BOOL)off;
+ (BOOL)isLAssistantLogOn;

@end

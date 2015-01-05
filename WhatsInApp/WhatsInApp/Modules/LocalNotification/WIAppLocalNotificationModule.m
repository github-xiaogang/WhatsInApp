//
//  WIAppLocalNotificationModule.m
//  WhatsInApp
//
//  Created by 张小刚 on 14/12/27.
//  Copyright (c) 2014年 DuoHuo Network Technology. All rights reserved.
//

#import "WIAppLocalNotificationModule.h"

@implementation WIAppLocalNotificationModule

+ (NSString *)moduleName
{
    return @"Local Notification";
}

///TODO
+ (NSArray *)loadContent
{
    UIApplication * application = [UIApplication sharedApplication];
    NSArray * scheduledNotification = [application scheduledLocalNotifications];
    NSMutableArray * notificaitonModels = [NSMutableArray array];
    for (int i=0; i<scheduledNotification.count; i++) {
        /*
         @property(nonatomic,copy) NSDate *fireDate;
         @property(nonatomic,copy) NSTimeZone *timeZone;
         @property(nonatomic) NSCalendarUnit repeatInterval;      // 0 means don't repeat
         @property(nonatomic,copy) NSCalendar *repeatCalendar;
         @property(nonatomic,copy) CLRegion *region NS_AVAILABLE_IOS(8_0);
         @property(nonatomic,assign) BOOL regionTriggersOnce NS_AVAILABLE_IOS(8_0);
         @property(nonatomic,copy) NSString *alertBody;      // defaults to nil. pass a string or localized string key to show an alert
         @property(nonatomic) BOOL hasAction;                // defaults to YES. pass NO to hide launching button/slider
         @property(nonatomic,copy) NSString *alertAction;    // used in UIAlert button or 'slide to unlock...' slider in place of unlock
         @property(nonatomic,copy) NSString *alertLaunchImage;   // used as the launch image (UILaunchImageFile) when launch button is tapped
         @property(nonatomic,copy) NSString *soundName;      // name of resource in app's bundle to play or UILocalNotificationDefaultSoundName
         @property(nonatomic) NSInteger applicationIconBadgeNumber;  // 0 means no change. defaults to 0
         @property(nonatomic,copy) NSDictionary *userInfo;   // throws if contains non-property list types
         @property (nonatomic, copy) NSString *category NS_AVAILABLE_IOS(8_0);
         */
        UILocalNotification * localNotification = scheduledNotification[i];
        NSMutableArray * propertyList = [NSMutableArray array];
        NSDate * fireDate = localNotification.fireDate;
        NSDateFormatter * dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString * fireDateStr = [dateFormatter stringFromDate:fireDate];
        [propertyList addObject:[WIAppProperty propertyWithKey:@"fireDate" stringValue:fireDateStr]];
        [propertyList addObject:[WIAppProperty propertyWithKey:@"timeZone" stringValue:[[localNotification valueForKey:@"timeZone"] description]]];
        [propertyList addObject:[WIAppProperty propertyWithKey:@"repeatInterval" stringValue:[[localNotification valueForKey:@"repeatInterval"] description]]];
        [propertyList addObject:[WIAppProperty propertyWithKey:@"repeatCalendar" stringValue:[[localNotification valueForKey:@"repeatCalendar"] description]]];
        [propertyList addObject:[WIAppProperty propertyWithKey:@"alertBody" stringValue:[[localNotification valueForKey:@"alertBody"] description]]];
        [propertyList addObject:[WIAppProperty propertyWithKey:@"hasAction" stringValue:[[localNotification valueForKey:@"hasAction"] description]]];
        [propertyList addObject:[WIAppProperty propertyWithKey:@"alertLaunchImage" stringValue:[[localNotification valueForKey:@"alertLaunchImage"] description]]];
        [propertyList addObject:[WIAppProperty propertyWithKey:@"soundName" stringValue:[[localNotification valueForKey:@"soundName"] description]]];
        [propertyList addObject:[WIAppProperty propertyWithKey:@"applicationIconBadgeNumber" stringValue:[[localNotification valueForKey:@"applicationIconBadgeNumber"] description]]];
        [propertyList addObject:[WIAppProperty propertyWithKey:@"userInfo" stringValue:[[localNotification valueForKey:@"userInfo"] description]]];
        if([WIAppSystemUtil isIOS8]){
            [propertyList addObject:[WIAppProperty propertyWithKey:@"region" stringValue:[[localNotification valueForKey:@"region"] description]]];
            [propertyList addObject:[WIAppProperty propertyWithKey:@"regionTriggersOnce" stringValue:[[localNotification valueForKey:@"regionTriggersOnce"] description]]];
            [propertyList addObject:[WIAppProperty propertyWithKey:@"category" stringValue:[[localNotification valueForKey:@"category"] description]]];
        }
        [notificaitonModels addObject:propertyList];
    }
    return notificaitonModels;
}

+ (void)displayInConsole
{
    NSArray * contents = [self loadContent];
    NSLog(@"%@:\n%@",[self moduleName],contents);
}

@end































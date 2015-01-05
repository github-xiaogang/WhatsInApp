//
//  WIAppSystemUtil.h
//  WhatsInApp
//
//  Created by 张小刚 on 14/12/25.
//  Copyright (c) 2014年 DuoHuo Network Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 iOS系统工具集
 */
@interface WIAppSystemUtil : NSObject
//版本号
+ (NSString *)systemVersion;
+ (NSString *)appName;
+ (BOOL)isIOS6;
+ (BOOL)isIOS7;
+ (BOOL)isIOS8;

//所有字体
+ (void)logAllFont;

+ (float)scale;

+ (BOOL)isRetina3_5;
+ (BOOL)isRetina4;
+ (CGFloat)screenWidth;
+ (CGFloat)screenHeight;

+ (int)leftLocalNotificationSize;

@end

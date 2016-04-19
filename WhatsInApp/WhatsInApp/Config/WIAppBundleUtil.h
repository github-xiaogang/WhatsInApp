//
//  BundleUtil.h
//  WhatsInApp
//
//  Created by 张小刚 on 15/1/1.
//  Copyright (c) 2015年 DuoHuo Network Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WIAppBundleUtil : NSObject

+ (NSBundle *)resourceBundle;
+ (id)newInstance: (NSString *)className;

@end

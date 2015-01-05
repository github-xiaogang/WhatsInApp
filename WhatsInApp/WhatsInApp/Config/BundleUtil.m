//
//  BundleUtil.m
//  WhatsInApp
//
//  Created by 张小刚 on 15/1/1.
//  Copyright (c) 2015年 DuoHuo Network Technology. All rights reserved.
//

#import "BundleUtil.h"
NSString * const kWIAppResourceBundleName       = @"WhatsInAppResource";

@implementation BundleUtil

+ (NSBundle *)resourceBundle
{
    NSBundle * resoureBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:kWIAppResourceBundleName ofType:@"bundle"]];
    return resoureBundle;
}

+ (id)newInstance: (NSString *)className
{
    return [[[BundleUtil resourceBundle] loadNibNamed:className owner:nil options:nil][0] retain];
}

@end

//
//  StringProperty.m
//  WhatsInApp
//
//  Created by 张小刚 on 14/12/25.
//  Copyright (c) 2014年 DuoHuo Network Technology. All rights reserved.
//

#import "WIAppProperty.h"

@implementation WIAppProperty

+ (WIAppProperty *)property
{
    return [[[WIAppProperty alloc] init] autorelease];
}

+ (WIAppProperty *)propertyWithKey: (NSString *)key stringValue: (NSString *)stringValue
{
    WIAppProperty * property = [WIAppProperty property];
    property.keyName = key;
    property.stringValue = stringValue;
    return  property;
}

- (NSString *)description
{
    NSMutableString * description = [NSMutableString string];
    [description appendFormat:@"%@ : %@",self.keyName ,self.stringValue];
    return description;
}

- (void)dealloc
{
    [_keyName release];
    [_stringValue release];
    [super dealloc];
}

@end

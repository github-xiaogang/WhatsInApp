//
//  StringProperty.h
//  WhatsInApp
//
//  Created by 张小刚 on 14/12/25.
//  Copyright (c) 2014年 DuoHuo Network Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WIAppProperty : NSObject

@property (nonatomic, retain) NSString * keyName;
@property (nonatomic, retain) NSString * stringValue;

+ (WIAppProperty *)propertyWithKey: (NSString *)key stringValue: (NSString *)stringValue;

@end

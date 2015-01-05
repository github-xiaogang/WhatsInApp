//
//  LocalNotificationCell.m
//  WhatsInApp
//
//  Created by 张小刚 on 14/12/25.
//  Copyright (c) 2014年 DuoHuo Network Technology. All rights reserved.
//

#import "WIAppLocalNotificationCell.h"
#import "WIAppProperty.h"

NSString * const LocalNotificationCellId = @"LocalNotificationCell";

@interface WIAppLocalNotificationCell ()
{
    IBOutlet UILabel *_alertBodyLabel;
    IBOutlet UILabel *_fireDateLabel;
}
@end

@implementation WIAppLocalNotificationCell

/*
 fireDate
 alertBody
 */
- (void)setData:(NSArray *)properties
{
    for (WIAppProperty * property in properties) {
        if([property.keyName isEqualToString:@"alertBody"]){
            _alertBodyLabel.text = property.stringValue;
        }else if([property.keyName isEqualToString:@"fireDate"]){
            _fireDateLabel.text = property.stringValue;
        }
    }
}

+ (CGFloat)heightForData:(id)data
{
    return 57.0f;
}

- (void)dealloc {
    [_alertBodyLabel release];
    [_fireDateLabel release];
    [super dealloc];
}
@end

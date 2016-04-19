//
//  PropertyStringCell.m
//  WhatsInApp
//
//  Created by 张小刚 on 14/12/25.
//  Copyright (c) 2014年 DuoHuo Network Technology. All rights reserved.
//

#import "WIAppPropertyCell.h"
#import "WIAppProperty.h"

NSString * const WIAppPropertyCellId = @"WIAppPropertyCellId";

static CGFloat const PropertyCellWidth = 75.0f;

@interface WIAppPropertyCell ()
{
    IBOutlet UILabel *_keyLabel;
    IBOutlet UILabel *_valueLabel;
}
@end

@implementation WIAppPropertyCell

- (void)setData:(WIAppProperty *)property
{
    NSString * key = property.keyName;
    NSString * value = property.stringValue;
    _keyLabel.text = key;
    CGSize keySize = [_keyLabel sizeThatFits:CGSizeMake(PropertyCellWidth, 0)];
    CGRect keyFrame = _keyLabel.frame;
    keyFrame.size = keySize;
    _keyLabel.frame = keyFrame;
    
    _valueLabel.text = value;
    CGSize valueSize = [_valueLabel sizeThatFits:CGSizeMake(CGRectGetWidth(self.bounds) - 27.0 - 8.0f, 0)];
    CGRect valueFrame = _valueLabel.frame;
    valueFrame.size = valueSize;
    _valueLabel.frame = valueFrame;
    
    CGRect selfFrame = self.frame;
    CGSize frameSize = selfFrame.size;
    frameSize.height = CGRectGetMaxY(_valueLabel.frame) + 12.0f;
    selfFrame.size = frameSize;
    self.frame = selfFrame;
}

+ (CGFloat)heightForData:(id)data
{
    static WIAppPropertyCell * cell = nil;
    if(!cell){
        cell = (WIAppPropertyCell *)[WIAppBundleUtil newInstance:NSStringFromClass([self class])];
    }
    [cell setData:data];
    return CGRectGetHeight(cell.bounds);
}

- (void)dealloc {
    [_valueLabel release];
    [_keyLabel release];
    [super dealloc];
}
@end

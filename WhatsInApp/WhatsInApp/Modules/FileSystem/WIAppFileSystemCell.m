//
//  WIAppFileSystemCell.m
//  WhatsInApp
//
//  Created by 张小刚 on 14/12/31.
//  Copyright (c) 2014年 DuoHuo Network Technology. All rights reserved.
//

#import "WIAppFileSystemCell.h"
#import "WIAppFileSystemItem.h"

NSString * const WIAppFileSystemCellId = @"WIAppFileSystemCellId";

@interface WIAppFileSystemCell ()
{
    IBOutlet UILabel *_titleLabel;
}
@end

@implementation WIAppFileSystemCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    UILongPressGestureRecognizer * longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureRecognized:)];
    [self addGestureRecognizer:longPressGestureRecognizer];
    [longPressGestureRecognizer release];
}

- (void)setData:(WIAppFileSystemItem *)fsItem
{
    _titleLabel.text = fsItem.name;
    self.accessoryType = fsItem.isDirectory ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
}

+ (CGFloat)heightForData:(id)data
{
    return 40.0f;
}

- (void)longPressGestureRecognized: (UILongPressGestureRecognizer *)gestureRecognizer
{
    if(gestureRecognizer.state == UIGestureRecognizerStateBegan){
        if(_delegate && [_delegate respondsToSelector:@selector(filesystemCellActionRequest:)]){
            [_delegate filesystemCellActionRequest:self];
        }
    }
}

- (void)dealloc {
    [_titleLabel release];
    [super dealloc];
}
@end

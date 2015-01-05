//
//  WIAppFileSystemCell.h
//  WhatsInApp
//
//  Created by 张小刚 on 14/12/31.
//  Copyright (c) 2014年 DuoHuo Network Technology. All rights reserved.
//

#import "WIAppGeneralTableCell.h"

extern NSString * const WIAppFileSystemCellId;

@protocol WIAppFileSystemCellDelegate;
@interface WIAppFileSystemCell : WIAppGeneralTableCell

@property (nonatomic, assign) id<WIAppFileSystemCellDelegate> delegate;

@end

@protocol WIAppFileSystemCellDelegate <NSObject>

- (void)filesystemCellActionRequest: (WIAppFileSystemCell *)fsCell;


@end
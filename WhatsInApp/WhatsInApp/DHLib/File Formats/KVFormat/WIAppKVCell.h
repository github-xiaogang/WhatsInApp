//
//  WIAppKVCell.h
//  WhatsInApp
//
//  Created by 张小刚 on 14/12/28.
//  Copyright (c) 2014年 DuoHuo Network Technology. All rights reserved.
//

#import "WIAppGeneralTableCell.h"

extern NSString * const WIAppKVCellId;

@protocol WIAppKVCellDelegate;
@interface WIAppKVCell : WIAppGeneralTableCell

@property (nonatomic, assign) id<WIAppKVCellDelegate> delegate;

@end

@protocol WIAppKVCellDelegate <NSObject>
@optional
- (void)wiappKVCellActionRequest: (WIAppKVCell *)cell;
- (void)wiappKVCellSeeMoreRequest: (WIAppKVCell *)cell triggerPoint: (CGPoint)locationInWindow;

@end

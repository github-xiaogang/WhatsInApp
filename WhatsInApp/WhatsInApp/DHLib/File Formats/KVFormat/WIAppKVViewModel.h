//
//  WIAppKVViewModel.h
//  WhatsInApp
//
//  Created by 张小刚 on 14/12/28.
//  Copyright (c) 2014年 DuoHuo Network Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WIAppKVModel.h"

extern CGFloat const WIAppKVIndentationUnit;

@interface WIAppKVViewModel : NSObject

@property (nonatomic, retain) WIAppKVModel * kvModel;
//unfold 需要显示自己的child nodes
@property (nonatomic, assign,getter=isUnFold) BOOL unfold;
@property (nonatomic, assign,getter=shouldDisplay) BOOL display;

+ (WIAppKVViewModel *)viewModelWithModel: (WIAppKVModel *)kvModel;

@end

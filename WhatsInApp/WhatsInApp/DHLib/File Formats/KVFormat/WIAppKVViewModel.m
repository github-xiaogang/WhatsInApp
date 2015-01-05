//
//  WIAppKVViewModel.m
//  WhatsInApp
//
//  Created by 张小刚 on 14/12/28.
//  Copyright (c) 2014年 DuoHuo Network Technology. All rights reserved.
//

#import "WIAppKVViewModel.h"

CGFloat const WIAppKVIndentationUnit = 30.0f;

@implementation WIAppKVViewModel

+ (WIAppKVViewModel *)viewModelWithModel: (WIAppKVModel *)kvModel
{
    WIAppKVViewModel * viewModel = [[[WIAppKVViewModel alloc] init] autorelease];
    viewModel.kvModel = kvModel;
    viewModel.unfold = (kvModel.level == 0);
    viewModel.display = (kvModel.level == 0);
    return viewModel;
}

- (void)dealloc
{
    [_kvModel release];
    [super dealloc];
}

@end

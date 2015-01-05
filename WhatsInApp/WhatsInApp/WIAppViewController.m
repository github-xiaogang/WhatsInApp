//
//  DHViewController.m
//  WWay
//
//  Created by 张小刚 on 13-12-10.
//  Copyright (c) 2013年 duohuo. All rights reserved.
//

#import "WIAppViewController.h"



@implementation WIAppViewController


- (id)initWithXibInBundle
{
    self = [super initWithNibName:nil bundle:[BundleUtil resourceBundle]];
    if(self){
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if([WIAppSystemUtil isIOS7]){
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

@end
//
//  TestViewController.m
//  WhatsInApp
//
//  Created by 张小刚 on 14/12/27.
//  Copyright (c) 2014年 DuoHuo Network Technology. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()
{
    IBOutlet UIWebView *_webView;
    
}
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_webView release];
    [super dealloc];
}
@end









































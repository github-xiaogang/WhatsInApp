//
//  WebViewController.m
//  WhatsInApp
//
//  Created by 张小刚 on 14/12/25.
//  Copyright (c) 2014年 DuoHuo Network Technology. All rights reserved.
//

#import "WIAppWebViewController.h"

@interface WIAppWebViewController ()
{
    IBOutlet UIWebView *_webView;
    
}
@property (nonatomic, retain) NSURL * URL;
@property (nonatomic, retain) NSString * htmlContent;

@end

@implementation WIAppWebViewController

- (id)initWithURL: (NSURL *)URL
{
    self = [super initWithXibInBundle];
    if(self){
        self.URL = URL;
    }
    return self;
}

- (id)initWithHtml: (NSString *)htmlContent
{
    self = [super initWithXibInBundle];
    if(self){
        self.htmlContent = htmlContent;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if(self.URL){
        NSURLRequest * request = [NSURLRequest requestWithURL:self.URL];
        [_webView loadRequest:request];
    }else if(self.htmlContent){
        [_webView loadHTMLString:self.htmlContent baseURL:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_htmlContent release];
    [_URL release];
    [_webView release];
    [super dealloc];
}

@end

//
//  WebViewController.h
//  WhatsInApp
//
//  Created by 张小刚 on 14/12/25.
//  Copyright (c) 2014年 DuoHuo Network Technology. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WIAppWebViewController : WIAppViewController

- (id)initWithURL: (NSURL *)URL;
- (id)initWithHtml: (NSString *)htmlContent;

@end

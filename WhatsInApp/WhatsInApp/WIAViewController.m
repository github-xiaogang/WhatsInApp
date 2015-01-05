//
//  ViewController.m
//  WhatsInApp
//
//  Created by 张小刚 on 14/12/25.
//  Copyright (c) 2014年 DuoHuo Network Technology. All rights reserved.
//

#import "WIAViewController.h"
#import "WIAppLocalNotificationViewController.h"
#import "WIAppFileSystemViewController.h"
#import "WIAppKVFormatViewController.h"
#import "WIAppUserDefaultsModule.h"
#import "WIAppKeyChainModule.h"
#import "WIAppSqliteViewController.h"

@interface WIAViewController ()

@end

@implementation WIAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem * dismissItem = [[[UIBarButtonItem alloc] initWithTitle:@"Dismiss" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)] autorelease];
    self.navigationItem.rightBarButtonItem = dismissItem;
}

- (void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)userDefaultsButtonPressed:(id)sender {
    id userDefaultsData = [WIAppUserDefaultsModule loadContent];
    WIAppKVFormatViewController * kvViewController = [[WIAppKVFormatViewController alloc] initWithXibInBundle];
    kvViewController.kvData = userDefaultsData;
    kvViewController.title = @"User Defaults";
    [self.navigationController pushViewController:kvViewController animated:YES];
    [kvViewController release];
}

- (IBAction)localNotificationButtonPressed:(id)sender {
    WIAppLocalNotificationViewController * localNotificationViewContorller = [[WIAppLocalNotificationViewController alloc] initWithXibInBundle];
    localNotificationViewContorller.title = @"Local Notificatin";
    [self.navigationController pushViewController:localNotificationViewContorller animated:YES];
    [localNotificationViewContorller release];
}

- (IBAction)keychainButtonPressed:(id)sender {
    id keychainData = [WIAppKeyChainModule loadContent];
    WIAppKVFormatViewController * kvViewController = [[WIAppKVFormatViewController alloc] initWithXibInBundle];
    kvViewController.kvData = keychainData;
    kvViewController.title = @"Key Chain";
    [self.navigationController pushViewController:kvViewController animated:YES];
    [kvViewController release];
}

- (IBAction)filesystemButtonPressed:(id)sender {
    WIAppFileSystemViewController * filesystemViewController = [[WIAppFileSystemViewController alloc] initWithXibInBundle];
    [self.navigationController pushViewController:filesystemViewController animated:YES];
    [filesystemViewController release];
}

- (IBAction)appBundleButtonPressed:(id)sender {
    NSBundle * mainBundle = [NSBundle mainBundle];
    NSURL * mainBundleURL = [mainBundle bundleURL];
    WIAppFileSystemViewController * filesystemViewController = [[WIAppFileSystemViewController alloc] initWithXibInBundle];
    filesystemViewController.parentURL = mainBundleURL;
    filesystemViewController.title = @"App Bundle";
    [self.navigationController pushViewController:filesystemViewController animated:YES];
    [filesystemViewController release];
}

@end





















//
//  LocalNotificationDetailViewController.m
//  WhatsInApp
//
//  Created by 张小刚 on 14/12/25.
//  Copyright (c) 2014年 DuoHuo Network Technology. All rights reserved.
//

#import "WIAppLocalNotificationDetailViewController.h"
#import "WIAppPropertyCell.h"
#import "WIAppProperty.h"

@interface WIAppLocalNotificationDetailViewController ()
{
    IBOutlet UITableView *_tableView;
}
@end

@implementation WIAppLocalNotificationDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WIAppPropertyCell class]) bundle:[BundleUtil resourceBundle]] forCellReuseIdentifier:WIAppPropertyCellId];
    //console
    UIBarButtonItem * consoleItem = [[[UIBarButtonItem alloc] initWithTitle:@"console" style:UIBarButtonItemStylePlain target:self action:@selector(showInConsole)] autorelease];
    self.navigationItem.rightBarButtonItem = consoleItem;
}

- (void)showInConsole
{
    NSLog(@"%@",self.notificationProperties);
}

#pragma mark -----------------   tableview datasouce & delegate   ----------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.notificationProperties.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [WIAppPropertyCell heightForData:self.notificationProperties[indexPath.row]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WIAppPropertyCell * cell = [tableView dequeueReusableCellWithIdentifier:WIAppPropertyCellId];
    [cell setData:self.notificationProperties[indexPath.row]];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_notificationProperties release];
    [_tableView release];
    [super dealloc];
}
@end













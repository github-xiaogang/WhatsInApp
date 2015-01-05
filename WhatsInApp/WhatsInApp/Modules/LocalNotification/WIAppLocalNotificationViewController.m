//
//  LocalNotificationViewController.m
//  WhatsInApp
//
//  Created by 张小刚 on 14/12/25.
//  Copyright (c) 2014年 DuoHuo Network Technology. All rights reserved.
//

#import "WIAppLocalNotificationViewController.h"
#import "WIAppLocalNotificationCell.h"
#import "WIAppLocalNotificationDetailViewController.h"
#import "WIAppLocalNotificationModule.h"

@interface WIAppLocalNotificationViewController ()
{
    IBOutlet UITableView *_tableView;
    NSArray * _list;
}
@end

@implementation WIAppLocalNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WIAppLocalNotificationCell class]) bundle:[BundleUtil resourceBundle]] forCellReuseIdentifier:LocalNotificationCellId];
    _list = [[WIAppLocalNotificationModule loadContent] copy];
    //console
    UIBarButtonItem * consoleItem = [[[UIBarButtonItem alloc] initWithTitle:@"console" style:UIBarButtonItemStylePlain target:self action:@selector(showInConsole)] autorelease];
    self.navigationItem.rightBarButtonItem = consoleItem;
}

- (void)showInConsole
{
    NSLog(@"%@",_list);
}

#pragma mark -----------------   tableview datasouce & delegate   ----------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _list.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [WIAppLocalNotificationCell heightForData:_list[indexPath.row]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WIAppLocalNotificationCell * cell = [tableView dequeueReusableCellWithIdentifier:LocalNotificationCellId];
    [cell setData:_list[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * notificationProperties = _list[indexPath.row];
    WIAppLocalNotificationDetailViewController * detailViewController = [[WIAppLocalNotificationDetailViewController alloc] initWithXibInBundle];
    detailViewController.notificationProperties = notificationProperties;
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    [_tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [_list release];
    [_tableView release];
    [super dealloc];
}
@end



























//
//  FileSystemViewController.m
//  WhatsInApp
//
//  Created by 张小刚 on 14/12/27.
//  Copyright (c) 2014年 DuoHuo Network Technology. All rights reserved.
//

#import "WIAppFileSystemViewController.h"
#import "WIAppFileSystemItem.h"
#import "WIAppFileSystemCell.h"

@interface WIAppFileSystemViewController ()<UIDocumentInteractionControllerDelegate,WIAppFileSystemCellDelegate>
{
    IBOutlet UITableView *_tableView;
    
}

@property (nonatomic, retain) NSFileManager * fileManager;
@property (nonatomic, copy) NSArray * list;
@property (nonatomic, retain) UIDocumentInteractionController * documentInteractionController;

@end

@implementation WIAppFileSystemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WIAppFileSystemCell class]) bundle:[BundleUtil resourceBundle]] forCellReuseIdentifier:WIAppFileSystemCellId];
    self.fileManager = [NSFileManager defaultManager];
    [self loadContent];
}

- (void)loadContent
{
    if(!self.parentURL){
        self.title = @"File System";
        NSString * sandboxPath = NSHomeDirectory();
        NSURL * sandboxURL = [NSURL fileURLWithPath:sandboxPath isDirectory:YES];
        self.parentURL = sandboxURL;
    }
    NSError * error = nil;
    NSArray * properties = @[NSURLLocalizedNameKey,NSURLIsDirectoryKey,NSURLIsHiddenKey,NSURLFileResourceTypeKey];
    NSArray * itemURLs = [self.fileManager contentsOfDirectoryAtURL:self.parentURL includingPropertiesForKeys:properties options:0 error:&error];
    NSMutableArray * fsItems = [NSMutableArray arrayWithCapacity:itemURLs.count];
    for (NSURL * fileURL in itemURLs) {
        NSError * error = nil;
        NSDictionary * attributes = [fileURL resourceValuesForKeys:properties error:&error];
        if(attributes){
            WIAppFileSystemItem * fsItem = [[[WIAppFileSystemItem alloc] init] autorelease];
            fsItem.URL = fileURL;
            fsItem.name = attributes[NSURLLocalizedNameKey];
            fsItem.isDirectory = [attributes[NSURLIsDirectoryKey] boolValue];
            fsItem.pathExtension = fileURL.pathExtension;
            [fsItems addObject:fsItem];
        }
    }
    self.list = fsItems;
}

#pragma mark -----------------   tableview datasouce & delegate   ----------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WIAppFileSystemCell * cell = [tableView dequeueReusableCellWithIdentifier:WIAppFileSystemCellId];
    WIAppFileSystemItem * fsItem = _list[indexPath.row];
    [cell setData:fsItem];
    cell.delegate = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WIAppFileSystemItem * fsItem = _list[indexPath.row];
    if(fsItem.isDirectory){
        WIAppFileSystemViewController * filesystemViewController = [[WIAppFileSystemViewController alloc] initWithXibInBundle];
        filesystemViewController.parentURL = fsItem.URL;
        filesystemViewController.title = fsItem.name;
        [self.navigationController pushViewController:filesystemViewController animated:YES];
        [filesystemViewController release];
    }else{
        UIViewController * openController = [fsItem bestOpenController];
        [self.navigationController pushViewController:openController animated:YES];
    }
    [_tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)filesystemCellActionRequest: (WIAppFileSystemCell *)fsCell
{
    NSIndexPath * indexPath = [_tableView indexPathForCell:fsCell];
    WIAppFileSystemItem * fsItem = _list[indexPath.row];
    if(!fsItem.isDirectory){
        if(!self.documentInteractionController){
            self.documentInteractionController = [[UIDocumentInteractionController alloc] init];
            self.documentInteractionController.delegate = self;
        }
        self.documentInteractionController.URL = fsItem.URL;
        CGRect anchorRect = CGRectZero;
        CGPoint position = CGPointMake(CGRectGetWidth(fsCell.bounds)/2, CGRectGetHeight(fsCell.bounds)/2);
        anchorRect.origin = position;
        [self.documentInteractionController presentOptionsMenuFromRect:anchorRect inView:fsCell animated:YES];
    }
}

- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller
{
    return self.navigationController;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_documentInteractionController release];
    [_tableView release];
    [super dealloc];
}
@end

























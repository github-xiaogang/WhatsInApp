//
//  FileSystemItem.m
//  WhatsInApp
//
//  Created by 张小刚 on 14/12/27.
//  Copyright (c) 2014年 DuoHuo Network Technology. All rights reserved.
//

#import "WIAppFileSystemItem.h"
#import "WIAppWebViewController.h"
#import "WIAppKVFormatViewController.h"
#import "WIAppSqliteViewController.h"

//kv
NSString * const kWIAppFileExtensionJson = @"json";
NSString * const kWIAppFileExtensionPlist = @"plist";

//markdown
NSString * const kWIAppFileExtensionMarkDown = @"markdown";
NSString * const kWIAppFileExtensionMarkDown2 = @"md";
NSString * const kWIAppFileExtensionMarkDown3 = @"mdown";

//sqlite db
NSString * const kWIAppFileExtensionSqlite = @"db";
NSString * const kWIAppFileExtensionSqlite2 = @"sqlite";


@implementation WIAppFileSystemItem

- (WIAppFileFormat)preferedOpenFormat
{
    WIAppFileFormat format = wiappFileFormatDefault;
    NSArray * kvSupportExtensions = @[kWIAppFileExtensionJson,kWIAppFileExtensionPlist,];
    if([self isFileFormat:kvSupportExtensions]) format = WIAppFileFormatKV;
    NSArray * mdSupportExtensions = @[kWIAppFileExtensionMarkDown,kWIAppFileExtensionMarkDown2,kWIAppFileExtensionMarkDown3,];
    if([self isFileFormat:mdSupportExtensions]) format = WIAppFileFormatMarkDown;
    NSArray * sqliteSupportExtensions = @[kWIAppFileExtensionSqlite,kWIAppFileExtensionSqlite2,];
    if([self isFileFormat:sqliteSupportExtensions]) format = WIAppFileFormatSqlite;
    return format;
}

- (BOOL)isFileFormat: (NSArray *)possibleExtensions
{
    BOOL matched = NO;
    for (NSString * extension in possibleExtensions) {
        if([self.pathExtension isEqualToString:extension]){
            matched = YES;
            break;
        }
    }
    return matched;
}

- (UIViewController *)bestOpenController
{
    UIViewController * openController = nil;
    WIAppFileFormat format = [self preferedOpenFormat];
    if(format == WIAppFileFormatKV){
        //生成数据
        if([self.pathExtension isEqualToString:kWIAppFileExtensionJson]){
            NSData * jsonData = [NSData dataWithContentsOfURL:self.URL];
            NSError * error = nil;
            id kvObject = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
            if(kvObject){
                WIAppKVFormatViewController * kvViewController = [[[WIAppKVFormatViewController alloc] initWithXibInBundle] autorelease];
                kvViewController.kvData = kvObject;
                openController = kvViewController;
            }
        }else if([self.pathExtension isEqualToString:kWIAppFileExtensionPlist]){
            id kvData = [NSDictionary dictionaryWithContentsOfURL:self.URL];
            if(!kvData){
                kvData = [NSArray arrayWithContentsOfURL:self.URL];
            }
            if(kvData){
                WIAppKVFormatViewController * kvViewController = [[[WIAppKVFormatViewController alloc] initWithXibInBundle] autorelease];
                kvViewController.kvData = kvData;
                openController = kvViewController;
            }
        }
    }else if(format == WIAppFileFormatMarkDown){
        NSError * error = nil;
        NSString * mdContent = [NSString stringWithContentsOfURL:self.URL encoding:NSUTF8StringEncoding error:&error];
        if(mdContent){
            NSString * mdHtml = [MMMarkdown HTMLStringWithMarkdown:mdContent error:&error];
            if(mdHtml){
                WIAppWebViewController * webViewController = [[[WIAppWebViewController alloc] initWithHtml:mdHtml] autorelease];
                openController = webViewController;
            }
        }
    }else if(format == WIAppFileFormatSqlite){
        WIAppSqliteViewController * sqliteViewContrller = [[[WIAppSqliteViewController alloc] initWithXibInBundle] autorelease];
        sqliteViewContrller.dbURL = self.URL;
        openController = sqliteViewContrller;
    }
    if(!openController){
        openController = [self defaultOpenController];
        openController.title = self.name;
    }
    return openController;
}

- (WIAppWebViewController *)defaultOpenController
{
    WIAppWebViewController * webViewController = [[[WIAppWebViewController alloc] initWithURL:self.URL] autorelease];
    return webViewController;
}

- (void)dealloc
{
    [_URL release];
    [_name release];
    [_pathExtension release];
    [super dealloc];
}
@end




































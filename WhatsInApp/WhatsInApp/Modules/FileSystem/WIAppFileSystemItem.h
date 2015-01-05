//
//  FileSystemItem.h
//  WhatsInApp
//
//  Created by 张小刚 on 14/12/27.
//  Copyright (c) 2014年 DuoHuo Network Technology. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    wiappFileFormatDefault,     //直接用Webview打开  .txt .doc .图片，.html
    WIAppFileFormatKV,          //以KV打开(解析后类型为NSDictioanry或NSArray)  比如.xml .json, .plist
    WIAppFileFormatMarkDown,    //.md
    //其他类型
    
    WIAppFileFormatSqlite,        //数据库文件
    
}WIAppFileFormat;

@interface WIAppFileSystemItem : NSObject

@property (nonatomic, retain) NSURL *       URL;
@property (nonatomic, retain) NSString *    name;
@property (nonatomic, assign) BOOL          isDirectory;
@property (nonatomic, retain) NSString *    pathExtension;

- (UIViewController *)bestOpenController;

@end








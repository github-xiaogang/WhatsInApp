//
//  WIAppSqliteViewController.m
//  WhatsInApp
//
//  Created by 张小刚 on 14/12/31.
//  Copyright (c) 2014年 DuoHuo Network Technology. All rights reserved.
//

#import "WIAppSqliteViewController.h"
#import "EGODatabase.h"

NSString * const kWIAppSqliteShowTablesSql = @"SELECT name FROM sqlite_master WHERE type = 'table'";

@interface WIAppSqliteViewController ()
{
    IBOutlet UITextView *_sqlTextView;
    IBOutlet UIScrollView *_toolScrollView;
    IBOutlet UIScrollView *_tableScrollView;
}

@property (nonatomic, copy) NSArray * tools;
@property (nonatomic, copy) NSArray * tableNames;
@property (nonatomic, retain) EGODatabase * database;

@end

@implementation WIAppSqliteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //init db
    NSString * dbPath = [self.dbURL absoluteString];
    self.database = [EGODatabase databaseWithPath:dbPath];
    self.tools = @[
                   @"select",
                   @"*",
                   @"from",
                   @";",
                   @"\n",
                   ];
    //load tables & others
    [self loadContent];
}

- (void)loadContent
{
    _sqlTextView.text = @"Loading...";
    if(![self.database open]){
        NSString * error = [NSString stringWithFormat:@"open %@ db failed",self.dbURL];
        [self logError:error];
        return;
    }
    EGODatabaseResult * result = [self.database executeQuery:kWIAppSqliteShowTablesSql];
    if(!result.errorCode){
        NSMutableArray * tableNames = [NSMutableArray array];
        for (EGODatabaseRow * row in result) {
            NSString * tableName = [row stringForColumn:@"name"];
            [tableNames addObject:tableName];
        }
        if(tableNames.count > 0){
            self.tableNames = tableNames;
            [self loadToolUI];
            [self loadTableNamesUI];
            [self clearSqlText];
            [_sqlTextView becomeFirstResponder];
        }else{
            [self logError:@"No Table Found"];
        }
    }else{
        [self logError:result.errorMessage];
    }
}

- (void)loadTableNamesUI
{
    CGFloat PADDING_X = 20;
    CGFloat SPACE = 16;
    CGFloat offsetX = PADDING_X;
    for (int i=0; i<self.tableNames.count; i++) {
        NSString * tableName = self.tableNames[i];
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitleColor:[WIAppAppearance buttonNormalColor] forState:UIControlStateNormal];
        [button setTitleColor:[WIAppAppearance buttonHightlightedColor] forState:UIControlStateHighlighted];
        [button setTitle:tableName forState:UIControlStateNormal];
        [button setTitle:tableName forState:UIControlStateHighlighted];
        [button sizeToFit];
        CGRect frame = CGRectZero;
        frame.origin = CGPointMake(offsetX, 0);
        frame.size = CGSizeMake(CGRectGetWidth(button.bounds), CGRectGetHeight(_tableScrollView.bounds));
        button.frame = frame;
        offsetX += frame.size.width + SPACE;
        [button addTarget:self action:@selector(tableButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_tableScrollView addSubview:button];
    }
    _tableScrollView.contentSize = CGSizeMake(offsetX + (PADDING_X - SPACE), CGRectGetHeight(_tableScrollView.bounds));
}

- (void)loadToolUI
{
    CGFloat PADDING_X = 20;
    CGFloat SPACE = 16;
    CGFloat offsetX = PADDING_X;
    for (int i=0; i<self.tools.count; i++) {
        NSString * toolStr = self.tools[i];
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitleColor:[WIAppAppearance buttonNormalColor] forState:UIControlStateNormal];
        [button setTitleColor:[WIAppAppearance buttonHightlightedColor] forState:UIControlStateHighlighted];
        [button setTitle:toolStr forState:UIControlStateNormal];
        [button setTitle:toolStr forState:UIControlStateHighlighted];
        [button sizeToFit];
        CGRect frame = CGRectZero;
        frame.origin = CGPointMake(offsetX, 0);
        frame.size = CGSizeMake(CGRectGetWidth(button.bounds), CGRectGetHeight(_toolScrollView.bounds));
        button.frame = frame;
        offsetX += frame.size.width + SPACE;
        [button addTarget:self action:@selector(toolButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_toolScrollView addSubview:button];
    }
    _toolScrollView.contentSize = CGSizeMake(offsetX + (PADDING_X - SPACE), CGRectGetHeight(_toolScrollView.bounds));
}

- (void)toolButtonPressed: (UIButton *)toolButton
{
    NSString * toolStr = [toolButton titleForState:UIControlStateNormal];
    [self appendSqlText:toolStr];
}

- (void)tableButtonPressed: (UIButton *)tableButton
{
    NSString * tableStr = [tableButton titleForState:UIControlStateNormal];
    [self appendSqlText:tableStr];
}

- (IBAction)queryButtonPressed:(id)sender {
    if(_sqlTextView.text.length == 0) return;
    EGODatabaseResult * result = [self.database executeQuery:_sqlTextView.text];
    if(!result.errorCode){
        [self cookQueryResult:result];
    }else{
        [self logError:result.errorMessage];
    }
}

- (void)cookQueryResult : (EGODatabaseResult *)result
{
    NSArray * columnNames = result.columnNames;
    NSMutableArray * tableDatas = [NSMutableArray arrayWithCapacity:result.rows.count];
    for (int i=0; i<result.rows.count; i++) {
        NSMutableDictionary * aRow = [NSMutableDictionary dictionary];
        EGODatabaseRow * row = result.rows[i];
        for (NSString * columnName in columnNames) {
            NSString * strValue = [row stringForColumn:columnName];
            if(!strValue) strValue = @"";
            aRow[columnName] = strValue;
        }
        [tableDatas addObject:aRow];
    }
    //render
    NSString * html = [self renderHtmlWithSql:_sqlTextView.text sections:columnNames tableDatas:tableDatas];
    [self showQueryResult:html];
}

- (NSString *)renderHtmlWithSql: (NSString *)sql sections: (NSArray *)sections tableDatas: (NSArray *)tableDatas
{
    NSMutableString * html = [NSMutableString string];
    [html appendString:@"<html>"];
    NSString * style =
    @"<head>\
        <style type='text/css'>\
            table\
            {\
                border-collapse:collapse;\
            }\
            table, td, th\
            {\
                border:1px solid black;\
            }\
        </style>\
    </head>";
    [html appendString:style];
    [html appendString:@"<body>"];
    [html appendFormat:@"<b>%@</b>",sql];
    [html appendFormat:@"<hr/>"];
    [html appendString:@"<table style='border:1px solid black'; border-collapse:'collapse'>"];
    //table header
    [html appendString:@"<tr>"];
    for (int i=0; i<sections.count; i++) {
        NSString * section = sections[i];
        [html appendFormat:@"<th>%@</th>",section];
    }
    [html appendString:@"</tr>"];
    //table body
    for (int i=0; i<tableDatas.count; i++) {
        [html appendString:@"<tr>"];
        NSDictionary * aRow = tableDatas[i];
        for (int j=0; j<sections.count; j++) {
            NSString * section = sections[j];
            NSString * value = aRow[section];
            [html appendFormat:@"<td>%@</td>",value];
        }
        [html appendString:@"</tr>"];
    }
    [html appendString:@"</table>"];
    [html appendString:@"</body>"];
    [html appendString:@"</html>"];
    return html;
}

- (void)showQueryResult: (NSString *)html
{
    WIAppWebViewController * resultViewController = [[WIAppWebViewController alloc] initWithHtml:html];
    [self.navigationController pushViewController:resultViewController animated:YES];
    [resultViewController release];
}

- (IBAction)clearButtonPressed:(id)sender {
    [self clearSqlText];
    [_sqlTextView becomeFirstResponder];
}

- (void)appendSqlText: (NSString *)text
{
    _sqlTextView.text = [NSString stringWithFormat:@"%@ %@ ",_sqlTextView.text,text];
}

- (void)clearSqlText
{
    _sqlTextView.text = nil;
}

- (void)logError: (NSString *)error
{
    UIAlertView * alertView = [[[UIAlertView alloc] initWithTitle:@"提示" message:error delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil] autorelease];
    [alertView show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [_database release];
    [_dbURL release];
    [_tableNames release];
    [_sqlTextView release];
    [_toolScrollView release];
    [_tableScrollView release];
    [super dealloc];
}


@end






















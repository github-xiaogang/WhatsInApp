//
//  WIAppKVFormatViewController.m
//  WhatsInApp
//
//  Created by 张小刚 on 14/12/28.
//  Copyright (c) 2014年 DuoHuo Network Technology. All rights reserved.
//

#import "WIAppKVFormatViewController.h"
#import "WIAppKVModel.h"
#import "WIAppKVViewModel.h"
#import "WIAppKVCell.h"
#import "WIAppKVUtil.h"
#import "WhatsInApp.h"

@interface WIAppKVFormatViewController ()<WIAppKVCellDelegate>
{
    IBOutlet UIScrollView *_scrollView;
    IBOutlet UITableView *_tableView;
}

@property (nonatomic, copy) NSArray * cellModelList;
@property (nonatomic, copy) NSArray * viewModelList;
@property (nonatomic, copy) NSArray * list;

@end

@implementation WIAppKVFormatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WIAppKVCell class]) bundle:[WIAppBundleUtil resourceBundle]] forCellReuseIdentifier:WIAppKVCellId];
    self.cellModelList = [WIAppKVUtil constructKVModel: self.kvData];
    self.viewModelList = [self generateDisplayList: self.cellModelList];
    [self updateDisplayList];
    [_tableView reloadData];
    //console
    UIBarButtonItem * consoleItem = [[[UIBarButtonItem alloc] initWithTitle:@"console" style:UIBarButtonItemStylePlain target:self action:@selector(showInConsole)] autorelease];
    self.navigationItem.rightBarButtonItem = consoleItem;
}

- (void)showInConsole
{
    NSLog(@"%@",self.cellModelList);
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self updateScrollContentSize];
}

- (void)updateScrollContentSize
{
    _scrollView.contentSize = _tableView.bounds.size;
}

- (void)updateDisplayList
{
    NSMutableArray * viewList = [NSMutableArray array];
    for (WIAppKVViewModel * viewModel in self.viewModelList) {
        if(viewModel.shouldDisplay){
            [viewList addObject:viewModel];
        }
    }
    self.list = viewList;
}

- (NSArray *)generateDisplayList: (NSArray *)modelList
{
    NSMutableArray * displayList = [NSMutableArray arrayWithCapacity:modelList.count];
    for (int i=0; i<modelList.count; i++) {
        WIAppKVModel * kvModel = modelList[i];
        WIAppKVViewModel * kvViewModel = [WIAppKVViewModel viewModelWithModel:kvModel];
        //根据parent的unfold与否设置自己的display
        WIAppKVViewModel * parentViewModel = nil;
        for (WIAppKVViewModel * previousViewModel in displayList) {
            WIAppKVModel * previousModel = previousViewModel.kvModel;
            if(previousModel.level == (kvModel.level - 1)){
                parentViewModel = previousViewModel;
                break;
            }
        }
        if(parentViewModel){
            kvViewModel.display = (parentViewModel.isUnFold);
        }
        [displayList addObject:kvViewModel];
    }
    return displayList;
}


#pragma mark -----------------   tableview datasouce & delegate   ----------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _list.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [WIAppKVCell heightForData:_list[indexPath.row]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WIAppKVCell * cell = [tableView dequeueReusableCellWithIdentifier:WIAppKVCellId];
    [cell setData:_list[indexPath.row]];
    cell.delegate = self;
    return cell;
}

#pragma mark -----------------   unfold/fold request   ----------------
- (void)wiappKVCellActionRequest: (WIAppKVCell *)cell
{
    NSIndexPath * indexPath = [_tableView indexPathForCell:cell];
    WIAppKVViewModel * viewModel = self.list[indexPath.row];
    if(viewModel.isUnFold){
        viewModel.unfold = NO;
        //fold descendant
        NSArray * descendantViewModels = [ self descendantForViewModel:viewModel];
        for (WIAppKVViewModel * descendantViewModel in descendantViewModels) {
            descendantViewModel.unfold = NO;
            descendantViewModel.display = NO;
        }
    }else{
        viewModel.unfold = YES;
        //fold childrend
        NSArray * childViewModels = [ self childrenForViewModel:viewModel];
        for (WIAppKVViewModel * childViewModel in childViewModels) {
            childViewModel.display = YES;
        }
    }
    [self updateDisplayList];
    [self updateContentViewSize];
    [_tableView reloadData];
}

- (NSArray *)childrenForViewModel: (WIAppKVViewModel *)parentViewModel
{
    WIAppKVModel * parentKVModel = parentViewModel.kvModel;
    NSMutableArray * childrenViewModels = [NSMutableArray arrayWithCapacity:parentKVModel.childCount];
    NSUInteger parentViewModelIndex = [self.viewModelList indexOfObject:parentViewModel];
    for (NSUInteger i=parentViewModelIndex + 1; i<self.viewModelList.count; i++) {
        WIAppKVViewModel * viewModel = self.viewModelList[i];
        WIAppKVModel * kvModel = viewModel.kvModel;
        if(kvModel.level == parentKVModel.level + 1){
            [childrenViewModels addObject:viewModel];
        }else if(kvModel.level <= parentKVModel.level){
            break;
        }
    }
    return childrenViewModels;
}

- (NSArray *)descendantForViewModel: (WIAppKVViewModel *)parentViewModel
{
    WIAppKVModel * parentKVModel = parentViewModel.kvModel;
    NSMutableArray * descendantViewModels = [NSMutableArray arrayWithCapacity:parentKVModel.childCount];
    NSUInteger parentViewModelIndex = [self.viewModelList indexOfObject:parentViewModel];
    for (NSUInteger i = parentViewModelIndex + 1; i<self.viewModelList.count; i++) {
        WIAppKVViewModel * viewModel = self.viewModelList[i];
        WIAppKVModel * kvModel = viewModel.kvModel;
        if(kvModel.level > parentKVModel.level){
            [descendantViewModels addObject:viewModel];
        }else if(kvModel.level <= parentKVModel.level){
            break;
        }
    }
    return descendantViewModels;
}

- (void)updateContentViewSize
{
    //indent level每超过4级，增加4级的宽度
    NSUInteger currentLevel = [self currentUnfoldLevel];
    CGFloat contentViewBaseWidth = CGRectGetWidth(_tableView.superview.bounds);
    CGFloat contentViewWidth = contentViewBaseWidth + (WIAppKVIndentationUnit * (currentLevel /2) * 2);
    CGRect contentViewFrame = _tableView.frame;
    CGSize contentViewSize = _tableView.bounds.size;
    contentViewSize = contentViewFrame.size;
    contentViewSize.width = contentViewWidth;
    contentViewFrame.size = contentViewSize;
    _tableView.frame = contentViewFrame;
    [self updateScrollContentSize];
}

- (NSUInteger)currentUnfoldLevel
{
    NSUInteger maxLevel = 0;
    for (WIAppKVViewModel * viewModel in self.viewModelList) {
        if(viewModel.shouldDisplay){
            WIAppKVModel * kvModel = viewModel.kvModel;
            if(kvModel.level > maxLevel){
                maxLevel = kvModel.level;
            }
        }
    }
    return maxLevel;
}

- (void)wiappKVCellSeeMoreRequest: (WIAppKVCell *)cell triggerPoint:(CGPoint)locationInWindow
{
    NSIndexPath * indexPath = [_tableView indexPathForCell:cell];
    UIWindow * keyWindow = [[UIApplication sharedApplication] keyWindow];
    BOOL isTop = (locationInWindow.y < CGRectGetHeight(keyWindow.bounds)/2);
    //2/5
    CGSize popSize = CGSizeMake(CGRectGetWidth(keyWindow.bounds) * (4.0/5), CGRectGetHeight(keyWindow.bounds) * (2.0/5));
    CGPoint popOrigin = CGPointZero;
    CGRect contentFrame;
    contentFrame.origin = popOrigin;
    contentFrame.size = popSize;
    
    UITextView * textView = [[[UITextView alloc] initWithFrame:contentFrame] autorelease];
    WIAppKVViewModel * viewModel = self.list[indexPath.row];
    WIAppKVModel * kvModel = viewModel.kvModel;
    NSString * text = nil;
    if(kvModel.key){
        text = [NSString stringWithFormat:@"%@: %@",[kvModel.key description], [kvModel.value description]];
    }else{
        text = [NSString stringWithFormat:@"%@",[kvModel.value description]];
    }
    textView.text = text;
    DXPopover * popOver = [DXPopover popover];
    popOver.animationIn = 0.14;
    popOver.animationOut = 0.1;
    popOver.animationSpring = NO;
    DXPopoverPosition position = isTop ? DXPopoverPositionDown : DXPopoverPositionUp;
    CGPoint cellPointInWindow = [cell convertPoint:CGPointMake(CGRectGetWidth(cell.bounds)/2, isTop ? CGRectGetHeight(cell.bounds) : 0) toView:keyWindow];
    cellPointInWindow.x = CGRectGetWidth(keyWindow.bounds)/2;
    [popOver showAtPoint:cellPointInWindow popoverPostion:position withContentView:textView inView:keyWindow];
    if([WhatsInApp isLAssistantLogOn]){
        NSLog(@"%@",text);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_cellModelList release];
    [_viewModelList release];
    [_list release];
    [_kvData release];
    [_tableView release];
    [_scrollView release];
    [super dealloc];
}
@end






























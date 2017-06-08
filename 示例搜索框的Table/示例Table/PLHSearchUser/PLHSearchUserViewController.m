//
//  PLHSearchUserViewController.m
//  PLHSearchDemo
//
//  Created by peilinghui on 2017/6/7.
//  Copyright © 2017年 peilinghui. All rights reserved.
//

#import "PLHSearchUserViewController.h"
#import "PLHHistoryTableViewCell.h"
#import "PLHHistoryHeaderView.h"
#import "PLHSearchViewController.h"
#import "Masonry.h"

#define kSearchHistoryKey @"SearchHistoryKey"
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@interface PLHSearchUserViewController ()<
    UISearchBarDelegate,
    UITableViewDelegate,
    UITableViewDataSource,
    DeleteHistoryCellDelegate,
    HistoryDeleteDelegate
>

@property (nonatomic,strong) UISearchBar *searchBar;

@property (nonatomic, strong) UITableView *historyItemTable;//搜索历史的tableview
@property (nonatomic, strong) NSMutableArray *historyItemList;//搜索历史的数组

@property (nonatomic, strong) UITableView *queryResultTable;//查询的tableview
@property (nonatomic, strong) NSMutableArray *queryResultList;//查询结果的数组

@property (nonatomic, strong) UIBarButtonItem *goBackButton; // goback
@property (nonatomic, strong) UIBarButtonItem *logoutButton; // logout

@end

@implementation PLHSearchUserViewController

- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor whiteColor];
    [super viewDidLoad];
    [self addComponents];
    [self buildHistoryItemList];
    self.navigationItem.title = @"搜索框实现存在NSUserDefault中";
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self layoutComponents]; // 布局主界面
}


#pragma mark -- Private Methods
-(void)addComponents
{
    [self.view addSubview:self.searchBar];
    [self.view addSubview:self.historyItemTable];
    [self.view addSubview:self.queryResultTable];
}


- (void)layoutComponents {
    
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make){
        make.width.equalTo(self.view);
        make.height.equalTo(@50);
        make.top.equalTo(self.view.mas_top).offset(64);
    }];
   
    [self.historyItemTable mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
        make.top.equalTo(self.searchBar.mas_bottom);
    }];
    [self.queryResultTable mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
        make.top.equalTo(self.searchBar.mas_bottom);
    }];
    [self.historyItemTable registerClass:[PLHHistoryTableViewCell class] forCellReuseIdentifier:@"HistoryCell"];
}

#pragma mark--设置historyTable的数据源,从NSUserDefault中取出
-(void)buildHistoryItemList{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
     NSArray  *historyList = [defaults valueForKey: kSearchHistoryKey];
    if ((historyList.count!= 0)&&(![historyList isKindOfClass:[NSNull class]])) {
        self.historyItemList = [historyList mutableCopy];
    }
}

#pragma mark - < UIScrollViewDelegate >
//当搜索出来结果，滚动tableview的时候收起键盘
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.searchBar setShowsCancelButton:NO animated:YES];
    [self.searchBar endEditing:YES];
}


#pragma mark -- <UITableViewDataSource>
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _historyItemTable) {
        if (_historyItemList.count>0) {
            self.queryResultTable.hidden = YES;
        }
        
        return [self.historyItemList count];
    }
    if (tableView == _queryResultTable) {
        NSInteger numberOfRows = [self.queryResultList count];
        if (_queryResultList.count>0) {
        self.historyItemTable.hidden = YES;
        }
        return numberOfRows;
    }
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _historyItemTable) {
        PLHHistoryTableViewCell *cell = [[PLHHistoryTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HistoryCell"];
        cell.delegate = self;
        cell.strLab.text= self.historyItemList[indexPath.row];
        return cell;
    }
    
    if (tableView == _queryResultTable) {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"QueryCell"];
        cell.textLabel.text= self.queryResultList[indexPath.row];
        return cell;
    }
    return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (tableView == _historyItemTable&& [self.historyItemList count] > 0) {
        PLHHistoryHeaderView *historyView = [[PLHHistoryHeaderView alloc]init];
        historyView.delegate = self;
        return historyView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == _historyItemTable&& [self.historyItemList count] > 0) {
        return 50;
    }
    return 0;
}


#pragma mar --<UITableViewDelegate>点击回调
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"now select... %ld", (long)indexPath.row);
    if (tableView == _historyItemTable) {
      
        PLHSearchViewController *vc = [[PLHSearchViewController alloc]init];
        vc.title = self.historyItemList[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
    
    if (tableView == _queryResultTable) {

        [self.searchBar resignFirstResponder];
        return;
    }
}


#pragma mark -  KFSearchHistoryCellDeleagte删除每一个cell。写入NSUserDefault
- (void)onDelHistoryCellRecord:(PLHHistoryTableViewCell *)cell {
    NSIndexPath *path = [self.historyItemTable indexPathForCell:cell];
    if (self.historyItemList.count != 0) {
        [self.historyItemList removeObjectAtIndex:path.row];
        [_historyItemTable deleteRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationMiddle];
    }
    NSUserDefaults *defults = [NSUserDefaults standardUserDefaults];
    [defults setObject:self.historyItemList forKey:kSearchHistoryKey];
    [defults synchronize];
    [_historyItemTable reloadData];
}

#pragma mark --HistoryHeaderView的delegate
-(void)clickhistoryAllDeleteDelegate{
    [self createdAlertview:@"确定要删除历史记录"];
    
}
#pragma mark 提示框
- (void)createdAlertview:(NSString *)str{
    
    UIAlertController *alertCtl = [UIAlertController alertControllerWithTitle:@"温馨提示" message:str  preferredStyle:UIAlertControllerStyleAlert];
    [alertCtl addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        return ;
    }]];
    [alertCtl addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.historyItemList removeAllObjects];
        
#pragma mark --删除NSD中全部数据
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        [ud removeObjectForKey:kSearchHistoryKey];
        [self.historyItemTable reloadData];
        
    }]];
    [self presentViewController:alertCtl animated:YES completion:nil];
}

#pragma mark - < UISearchBarDelegate >
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
    // -------修改UISearchBar右侧的取消按钮文字颜色-------
    for (UIView *view in searchBar.subviews) {
        for (id subview in view.subviews) {
            if ([subview isKindOfClass:[UIButton class]]) {
                UIButton *cancelButton = (UIButton *)subview;
                // 修改文字颜色
                [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
            }
        }
    }
    self.queryResultTable.hidden = NO;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    NSLog(@"did end editing..");
}

//当搜索输入的关键字变化的时候，先从历史记录中查询，再写入NSUserDefault
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"searchText:%@", searchText);
    if (searchText.length == 0) {
        return;
    }
  
    
    [self queryScheduleWithKeyword:searchText];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:NO animated:YES];
    [self.searchBar resignFirstResponder];
    if (searchBar.text.length > 0) {
        NSDictionary *keywordData = @{@"keyword": searchBar.text};
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    self.queryResultTable.hidden = YES;
    self.historyItemTable.hidden = NO;
}

#pragma mark --根据关键字从接口查询，再写入NSuserDefault
-(void)queryScheduleWithKeyword:(NSString *)keyword
{
    [self.queryResultList removeAllObjects];
    //先把关键字从历史记录中查询，若历史记录中有就加载，没有就存下来
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains [cd] %@", keyword];
    NSArray *filterdArray = [(NSArray *)self.historyItemList filteredArrayUsingPredicate:predicate];
    
    [self.queryResultList addObjectsFromArray:filterdArray];
    if (self.queryResultList.count >0) {
        self.queryResultTable.hidden= NO;
        self.historyItemTable.hidden = YES;
        [self.queryResultTable reloadData];
    }else{
        //关键字写入NSuserDefault
        [self.historyItemList insertObject:keyword atIndex:0];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:self.historyItemList forKey:kSearchHistoryKey];
        [defaults synchronize];
        [_historyItemTable reloadData];
    }
 }

#pragma mark --Setter


#pragma mark --Getter

- (UISearchBar *)searchBar {
    if (!_searchBar) {
        UISearchBar *searchBar = [UISearchBar new];
        searchBar.delegate = self;
        searchBar.returnKeyType = UIReturnKeySearch;
        searchBar.placeholder = @"搜索";
        _searchBar = searchBar;
    }
    return _searchBar;
}

- (NSMutableArray *)queryResultList {
    if (!_queryResultList) {
        _queryResultList = [NSMutableArray array];
    }
    return _queryResultList;
}

- (UITableView *)queryResultTable {
    if (!_queryResultTable) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        tableView.backgroundColor = [UIColor whiteColor];
        tableView.hidden = YES;
        _queryResultTable = tableView;
    }
    return _queryResultTable;
}

- (NSMutableArray *)historyItemList
{
    if (!_historyItemList) {
        _historyItemList = [NSMutableArray array];
    }
    
    return _historyItemList;
}

- (UITableView *)historyItemTable {
    if (!_historyItemTable) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = [UIColor whiteColor];
        
        _historyItemTable = tableView;
    }
    return _historyItemTable;
}


@end


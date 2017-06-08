//
//  RootViewController.m
//  示例Table
//
//  Created by peilinghui on 2017/6/2.
//  Copyright © 2017年 peilinghui. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"搜索框的示例";
    //ViewController对应的名称
    _items = @{
               @"Demo":@[
                       @"PLHSearchUser",
                       @"PLHSearchPlist",
                       @"PLHSearchCore",
                       @"PLHSearchVC",
                       @"PLHOwner"
                       ],
               };
    //区头与cell的名字
    _itemsName = @{
                   @"Demo":@[
                           @"UISearchBar用NSUserDefault存储",
                           @"UISearchBar用Plist存储",
                           @"UISearchBar用Core Data存储",
                           @"UISearchController用NSUserDefault存储",
                           @"自定义搜索框的实现"
                           ]
                   };
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.tableView reloadData];
    
}

#pragma mark --TableView datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [[_items allKeys]count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[_items objectForKey:[_items allKeys][section]]count];
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [_items allKeys][section];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = [_itemsName objectForKey:[_items allKeys][indexPath.section]][indexPath.row];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

    
    return cell;
}


#pragma mark -- TableView Delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *name = [_items objectForKey:[_items allKeys][indexPath.section]][indexPath.row];
    NSString *className = [name stringByAppendingString:@"ViewController"];
    Class class = NSClassFromString(className);
    UIViewController *controller = [[class alloc]init];
    controller.title = name;
    [self.navigationController pushViewController:controller animated:YES];
}

@end

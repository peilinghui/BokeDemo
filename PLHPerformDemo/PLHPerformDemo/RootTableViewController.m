//
//  RootTableViewController.m
//  PLHPerformDemo
//
//  Created by peilinghui on 2017/4/15.
//  Copyright © 2017年 peilinghui. All rights reserved.
//

#import "RootTableViewController.h"

@interface RootTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation RootTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"performSelector的使用";

    _items = @{
                        @"PerformSelector":@[
                                @"PerformSelector",
                                @"PerformSelectorThread",
                                @"PerformSelectorNo"
                                
                                ],
                        @"PerformSelector的例子":@[
                                @"按钮的多次点击",
                                ]
               };

    _itemsName=@{
                 @"PerformSelector":@[
                            @"PerformSelector的方法",
                            @"PerformSelector的延迟调用",
                            @"PerformSelector在子线程中的使用"
                         ]
                 
                 };
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return [[_items allKeys]count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[_items objectForKey:[_items allKeys][section]]count];
   
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
     return [_items allKeys][section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = [_itemsName objectForKey:[_items allKeys][indexPath.section]][indexPath.row];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

    
    return cell;
}




#pragma mark -TableView delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *name = [_items objectForKey:[_items allKeys][indexPath.section]][indexPath.row];
    
    NSString *className = [name stringByAppendingString:@"ViewController"];
    Class class = NSClassFromString(className);
    UIViewController *controller = [[class alloc]init];
    controller.title = name;
    [self.navigationController pushViewController:controller animated:YES];
    
}
@end

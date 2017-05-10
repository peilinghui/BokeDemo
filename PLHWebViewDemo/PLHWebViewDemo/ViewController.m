//
//  ViewController.m
//  PLHWebViewDemo
//
//  Created by peilinghui on 2017/5/6.
//  Copyright © 2017年 peilinghui. All rights reserved.
//

#import "ViewController.h"
#import "PLHUIWebViewController.h"
#import "PLHWKWebViewController.h"
#import "PLHLocalWKViewController.h"
#import "PLHJSCoreViewController.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSArray *_dataArr;
}

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=_navTitle;
    UIBarButtonItem *item=[[UIBarButtonItem alloc]init];
    item.title=@"";
    self.navigationItem.backBarButtonItem=item;
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.view.backgroundColor=[UIColor whiteColor];
    _dataArr=@[@"UIWebView的使用",@"WKWebView的使用",@"JavaScriptCore的使用",@"加载本地服务器页面"];
    [self createTableView];
}

-(void)createTableView{
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self.view addSubview:_tableView];
}




#pragma mark --TableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[UITableViewCell description]];
    cell.textLabel.text =_dataArr[indexPath.row];
    
    return cell;
}


#pragma mark --TableviewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            PLHUIWebViewController *uweb = [[PLHUIWebViewController alloc]init];
            [self.navigationController pushViewController:uweb animated:YES];
        }
            break;
        case 1:{
            PLHWKWebViewController *web = [[PLHWKWebViewController alloc]init];
            [self.navigationController pushViewController:web animated:YES];

        }
            break;
        case 2:{
            PLHJSCoreViewController *jsWeb = [[PLHJSCoreViewController alloc]init];
            [self.navigationController pushViewController:jsWeb animated:YES];
            
        }
            break;
        case 3:{
            PLHLocalWKViewController *localView = [[PLHLocalWKViewController alloc]init];
            [self.navigationController pushViewController:localView animated:YES];
        }
            break;
        default:
            break;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

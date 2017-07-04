//
//  PLHViewController.m
//  PLHDemo
//
//  Created by peilinghui on 2017/7/3.
//  Copyright © 2017年 user. All rights reserved.
//

#import "PLHViewController.h"
#import <Charts/Charts-Swift.h>
#import <SwipeView/SwipeView.h>
#import "PLHInfoView.h"
#import <CorePlot/CorePlot-CocoaTouch.h>
//#import "PLHYearReportBarPlot.h"
#import "PLHBarChartsView.h"
#import "PLHHorizonBarView.h"
#import "PLHLineChartView.h"

@interface PLHViewController ()<SwipeViewDelegate,SwipeViewDataSource>
@property(nonatomic,strong)SwipeView *swipeView;


@end

@implementation PLHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self.view addSubview:self.swipeView];
    
    self.title = @"SwipeView的Demo和Charts图的使用";
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor greenColor];
    [btn addTarget:self action:@selector(transferVC) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(20, 300, 40, 40);
    btn.titleLabel.text =@"跳转到条形图";
    [self.view addSubview:btn];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.backgroundColor = [UIColor redColor];
    [btn1 addTarget:self action:@selector(transferVC1) forControlEvents:UIControlEventTouchUpInside];
    btn1.frame = CGRectMake(70, 300, 40, 40);
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.backgroundColor = [UIColor blackColor];
    [btn2 addTarget:self action:@selector(transferVC2) forControlEvents:UIControlEventTouchUpInside];
    btn2.frame = CGRectMake(120, 300, 40, 40);
    [self.view addSubview:btn2];


//    YearReportBarView *yearView = [[YearReportBarView alloc]initWithFrame:CGRectMake(20, 300, 300, 200)];
//    [self.view addSubview:yearView];
   
//    NSMutableArray *yearData = [NSMutableArray arrayWithArray:@[@200000,@3022334]];
//    NSMutableArray *yearTitles = [NSMutableArray arrayWithArray:@[[NSString stringWithFormat:@"%d年",2016],[NSString stringWithFormat:@"%d年",2017]]];
//      [yearView updateContentWithData:nil xTitles:nil];
}


-(void)transferVC
{
    PLHHorizonBarView *barVC = [[PLHHorizonBarView alloc]init];
   // [self presentViewController:barVC animated:YES completion:nil];
      [self.navigationController pushViewController:barVC animated:YES];
}

-(void)transferVC1
{
    PLHBarChartsView *demoVC = [[PLHBarChartsView alloc]init];
   // [self presentViewController:demoVC animated:YES completion:nil];
      [self.navigationController pushViewController:demoVC animated:YES];
}

-(void)transferVC2
{
    PLHLineChartView *deVC = [[PLHLineChartView alloc]init];
    // [self presentViewController:demoVC animated:YES completion:nil];
    [self.navigationController pushViewController:deVC animated:YES];
}

- (void)dealloc
{
    _swipeView.delegate = nil;
    _swipeView.dataSource = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}


- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    return 5;
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    if (!view)
    {
//        view = [[NSBundle mainBundle] loadNibNamed:@"ItemV" owner:self options:nil][0];
        view = [[PLHInfoView alloc]initWithFrame:CGRectMake(0, 0, 78, 85)];
    }
    return view;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark --SwipeViewDelegate
- (CGSize)swipeViewItemSize:(SwipeView *)swipeView
{
    return CGSizeMake(78, 85);
}

- (void)swipeView:(SwipeView *)swipeView didSelectItemAtIndex:(NSInteger)index{
    
}

#pragma mark --setter getter
-(SwipeView *)swipeView{
    if (!_swipeView) {
        _swipeView = [[SwipeView alloc]initWithFrame:CGRectMake(20, 30, 400, 200)];
        _swipeView.delegate =self;
        _swipeView.dataSource = self;
        _swipeView.alignment = SwipeViewAlignmentEdge;
        _swipeView.pagingEnabled = YES;
        _swipeView.itemsPerPage = 1;
        _swipeView.truncateFinalPage = YES;
    }
    return _swipeView;
}

@end

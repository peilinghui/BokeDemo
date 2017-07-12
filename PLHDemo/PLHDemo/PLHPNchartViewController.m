//
//  PLHPNchartViewController.m
//  PLHDemo
//
//  Created by peilinghui on 2017/7/6.
//  Copyright © 2017年 user. All rights reserved.
//

#import "PLHPNchartViewController.h"
#import <PNChart/PNChart.h>
@interface PLHPNchartViewController ()

@end

@implementation PLHPNchartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setLineChart];
    [self setBarChart];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setLineChart{
//    PNLineChart * lineChart = [[PNLineChart alloc]initWithFrame:CGRectMake(0,135.0,300.0,200.0)];
//    //X轴数据
//    [lineChart setXLabels:@[@"SEP 1",@"SEP 2",@"SEP 3",@"SEP 4",@"SEP 5"]];
//    
//    //Y轴数据
//    NSArray * data01Array =@[@60.1,@160.1,@126.4,@262.2,@186.2];
//    PNLineChartData *data01 = [PNLineChartData new];
//    data01.color = PNFreshGreen;
//    data01.itemCount = lineChart.xLabels.count;
//    data01.getData = ^(NSUInteger index) {
//        CGFloat yValue = [data01Array[index] floatValue];
//        return [PNLineChartDataItem dataItemWithY:yValue];
//    };
//    
//    //可以添加多条折线
//    NSArray * data02Array =@[@20.1,@180.1,@26.4,@202.2,@126.2];
//    PNLineChartData *data02 = [PNLineChartData new];
//    data02.color = PNTwitterColor;
//    data02.itemCount = lineChart.xLabels.count;
//    data02.getData = ^(NSUInteger index) {
//        CGFloat yValue = [data02Array[index] floatValue];
//        return [PNLineChartDataItem dataItemWithY:yValue];
//    };
//    
//    lineChart.chartData = @[data01, data02];
//    [lineChart strokeChart];
//    //加载在视图上
//    [self.view addSubview:lineChart];
    PNLineChart * lineChart = [[PNLineChart alloc] initWithFrame:CGRectMake(0, 70.0, SCREEN_WIDTH, 200.0)];
    // 设置x轴上坐标内容
    [lineChart setXLabels:@[@"1",@"2",@"3",@"4",@"5"]];
    // 设置好像没什么用
    lineChart.xLabelColor = [UIColor blackColor];
    
    lineChart.showLabel = YES;
    // 是否显示Y轴的数值
    lineChart.showGenYLabels = YES;
    // 是否显示横向虚线
    lineChart.showYGridLines = YES;
    // 是否平滑的曲线
    lineChart.showSmoothLines = NO;
    // 是否显示xy 坐标轴
    lineChart.showCoordinateAxis = YES;
    // 轴的颜色
    lineChart.axisColor = [UIColor blackColor];
    // 轴的宽度
    lineChart.axisWidth = 2.0f;
    
    NSLog(@"%f",lineChart.chartMarginLeft);
    
    //    lineChart.thousandsSeparator = YES;
    // 设置y轴坐标的颜色
    lineChart.yLabelColor = [UIColor redColor];
    
    // Line Chart No.1
    NSArray * data01Array = @[@60.1, @160.1, @126.4, @262.2, @186.2];
    PNLineChartData *data01 = [PNLineChartData new];
    data01.color = PNFreshGreen;
    data01.dataTitle = @"Hello World";
    // 设置点的格式
    data01.inflexionPointStyle = PNLineChartPointStyleCircle;
    data01.inflexionPointColor = [UIColor purpleColor];
    // 是否点label
    data01.showPointLabel = YES;
    data01.pointLabelColor = [UIColor redColor];
    data01.pointLabelFont = [UIFont systemFontOfSize:12];
    data01.pointLabelFormat = @"%1.1f";
    // 设置折线有几个值
    data01.itemCount = lineChart.xLabels.count;
    data01.getData = ^(NSUInteger index) {
        CGFloat yValue = [data01Array[index] floatValue];
        
        // 设置x轴坐标对应的y轴的值
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    // Line Chart No.2
    NSArray * data02Array = @[@20.1, @180.1, @26.4, @202.2, @126.2];
    PNLineChartData *data02 = [PNLineChartData new];
    data02.color = PNTwitterColor;
    data02.itemCount = lineChart.xLabels.count;
    data02.getData = ^(NSUInteger index) {
        CGFloat yValue = [data02Array[index] floatValue];
        return [PNLineChartDataItem dataItemWithY:yValue];
    };
    // 设置line的数据数组
    lineChart.chartData = @[data01, data02];
    // 绘制出来
    [lineChart strokeChart];
    
    [self.view addSubview:lineChart];
}

-(void)setBarChart{
    PNBarChart *barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(0, 270.0, SCREEN_WIDTH, 200.0)];
    // 是否显示xy 轴的数字
    barChart.showLabel = YES;
    // 是否显示水平线 但把柱子压低上移了
    //    barChart.showLevelLine = YES;
    //是否显示xy 轴
    barChart.showChartBorder = YES;
    // 是否显示柿子的数值
    barChart.isShowNumbers = YES;
    // 立体显示
    barChart.isGradientShow = YES;
    // 设置柱子的圆角
    barChart.barRadius = 5;
    // 设置bar color
    barChart.strokeColor = [UIColor redColor];
    
    barChart.xLabels = @[@"1",@"2",@"3",@"4",@"5"];
    
    barChart.yValues = @[@"2",@"4",@"1",@"10",@"9"];
    
    barChart.yLabelFormatter = ^ (CGFloat yLabelValue) {
        
        return [NSString stringWithFormat:@"%f",yLabelValue];
    };
    
    [barChart strokeChart];
    
    [self.view addSubview:barChart];
}

@end

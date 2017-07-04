//
//  PLHHorizonBarView.m
//  PLHDemo
//
//  Created by peilinghui on 2017/7/4.
//  Copyright © 2017年 user. All rights reserved.
//

#import "PLHHorizonBarView.h"


//横向柱状图的Demo
@interface PLHHorizonBarView ()<ChartViewDelegate>
@property(strong,nonatomic)HorizontalBarChartView *horizontalChartView;
@end

@implementation PLHHorizonBarView

-(void)viewDidLoad
{
    [super viewDidLoad];

        _horizontalChartView = [[HorizontalBarChartView alloc] init];
        
        _horizontalChartView.frame = CGRectMake(20, 300, 300, 200);
        
        [self.view addSubview:self.horizontalChartView];
    
    _horizontalChartView.descriptionText = @"";//设置单位（貌似目前单位坐标固定右下角不可变）
    
    //  _horizontalChartView.noDataTextDescription = @"暂无数据";//当没有数据的时候空白页显示内容
    
    _horizontalChartView.drawGridBackgroundEnabled = NO;//是否有网格背景
    
    _horizontalChartView.dragEnabled = YES;//是否启动拖拽
    
    [_horizontalChartView setScaleEnabled:YES];
    
    _horizontalChartView.pinchZoomEnabled = YES;
    
    _horizontalChartView.drawBarShadowEnabled = NO;//背景是否填满
    
    _horizontalChartView.drawValueAboveBarEnabled = YES;//值是在图里面还是在图外面
    
    _horizontalChartView.maxVisibleCount = 60;//多少数据时开始不显示y值
    
    _horizontalChartView.legend.enabled = YES;//是否启用标注栏
    
    ChartXAxis *xAxis = _horizontalChartView.xAxis;//x坐标
    
    xAxis.labelPosition = XAxisLabelPositionTop;//坐标样式
    
    _horizontalChartView.rightAxis.enabled = NO;//右侧x轴是否启用（当然还有对应的左侧）
    
    xAxis.labelFont = [UIFont systemFontOfSize:10.f];//x轴字体大小
    
    xAxis.drawAxisLineEnabled = YES;
    
    xAxis.drawGridLinesEnabled = NO;
    
    xAxis.gridLineWidth = 0.3f;//x坐标线粗细
    
    
    //Y轴
    
    ChartYAxis *leftAxis = _horizontalChartView.leftAxis;//左边Y轴
    
    leftAxis.labelFont = [UIFont systemFontOfSize:10.f];
    
    leftAxis.drawAxisLineEnabled = YES;
    
    leftAxis.drawGridLinesEnabled = YES;
    
    leftAxis.gridLineWidth = 0.3f;
    
    leftAxis.axisMinValue = 0.0f;//y轴起始值（最小值）
    
    leftAxis.spaceTop = 0.3f;//y轴顶部距图形顶部距离占总长的百分比（对应的还有底部）
    
    [self setData];
}

-(void)setData
{
    NSMutableArray *xVals = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 12; i++)
    {
        [xVals addObject:[NSString stringWithFormat:@"%d",i]];
    }
    
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    NSArray *colors = @[[UIColor redColor],[UIColor greenColor],[UIColor blackColor]];
    double spaceForBar = 10.0;
    for (int i = 0 ; i < 2; i++)
    {
        NSMutableArray *yDataArray = [[NSMutableArray alloc] init];
        
        for(int j = 0; j<12; j++){
            
            double mult = 100;
            
            double val = (double) (arc4random_uniform(mult));
            
            //           [yDataArray addObject:[[BarChartDataEntry alloc] initWithValue:val xIndex:j]];
         //   [yDataArray addObject:[[BarChartDataEntry alloc]initWithX:i * spaceForBar y:val data:nil]];
            [yDataArray addObject:[[BarChartDataEntry alloc]initWithX:j y:val]];
        }
        
        BarChartDataSet *set = [[BarChartDataSet alloc] initWithValues:yDataArray label:[NSString stringWithFormat:@"第%@项",xVals[i]]];
        set.values = yDataArray;
        [set setColors:@[colors[i]]];
        [dataSets addObject:set];
    }
    
    BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
    
    [data setValueFont:[UIFont systemFontOfSize:10]];
    
    _horizontalChartView.data = data;
    
//    [_horizontalChartView animateWithYAxisDuration:2.5];//动画效果
}

@end

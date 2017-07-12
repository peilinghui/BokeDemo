//
//  PLHBarChartsView.m
//  PLHDemo
//
//  Created by peilinghui on 2017/7/4.
//  Copyright © 2017年 user. All rights reserved.
//

#import "PLHBarChartsView.h"
#import <Charts/Charts-Swift.h>
#import "DayAxisValueFormatter.h"


//库的Demo
@interface PLHBarChartsView ()<ChartViewDelegate>
@property (nonatomic, strong) BarChartView *chartView;
@property (nonatomic, strong) BarChartData *data;

@end

@implementation PLHBarChartsView

-(void)viewDidLoad
{
    [super viewDidLoad];
    _chartView = [[BarChartView alloc]init];
   
    _chartView.frame = CGRectMake(20, 300, 300, 200);
     [self.view addSubview:self.chartView];
    _chartView.delegate = self;
        _chartView.drawBarShadowEnabled = NO;
        _chartView.drawValueAboveBarEnabled = YES;
        
        _chartView.maxVisibleCount = 60;
    
    //交互设置
        _chartView.scaleYEnabled = NO;//取消Y轴缩放
        _chartView.doubleTapToZoomEnabled = NO;//取消双击缩放
        _chartView.dragEnabled = YES;//启用拖拽图表
        _chartView.dragDecelerationEnabled = YES;//拖拽后是否有惯性效果
       _chartView.dragDecelerationFrictionCoef = 0.9;//拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显

        ChartXAxis *xAxis = _chartView.xAxis;
        xAxis.labelPosition = XAxisLabelPositionBottom;
        xAxis.labelFont = [UIFont systemFontOfSize:10.f];
        xAxis.drawGridLinesEnabled = NO;
        xAxis.granularity = 1.0; // only intervals of 1 day
        xAxis.labelCount = 5;
#pragma mark --x轴数据的设置方法
        xAxis.valueFormatter = [[DayAxisValueFormatter alloc] initForChart:_chartView];
        
        NSNumberFormatter *leftAxisFormatter = [[NSNumberFormatter alloc] init];
        leftAxisFormatter.minimumFractionDigits = 0;
        leftAxisFormatter.maximumFractionDigits = 1;
        leftAxisFormatter.negativeSuffix = @" $";
        leftAxisFormatter.positiveSuffix = @" $";
        
        ChartYAxis *leftAxis = _chartView.leftAxis;
        leftAxis.labelFont = [UIFont systemFontOfSize:10.f];
        leftAxis.labelCount = 20;
        leftAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc] initWithFormatter:leftAxisFormatter];
        leftAxis.labelPosition = YAxisLabelPositionOutsideChart;
        leftAxis.spaceTop = 0.15;
        leftAxis.axisMinimum = 0.0; // this replaces startAtZero = YES
        
        ChartYAxis *rightAxis = _chartView.rightAxis;
        rightAxis.enabled = YES;
        rightAxis.drawGridLinesEnabled = NO;
        rightAxis.labelFont = [UIFont systemFontOfSize:10.f];
        rightAxis.labelCount = 10;
        rightAxis.valueFormatter = leftAxis.valueFormatter;
        rightAxis.spaceTop = 0.15;
        rightAxis.axisMinimum = 0.0; // this replaces startAtZero = YES
        
        ChartLegend *l = _chartView.legend;
        l.horizontalAlignment = ChartLegendHorizontalAlignmentLeft;
        l.verticalAlignment = ChartLegendVerticalAlignmentBottom;
        l.orientation = ChartLegendOrientationHorizontal;
        l.drawInside = NO;
        l.form = ChartLegendFormSquare;
        l.formSize = 9.0;
        l.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.f];
        l.xEntrySpace = 4.0;

#pragma mark --设置x轴的范围和y轴的范围
        [self setDataCount:15 range:80];
}

- (void)setDataCount:(int)count range:(double)range
{
    double start = 1.0;
    
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    
    for (int i = start; i < start + count + 1; i++)
    {
        double mult = (range + 1);
        double val = (double) (arc4random_uniform(mult));
        [yVals addObject:[[BarChartDataEntry alloc] initWithX:i y:val]];
    }
    
#pragma mark --BarChartDataSet就是每一个
    BarChartDataSet *set1 = nil;
    if (_chartView.data.dataSetCount > 0)
    {
        set1 = (BarChartDataSet *)_chartView.data.dataSets[0];
        set1.values = yVals;
        [_chartView.data notifyDataChanged];
        [_chartView notifyDataSetChanged];
    }
    else
    {
        set1 = [[BarChartDataSet alloc] initWithValues:yVals label:@"The year 2017"];
        [set1 setColors:ChartColorTemplates.material];
     //   set1.drawIconsEnabled = NO;
        
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        
#pragma mark --条形图上面的数据
        BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
        [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10.f]];
        
        data.barWidth = 0.9f;
        
        _chartView.data = data;
    }
}

@end

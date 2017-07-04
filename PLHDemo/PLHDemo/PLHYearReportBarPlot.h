//
//  PLHYearReportBarPlot.h
//  PLHDemo
//
//  Created by peilinghui on 2017/7/4.
//  Copyright © 2017年 user. All rights reserved.
//

#import <CorePlot/CorePlot.h>

@interface PLHYearReportBarPlot : CPTBarPlot<CPTPlotDataSource>

@property (strong,nonatomic)NSMutableArray *dataPointsArray;//数据点的数组
@property (strong,nonatomic)NSMutableArray *xAxisArray;//x轴的数组

//布局颜色
- (id)initWithFrame:(CGRect)newFrame
              color:(CPTColor *)color
          baseValue:(NSNumber *)baseValue
          barOffSet:(NSNumber *)barOffSet;

//设置x.y轴和条形图的间距
- (void)setXYAxisWithGraph:(CPTGraph*)graph
                 plotSpace:(CPTXYPlotSpace*)plotSpace;
@end

@interface YearReportBarView : UIView
{
    CPTGraphHostingView *_hostingView;
    PLHYearReportBarPlot     *_barGraphics;
    CPTXYGraph          *_graph;
    CPTXYPlotSpace      *_barSpace;
}

//用数据更新内容，x轴的标题
- (void)updateContentWithData:(NSArray*)dataArray xTitles:(NSArray*)xTitles;

@end

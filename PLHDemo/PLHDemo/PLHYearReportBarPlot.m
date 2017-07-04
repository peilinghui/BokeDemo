//
//  PLHYearReportBarPlot.m
//  PLHDemo
//
//  Created by peilinghui on 2017/7/4.
//  Copyright © 2017年 user. All rights reserved.
//

#import "PLHYearReportBarPlot.h"
#import "NSMutableArray+MaxNumber.h"
@implementation PLHYearReportBarPlot

//对于每一个条形图的上面的文字
-(CPTLayer *)dataLabelForPlot:(CPTPlot *)plot recordIndex:(NSUInteger)index
{
    NSInteger f = [self.dataPointsArray[index] integerValue];
    NSString *strToDisplay = nil;
    if (f >= 10000){
        strToDisplay = [NSString stringWithFormat:@"%ld万",f/10000];
         strToDisplay = [NSString stringWithFormat:@"128万"];
    }else{
        strToDisplay = [NSString stringWithFormat:@"%ld",(long)f];
    }
    CPTTextLayer *label = [[CPTTextLayer alloc] initWithText: strToDisplay ];
    CPTMutableTextStyle *textStyle = [label.textStyle mutableCopy];
    textStyle.fontSize = 10.0f;
    textStyle.color = [CPTColor colorWithCGColor: (__bridge CGColorRef _Nonnull)([UIColor blackColor])];
    label.textStyle = textStyle;
    
    return label;
}

//柱状图的条数
-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot {
    if ([_dataPointsArray isMemberOfClass:[NSNull class]]) {
        return 0;
    }
    return [_dataPointsArray count];
}

//
-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    
    if (fieldEnum == CPTBarPlotFieldBarLocation) {
        return @(index+1);
    } else {
        if ([_dataPointsArray isMemberOfClass:[NSNull class]]) {
            return @(0);
        }
        return _dataPointsArray[index];
    }
    
    return nil;

}

//设置frame和颜色还有样式间距
- (id)initWithFrame:(CGRect)newFrame
              color:(CPTColor *)color
          baseValue:(NSNumber*)baseValue
          barOffSet:(NSNumber *)barOffSet
{
    self = [super initWithFrame:newFrame];
    
    if (self) {
        self.baseValue = baseValue;
        //设置宽度
        self.barWidth = [NSNumber numberWithFloat:0.2];
        self.barOffset = barOffSet;
        self.barOffset = barOffSet;
        self.labelOffset = 1.0f;
        
        CPTFill *cptFill = [[CPTFill alloc] initWithColor:[CPTColor colorWithCGColor:(__bridge CGColorRef _Nonnull)([UIColor blackColor])]];
        self.fill = cptFill;
        self.dataSource = self;
        
        CPTMutableLineStyle *barLineStyle = [CPTMutableLineStyle lineStyle];
        barLineStyle.lineColor = [CPTColor clearColor];
        self.lineStyle = barLineStyle;
    }
    return self;
}

//设置x.y轴，间距
- (void)setXYAxisWithGraph:(CPTGraph*)graph
                 plotSpace:(CPTXYPlotSpace*)plotSpace
{
    graph.plotAreaFrame.masksToBorder = NO;
    
    // 隐藏frame Border
    graph.plotAreaFrame.borderLineStyle=nil;
    graph.plotAreaFrame.cornerRadius=0.0f;
    
    // set up line style
    CPTMutableLineStyle *barLineStyle = [[CPTMutableLineStyle alloc] init];
    barLineStyle.lineColor = [CPTColor colorWithCGColor:(__bridge CGColorRef _Nonnull)([UIColor blackColor])];
    barLineStyle.lineWidth = 0.5;
    // set up text style
    CPTMutableTextStyle *textStyle = [CPTMutableTextStyle textStyle];
    textStyle.color = [CPTColor colorWithCGColor:(__bridge CGColorRef _Nonnull)([UIColor blackColor])];
    textStyle.fontSize = 12.0f;
    
    CGFloat num = 0;
    if (_dataPointsArray.count > 0) {
        num  = [_dataPointsArray maxNumberOfArray];
    }
    

    //set up plot space
    CGFloat xMin = 0.1;
    CGFloat xMax = _xAxisArray.count ;
    CGFloat yMin = 0;
    CGFloat yMax = num;
    if (yMax <= 0) {
        yMax = 1000;
    }
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:[NSNumber numberWithInt:1] length:[NSNumber numberWithFloat:(xMax+xMin)]];
    plotSpace.yRange=[CPTPlotRange plotRangeWithLocation:[NSNumber numberWithFloat:yMin] length:[NSNumber numberWithFloat:(yMax * 1.2)]];
    
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *)graph.axisSet;
    CPTXYAxis *x          = axisSet.xAxis;
    {
        NSMutableArray *xLabelArray = [NSMutableArray array];
        NSMutableArray *xLocationArray = [NSMutableArray array];
        float xLabelLocation = 1.0f;
        
        // x轴步进值
        NSInteger step = 1;
        
        NSString* xLabelTitle = @"";
        for (int index=0; index < _xAxisArray.count; index += step) {
            xLabelTitle = (NSString*)_xAxisArray[index];
            CPTAxisLabel *newLabel = [[CPTAxisLabel alloc] initWithText:xLabelTitle textStyle:textStyle];
//            newLabel.tickLocation = [@(xLabelLocation) decimalValue];
            newLabel.tickLocation = [NSNumber numberWithFloat:xLabelLocation];
            newLabel.offset = x.labelOffset + x.majorTickLength;
            [xLabelArray addObject:newLabel];
            
            [xLocationArray addObject:@(xLabelLocation)];
            xLabelLocation += step;
        }
        
        
        x.labelingPolicy = CPTAxisLabelingPolicyNone;
        x.majorTickLocations = [NSSet setWithArray:xLocationArray];
        x.axisLabels = [NSSet setWithArray:xLabelArray];
        x.majorTickLineStyle = nil;// barLineStyle;
        x.minorTickLineStyle = nil;//barLineStyle;
        x.axisLineStyle = barLineStyle;
        CGFloat fontSize = textStyle.fontSize;
        textStyle.fontSize = 11.0f;
        x.labelTextStyle = textStyle;
        textStyle.fontSize = fontSize;
        x.plotSpace = plotSpace;
    }
    
    CPTXYAxis *y         = axisSet.yAxis;
    y.majorTickLocations = nil;
    y.labelTextStyle = nil;
    y.hidden = YES;
}

@end


@implementation YearReportBarView

//设置View的frame
- (id)initWithFrame:(CGRect)frame
{
    self  = [super initWithFrame:frame];
    if (self){
        [self configureHostViewAndPlotSpace];
    }
    return self;
}

//更新view中的数据
- (void)updateContentWithData:(NSArray*)dataArray xTitles:(NSArray*)xTitles
{
    id barDatas = dataArray;
    if (barDatas) {
        NSMutableArray* listData = [NSMutableArray arrayWithArray:barDatas];
        if (xTitles.count) {
            _barGraphics.xAxisArray = [NSMutableArray arrayWithArray:xTitles];
        }
        
        _barGraphics.dataPointsArray = listData;
    }
    
    [_barGraphics setXYAxisWithGraph:_graph plotSpace:_barSpace];
    [_barGraphics reloadData];
}

//设置空白间距
- (void)configureHostViewAndPlotSpace {
    _graph = [[CPTXYGraph alloc] initWithFrame:CGRectZero];
    // 绘图区4边留白
    _graph.plotAreaFrame.paddingTop = 0;
    _graph.plotAreaFrame.paddingRight = 0;
    _graph.plotAreaFrame.paddingLeft = 0;
    _graph.plotAreaFrame.paddingBottom = 10;
    
    _hostingView = [[CPTGraphHostingView alloc] initWithFrame:self.bounds];
    _hostingView.userInteractionEnabled = YES;
    _hostingView.hostedGraph = _graph;
    [self addSubview:_hostingView];
    
    
    
    // 柱形
    _barSpace = [[CPTXYPlotSpace alloc] init];
    [_graph addPlotSpace:_barSpace];
    _barGraphics = [[PLHYearReportBarPlot alloc] initWithFrame:CGRectZero
                                                      color:[CPTColor colorWithCGColor:(__bridge CGColorRef _Nonnull)([UIColor blackColor])]
                                                  baseValue:[NSNumber numberWithFloat:0]
                                                  barOffSet:[NSNumber numberWithFloat:-0.0]];
    [_graph insertPlot:_barGraphics atIndex:0 intoPlotSpace:_barSpace];
}


@end

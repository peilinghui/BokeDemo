//
//  PLHSrearchFBViewController.m
//  示例Table
//
//  Created by peilinghui on 2017/6/8.
//  Copyright © 2017年 peilinghui. All rights reserved.
//

#import "PLHSrearchFBViewController.h"
#import "SelectCollectionLayout.h"
#import "SelectCollectionReusableView.m"
#import "PLHDBHandle.h"
#import "PLHSearchSectionModel.h"
static NSString *const kSearchCollectionViewCell = @"kSearchCollectionViewCell";
static NSString *const kheaderViewIden = @"HeaderViewIden";

@interface PLHSrearchFBViewController ()<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionReusableViewButtonDelegate
>

@property (nonatomic,strong)NSMutableArray *sectionArray;//本地缓存的
@property (nonatomic,strong)NSMutableArray *searchArray;//搜索的数组
@property (nonatomic,strong)UICollectionView *searchCollectionView;
@property (nonatomic,strong)UITextField *searchTextField;


@end

@implementation PLHSrearchFBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self prepareData];
    
    [self.searchCollectionView setCollectionViewLayout:[[SelectCollectionLayout alloc]init] animated:YES];
    //设置区头
    [self.searchCollectionView registerClass:[SelectCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kheaderViewIden];
    
}

-(void)prepareData{
    //假数据
    NSDictionary *testDict = @{
                               @"section_id":@"1",
                               @"section_title":@"热搜",
                               @"section_content":@[
                                       @{@"content_name":@"化妆棉" },
                                       @{@"content_name":@"面膜"},
                                        @{@"content_name":@"面膜"},
                                        @{@"content_name":@"面膜"},
                                        @{@"content_name":@"面膜"},
                                        @{@"content_name":@"面膜"},
                                        @{@"content_name":@"面膜"},
                                        @{@"content_name":@"洗面奶"}
                                       ]
                               };
    NSMutableArray *testArray = [@[]mutableCopy];
    [testArray addObject:testDict];
    
    //去FMDB数据库查看是否有数据
    NSDictionary *paramDic = @{@"category":@"1"};
    NSDictionary *dbDictionary = [PLHDBHandle statuesWithParams:paramDic];
    
    if (dbDictionary.count) {
        [testArray addObject:dbDictionary];
        [self.searchArray addObjectsFromArray:dbDictionary[@"section_content"]];
    }
    
    for (NSDictionary *sectionDic in testArray) {
        PLHSearchSectionModel *model = [[PLHSearchSectionModel alloc]initWithDictionary:sectionDic];
        [self.searchArray addObject:model];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.searchTextField becomeFirstResponder];
}


#pragma mark --UICollectionView Data Source

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    PLHSearchSectionModel *sectionModel = self.searchArray[section];
    return sectionModel.section_contentArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma  mark --Setter
-(NSMutableArray *)sectionArray
{
    if (_sectionArray) {
        _sectionArray = [NSMutableArray array];
    }
    return _sectionArray;
}

-(NSMutableArray *)searchArray
{
    if (_searchArray) {
        _searchArray = [NSMutableArray array];
    }
    return _searchArray;
}

@end

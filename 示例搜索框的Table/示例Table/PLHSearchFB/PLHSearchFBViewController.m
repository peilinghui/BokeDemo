//
//  PLHSrearchFBViewController.m
//  示例Table
//
//  Created by peilinghui on 2017/6/8.
//  Copyright © 2017年 peilinghui. All rights reserved.
//

#import "PLHSearchFBViewController.h"
#import "SelectCollectionLayout.h"
#import "SelectCollectionReusableView.h"
#import "PLHDBHandle.h"
#import "PLHSearchModel.h"
#import "PLHSearchSectionModel.h"
#import "PLHSearchCollectionViewCell.h"


///屏幕宏
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
static NSString *const kSearchCollectionViewCell = @"kSearchCollectionViewCell";
static NSString *const kheaderViewIden = @"HeaderViewIden";

@interface PLHSearchFBViewController ()<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionReusableViewButtonDelegate,
SelectCollectionCellDelegate,
UITextFieldDelegate
>

@property (nonatomic,strong)NSMutableArray *sectionArray;//本地缓存的
@property (nonatomic,strong)NSMutableArray *searchArray;//搜索的数组
@property (nonatomic,strong)UICollectionView *searchCollectionView;
@property (nonatomic,strong)UITextField *searchTextField;


@end

@implementation PLHSearchFBViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self prepareData];
    [self initMainView];
   
  
    
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
    NSDictionary *dbDictionary = [PLHDBHandle statusesWithParams:paramDic];
    
    if (dbDictionary.count) {
        [testArray addObject:dbDictionary];
        [self.searchArray addObjectsFromArray:dbDictionary[@"section_content"]];
    }
    
    for (NSDictionary *sectionDic in testArray) {
        PLHSearchSectionModel *model = [[PLHSearchSectionModel alloc]initWithDictionary:sectionDic];
        [self.searchArray addObject:model];
    }
}

-(void)initMainView{
    SelectCollectionLayout *flowLayout=[[SelectCollectionLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.minimumLineSpacing=20;
    flowLayout.minimumInteritemSpacing=0;
    flowLayout.itemSize = CGSizeMake(70, 70);
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
  //  flowLayout.sectionHeight = 40;
    
    self.searchCollectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 5, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:flowLayout];
    self.searchCollectionView.dataSource=self;
    self.searchCollectionView.delegate=self;
    [self.searchCollectionView setBackgroundColor:[UIColor redColor]];
    [self.searchCollectionView registerClass:[SelectCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kheaderViewIden];
    [self.searchCollectionView registerClass:[PLHSearchCollectionViewCell class] forCellWithReuseIdentifier:@"PLHSearchCollectionViewCell"];
    [self.view addSubview:self.searchCollectionView];

}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.searchTextField becomeFirstResponder];
}


#pragma mark --UICollectionView Data Source
//require
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    PLHSearchSectionModel *sectionModel = self.searchArray[section];
    return sectionModel.section_contentArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PLHSearchCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kSearchCollectionViewCell forIndexPath:indexPath];
    PLHSearchSectionModel *sectionModel =  self.sectionArray[indexPath.section];
    PLHSearchModel *contentModel = sectionModel.section_contentArray[indexPath.row];
    [cell.contentButton setTitle:contentModel.content_name forState:UIControlStateNormal];
    cell.selectDelegate = self;
    return cell;
}


//option
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.sectionArray.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    if ([kind isEqualToString: UICollectionElementKindSectionHeader]){
        SelectCollectionReusableView* view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kheaderViewIden forIndexPath:indexPath];
        view.delectDelegate = self;
        PLHSearchSectionModel *sectionModel =  self.sectionArray[indexPath.section];
        [view setText:sectionModel.section_title];
        /***  此处完全 也可以自定义自己想要的模型对应放入*/
        if(indexPath.section == 0)
        {
            [view setImage:@"cxCool"];
            view.delectButton.hidden = YES;
        }else{
            [view setImage:@"cxSearch"];
            view.delectButton.hidden = NO;
        }
        reusableview = view;
    }
    return reusableview;
}

- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PLHSearchSectionModel *sectionModel =  self.sectionArray[indexPath.section];
    if (sectionModel.section_contentArray.count > 0) {
        PLHSearchModel *contentModel = sectionModel.section_contentArray[indexPath.row];
        return [PLHSearchCollectionViewCell getSizeWithText:contentModel.content_name];
    }
    return CGSizeMake(80, 24);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}


#pragma mark - SelectCollectionCellDelegate
- (void)selectButttonClick:(PLHSearchCollectionViewCell *)cell;
{
    NSIndexPath* indexPath = [self.searchCollectionView indexPathForCell:cell];
    PLHSearchSectionModel *sectionModel =  self.sectionArray[indexPath.section];
    PLHSearchModel *contentModel = sectionModel.section_contentArray[indexPath.row];
    NSLog(@"您选的内容是：%@",contentModel.content_name);
    
    UIAlertView *al = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithFormat:@"您该去搜索 %@ 的相关内容了",contentModel.content_name] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"知道了！", nil];
    [al show];
}

#pragma mark - scrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.searchTextField resignFirstResponder];
}
#pragma mark - textField
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([[textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""]){
        return NO;
    }
    /***  每搜索一次   就会存放一次到历史记录，但不存重复的*/
    if ([self.searchArray containsObject:[NSDictionary dictionaryWithObject:textField.text forKey:@"content_name"]]) {
        return YES;
    }
    [self reloadData:textField.text];
    return YES;
}
- (void)reloadData:(NSString *)textString
{
    [self.searchArray addObject:[NSDictionary dictionaryWithObject:textString forKey:@"content_name"]];
    
    NSDictionary *searchDict = @{@"section_id":@"2",@"section_title":@"历史记录",@"section_content":self.searchArray};
    
    /***由于数据量并不大 这样每次存入再删除没问题  存数据库*/
    NSDictionary *parmDict  = @{@"category":@"1"};
    [PLHDBHandle saveStatuses:searchDict andParam:parmDict];
    
    PLHSearchSectionModel *model = [[PLHSearchSectionModel alloc]initWithDictionary:searchDict];
    if (self.sectionArray.count > 1) {
        [self.sectionArray removeLastObject];
    }
    [self.sectionArray addObject:model];
    [self.searchCollectionView reloadData];
    self.searchTextField.text = @"";
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


-(UITextField *)searchTextField{
    if(!_searchTextField) {
        _searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(34, 5, 233, 32)];
        _searchTextField.font = [UIFont systemFontOfSize:14];
        _searchTextField.textColor = [UIColor whiteColor];
        _searchTextField.backgroundColor = [UIColor blackColor];
        _searchTextField.textAlignment = NSTextAlignmentLeft;
        _searchTextField.placeholder = @"输入名称";
        [_searchTextField setDelegate:self];
        [_searchTextField setValue:[UIColor whiteColor]  forKeyPath:@"_placeholderLabel.textColor"];
     
    }
    return _searchTextField;
}
@end

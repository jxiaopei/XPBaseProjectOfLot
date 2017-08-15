//
//  LiveDataViewController.m
//  baseProgram
//
//  Created by iMac on 2017/7/29.
//  Copyright © 2017年 eirc. All rights reserved.
//

#import "BPLiveDataViewController.h"
#import "BPLiveDataCell.h"
#import "BPLiveDataModel.h"
#import "BPLiveCollectionViewCell.h"
#import "BPBaseWebViewController.h"

@interface BPLiveDataViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)NSMutableArray <BPLiveDataModel *>*dataSource;
@property(nonatomic,strong)NSMutableArray <BPLiveDataModel *>*allDataSource;
@property(nonatomic,strong)NSMutableArray <BPLiveDataModel *>*finishDataSource;
@property(nonatomic,strong)NSMutableArray <BPLiveDataModel *>*attentionDataSource;
@property(nonatomic,strong)NSMutableArray *dateArr;
@property(nonatomic,strong)NSDictionary *statusNameDict;
@property(nonatomic,strong)UICollectionView *collectView;
@property(nonatomic,strong)UIButton *selectedBtn;
@property(nonatomic,strong)UIView *bottomLineView;
@property(nonatomic,strong)UIView *titleView;

@property(nonatomic,strong)UIButton *selectedDateBtn; //日期选择
@property(nonatomic,strong)UIView *dateSelectView;
@property(nonatomic,copy)NSString *selectedDate;
@property(nonatomic,assign)NSInteger tag;

@end

@implementation BPLiveDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *selectDate = [UIButton new];
    selectDate.frame = CGRectMake(SCREENWIDTH - 35, 17, 30, 30);
    [selectDate setImage:[UIImage imageNamed:@"日历"] forState:UIControlStateNormal];
    selectDate.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    [selectDate addTarget:self action:@selector(didClickSelectDateBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnItem = [[UIBarButtonItem alloc]initWithCustomView:selectDate];
    self.navigationItem.rightBarButtonItem = btnItem;
    
    _tag = 0;
    _selectedDate = nil;
    [self setupCollectView];
    [self getDataWithDateStr:nil];
    [self setupTitleView];
}

-(void)didClickSelectDateBtn:(UIButton *)sender
{
    if(_dateSelectView)
    {
        [_dateSelectView removeFromSuperview];
    }
    if(_dateArr.count == 0)
    {
        return;
    }
    UIView *dateSelectView = [UIView new];
    dateSelectView.backgroundColor = [UIColor whiteColor];
    _dateSelectView = dateSelectView;
    [self.view addSubview:dateSelectView];
    dateSelectView.frame = CGRectMake(SCREENWIDTH - 80 , 0, 80, 7*20);
    for(int i = 0; i < _dateArr.count ; i++)
    {
        UIButton *btn = [UIButton new];
        [dateSelectView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.centerX.mas_equalTo(dateSelectView);
            make.top.mas_equalTo( 20 * i);
            make.height.mas_equalTo(20);
        }];
        [btn setTitle:_dateArr[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(didClickDateBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:10];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.tag = i;
        NSDate *currentDate = [NSDate date];
        NSDateFormatter *formatter = [NSDateFormatter new];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateStr = [formatter stringFromDate:currentDate];
        if(!_selectedDate)
        {
            if([dateStr isEqualToString:_dateArr[i]])
            {
                btn.selected = YES;
                self.selectedBtn = btn;
            }
        }else{
            if([_selectedDate isEqualToString:_dateArr[i]])
            {
                btn.selected = YES;
                self.selectedBtn = btn;
            }
        }
        
    }
}

-(void)didClickDateBtn:(UIButton *)sender
{
    if(_dateSelectView)
    {
        [_dateSelectView removeFromSuperview];
    }
    sender.selected = YES;
    self.selectedDateBtn.selected = NO;
    self.selectedDateBtn = sender;
    [self getDataWithDateStr:_dateArr[sender.tag]];
    _selectedDate = _dateArr[sender.tag];
}

-(void)getDataWithDateStr:(NSString *)dateStr
{
    NSString *urlStr = nil;
    if(!dateStr)
    {
         urlStr = self.contestType == BPFootballContestType ? @"http://live.zhuoyicp.com/api/fscore?&issue=&mtype=jz" :  @"http://live.zhuoyicp.com/api/bscore?issue=&mtype=jclq";//http://live.zhuoyicp.com/api/fscore?&issue=&mtype=jz&uid=2755899
    }else{
        
        urlStr = self.contestType == BPFootballContestType ? [NSString stringWithFormat:@"http://live.zhuoyicp.com/api/fscore?&issue=%@&mtype=jz",dateStr]  :  [NSString stringWithFormat:@"http://live.zhuoyicp.com/api/bscore?issue=%@&mtype=jclq",dateStr];
    }

    
    [[BPNetRequest getInstance] getListDataWithUrl:urlStr parameters:nil success:^(id responseObject) {
        NSLog(@"%@",[responseObject mj_JSONString]);
        if([responseObject[@"message"] floatValue] > 0)
        {
            self.allDataSource = [BPLiveDataModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            self.statusNameDict = responseObject[@"status_name"];
            
            for(BPLiveDataModel *model in self.allDataSource)
            {
                NSString *key = [NSString stringWithFormat:@"%zd",model.ss];
               if( [self.statusNameDict[key] isEqualToString:@"完场"])
               {
                   [self.finishDataSource addObject:model];
               }
                if(model.isFocus)
                {
                    [self.attentionDataSource addObject:model];
                }
            }
            
            if(_tag == 0){
                self.dataSource = self.allDataSource;
            }else if(_tag == 1){
                self.dataSource = self.finishDataSource;
            }else if (_tag == 2){
                self.dataSource = self.attentionDataSource;
            }
            self.dateArr = responseObject[@"issue"];
            [self.collectView reloadData];
        }

        
    } fail:^(NSError *error) {
        NSLog(@"%@",error.description);
    }];
    
}

-(void)setupCollectView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 10;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *collectView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 40, SCREENWIDTH, SCREENHEIGHT - 40 - 64) collectionViewLayout:layout];
    [self.view addSubview:collectView];
    _collectView = collectView;
    _collectView.pagingEnabled = YES;
    collectView.delegate = self;
    collectView.dataSource = self;
    collectView.backgroundColor = [UIColor blackColor];
     [collectView registerClass:[BPLiveCollectionViewCell class] forCellWithReuseIdentifier:@"liveCollectionViewCell"];
    
}

-(void)setupTitleView
{
    UIView *titleView = [UIView new];
    [self.view addSubview:titleView];
    _titleView = titleView;
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
    
    NSArray *titleArr = @[@"全部",@"已结束",@"关注"];
    for(int i = 0 ; i < titleArr.count;i++)
    {
        UIButton *btn = [UIButton new];
        [titleView addSubview:btn];
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        btn.frame = CGRectMake(i * SCREENWIDTH/3, 0, SCREENWIDTH/3, 36);
        btn.tag = i;
        [btn addTarget:self action:@selector(didClickTitleViewBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        if(i == 0)
        {
            [self didClickTitleViewBtn:btn];
        }
    }
    
    UIView *bottomLineView = [UIView new];
    [titleView addSubview:bottomLineView];
    _bottomLineView = bottomLineView;
    bottomLineView.backgroundColor = [UIColor redColor];
    bottomLineView.frame = CGRectMake(0, 36, SCREENWIDTH/3, 3);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(_dateSelectView)
    {
        [_dateSelectView removeFromSuperview];
    }
    CGFloat offsetX =scrollView.contentOffset.x;
    if(offsetX == SCREENWIDTH || offsetX == SCREENWIDTH * 2 || offsetX == 0)
    {
        NSInteger tag =  offsetX/SCREENWIDTH;
        for(int i = 0;i < _titleView.subviews.count ; i++)
        {
            if([_titleView.subviews[i] isKindOfClass:[UIButton class]])
            {
                if(tag == _titleView.subviews[i].tag )
                {
                    UIButton *btn = _titleView.subviews[i];
                    btn.selected = YES;
                    self.selectedBtn.selected = NO;
                    self.selectedBtn = btn;
                    [self didClickTitleViewBtn:btn];
                }
            }
        }
    }
    
}

-(void)didClickTitleViewBtn:(UIButton *)sender
{
    [_collectView setContentOffset:CGPointMake(sender.tag * SCREENWIDTH, 0) animated:YES];
    [UIView animateWithDuration:0.3 animations:^{
        _bottomLineView.frame = CGRectMake(sender.tag * SCREENWIDTH/3, 36, SCREENWIDTH/3, 3);
    }];
    
    _tag = sender.tag;
    
    [self getDataWithDateStr:_selectedDate];
    
//    [self.collectView reloadData];
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BPLiveCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"liveCollectionViewCell" forIndexPath:indexPath];
    cell.dataSource = self.dataSource;
    cell.statusNameDict = self.statusNameDict;
    cell.contestType = self.contestType;
    cell.jumpToWebVCBlock = ^(NSInteger index){
      
        BPLiveDataModel *model = self.dataSource[index];
        BPBaseWebViewController *webVC = [BPBaseWebViewController new];
        NSString *urlstr = [NSString stringWithFormat:@"http://m.zhuoyicp.com/bfyc?match_id=%zd&param=eyJzaWQiOiIzMTAwMjAwMTAwNiIsInNlaWQiOiItMTExMSIsInVzZXJJZCI6Ii0xMTExIiwiYXBwVmVyc2lvbiI6IjMuMi43IiwiZnJvbSI6ImlvcyJ9#/",model.matchId];
        webVC.urlString = urlstr;
        webVC.title = @"赛事详情";
        [self.navigationController pushViewController:webVC animated:YES];
        
    };
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView  layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    return CGSizeMake(SCREENWIDTH,SCREENHEIGHT - 40 - 64);
}


-(NSMutableArray <BPLiveDataModel *>*)dataSource
{
    if(_dataSource == nil)
    {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

-(NSMutableArray <BPLiveDataModel *>*)allDataSource
{
    if(_allDataSource == nil)
    {
        _allDataSource = [NSMutableArray array];
    }
    return _allDataSource;
}

-(NSMutableArray <BPLiveDataModel *>*)finishDataSource
{
    if(_finishDataSource == nil)
    {
        _finishDataSource = [NSMutableArray array];
    }
    return _finishDataSource;
}

-(NSMutableArray <BPLiveDataModel *>*)attentionDataSource
{
    if(_attentionDataSource == nil)
    {
        _attentionDataSource = [NSMutableArray array];
    }
    return _attentionDataSource;
}

-(NSMutableArray *)dateArr
{
    if(_dateArr == nil)
    {
        _dateArr = [NSMutableArray array];
    }
    
    return _dateArr;
}

-(NSDictionary *)statusNameDict
{
    if(_statusNameDict == nil)
    {
        _statusNameDict = [NSDictionary dictionary];
    }
    return  _statusNameDict;
}

@end

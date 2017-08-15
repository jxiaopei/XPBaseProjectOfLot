//
//  BPMainPageViewController.m
//  baseProgram
//
//  Created by iMac on 2017/7/27.
//  Copyright © 2017年 eirc. All rights reserved.
//

#import "BPMainPageViewController.h"
#import "BPBannerViewCell.h"
#import "BPLotteriesTypeCollectionViewCell.h"
#import "BPBannerModel.h"
#import "BPLotteryKindModel.h"
#import "BPContestInfoModel.h"
#import "BPBaseWebViewController.h"
#import "BPLotteryViewController.h"
#import "BPLiveDataViewController.h"
#import "BPUnCoverWinnerViewController.h"

@interface BPMainPageViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UIScrollView *scrollview;
@property(nonatomic,strong)UICollectionView *bannerView;
@property(nonatomic,strong)UICollectionView *lotteryCollectionView;
@property(nonatomic,strong)NSMutableArray <BPBannerModel *>*bannerArr;
@property(nonatomic,strong)NSMutableArray <BPLotteryKindModel *>*lotteryArr;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,strong)UIPageControl *pageView;
@property(nonatomic,assign)NSInteger page;

@property(nonatomic,strong)UIView *liveView;
@property(nonatomic,strong)UIView *footView;

@property(nonatomic,strong)BPContestInfoModel *contestInfoModel;


//contestView上的控件
@property(nonatomic,strong)UIView *contestInfoView;
@property(nonatomic,strong)UILabel *homeLabel;
@property(nonatomic,strong)UIImageView *homeLogo;
@property(nonatomic,strong)UILabel *awayLabel;
@property(nonatomic,strong)UIImageView *awayLogo;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UILabel *contestLabel;

@end

@implementation BPMainPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"大厅";
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.bounces = NO;
    scrollView.backgroundColor = [UIColor whiteColor];
    _scrollview = scrollView;
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo(0);
    }];
    scrollView.contentSize = CGSizeMake(SCREENWIDTH, 667);
    [self setupBanner];
    [self setupContestInfoView];
    [self setupLotteryCollectionView];
    [self setupLiveView];
    [self setupFootView];
    [self getData];
    self.page = 0;
    [self setupTimer];
}

-(void)setupLiveView{
    
    UIView *liveView = [UIView new];
    _liveView = liveView;
    [self.scrollview addSubview:liveView];
    liveView.frame = CGRectMake(0, 493, SCREENWIDTH, 64);
    liveView.backgroundColor = [UIColor whiteColor];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = GlobalGrayColor;
    lineView.alpha = 0.6;
    [liveView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(1);
        make.height.mas_equalTo(0.5);
    }];
    
    UIView *verticalView = [UIView new];
    [liveView addSubview:verticalView];
    verticalView.backgroundColor = GlobalGrayColor;
    verticalView.alpha = 0.6;
    [verticalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(liveView);
        make.size.mas_equalTo(CGSizeMake(0.5, liveView.frame.size.height -2));
        make.top.mas_equalTo(lineView.mas_bottom);
    }];
    
    UIView *lineView1 = [UIView new];
    lineView1.backgroundColor = GlobalGrayColor;
    lineView1.alpha = 0.6;
    [liveView addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-1);
        make.height.mas_equalTo(0.5);
    }];
    
    UIImageView *recorderImageView = [UIImageView new];
    [liveView addSubview:recorderImageView];
    [recorderImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(20);
        make.size.mas_equalTo(CGSizeMake(50,50));
    }];
    recorderImageView.image = [UIImage imageNamed:@"摄影机"];
    
    UILabel *footBallLabel = [UILabel new];
    [liveView addSubview:footBallLabel];
    [footBallLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(liveView.mas_bottom).mas_offset(-5);
        make.left.mas_equalTo(recorderImageView.mas_right).mas_offset(10);
        make.right.mas_equalTo(verticalView.mas_left).mas_offset(-20);
    }];
    footBallLabel.textAlignment = NSTextAlignmentCenter;
    footBallLabel.text = @"足球直播";
    footBallLabel.font = [UIFont systemFontOfSize:11];
    footBallLabel.textColor = GlobalGrayColor;
    
    UIImageView *footBallImageView = [UIImageView new];
    [liveView addSubview:footBallImageView];
    [footBallImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(recorderImageView);
        make.centerX.mas_equalTo(footBallLabel);
        make.size.mas_equalTo(CGSizeMake(40,40));
    }];
    footBallImageView.image = [UIImage imageNamed:@"足球"];
    
    UIButton *footBallBtn = [UIButton new];
//    footBallBtn.backgroundColor = [UIColor redColor];
    [footBallBtn addTarget:self action:@selector(didClickFootBallBtn) forControlEvents:UIControlEventTouchUpInside];
    [liveView addSubview:footBallBtn];
    [footBallBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.left.mas_equalTo(5);
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH/2 - 10, 54));
    }];

    
    UIImageView *recorderImageView1 = [UIImageView new];
    [liveView addSubview:recorderImageView1];
    [recorderImageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(verticalView.mas_right).mas_offset(20);
        make.size.mas_equalTo(CGSizeMake(50,50));
    }];
    recorderImageView1.image = [UIImage imageNamed:@"摄影机"];

    UILabel *basketBallLabel = [UILabel new];
    [liveView addSubview:basketBallLabel];
    [basketBallLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(liveView.mas_bottom).mas_offset(-5);
        make.left.mas_equalTo(recorderImageView1.mas_right).mas_offset(10);
        make.right.mas_equalTo(-20);
    }];
    basketBallLabel.textAlignment = NSTextAlignmentCenter;
    basketBallLabel.text = @"篮球直播";
    basketBallLabel.font = [UIFont systemFontOfSize:11];
    basketBallLabel.textColor = GlobalGrayColor;
    
    UIImageView *basketBallImageView = [UIImageView new];
    [liveView addSubview:basketBallImageView];
    [basketBallImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(recorderImageView);
        make.centerX.mas_equalTo(basketBallLabel);
        make.size.mas_equalTo(CGSizeMake(40,40));
    }];
    basketBallImageView.image = [UIImage imageNamed:@"篮球"];
    
    UIButton *basketBallBtn = [UIButton new];
//    basketBallBtn.backgroundColor = [UIColor redColor];
    [basketBallBtn addTarget:self action:@selector(didClickBasketBallBtn) forControlEvents:UIControlEventTouchUpInside];
    [liveView addSubview:basketBallBtn];
    [basketBallBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.left.mas_equalTo(verticalView.mas_right).mas_offset(5);
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH/2 - 10, 54));
    }];
}

-(void)didClickBasketBallBtn{
    BPLiveDataViewController *liveDataVC = [BPLiveDataViewController new];
    liveDataVC.title = @"篮球直播";
    liveDataVC.contestType = BPBaskectballContestType;
    [self.navigationController pushViewController:liveDataVC animated:YES];
}

-(void)didClickFootBallBtn{
    BPLiveDataViewController *liveDataVC = [BPLiveDataViewController new];
    liveDataVC.title = @"足球直播";
    liveDataVC.contestType = BPFootballContestType;
    [self.navigationController pushViewController:liveDataVC animated:YES];
}

-(void)setupFootView{
    UIView *footView = [UIView new];
    _footView = footView;
    [self.scrollview addSubview:footView];
    footView.frame = CGRectMake(0, 557, SCREENWIDTH, 110);
    UIView *lineView = [UIView new];
    lineView.backgroundColor = GlobalLightGreyColor;
//    lineView.alpha = 0.6;
    [footView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.right.left.mas_equalTo(0);
        make.height.mas_equalTo(10);
    }];
    
    UIView *lineView2 = [UIView new];
    lineView2.backgroundColor = GlobalGrayColor;
    lineView2.alpha = 0.6;
    [footView addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(11);
        make.height.mas_equalTo(0.5);
    }];
    
    UIView *verticalView = [UIView new];
    [footView addSubview:verticalView];
    verticalView.backgroundColor = GlobalGrayColor;
    verticalView.alpha = 0.6;
    [verticalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCREENWIDTH/3);
        make.size.mas_equalTo(CGSizeMake(0.5, footView.frame.size.height -22));
        make.top.mas_equalTo(lineView2.mas_bottom);
    }];
    
    UIView *verticalView1 = [UIView new];
    [footView addSubview:verticalView1];
    verticalView1.backgroundColor = GlobalGrayColor;
    verticalView1.alpha = 0.6;
    [verticalView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCREENWIDTH/3 * 2);
        make.size.mas_equalTo(CGSizeMake(0.5, footView.frame.size.height -22));
        make.top.mas_equalTo(lineView2.mas_bottom);
    }];
    
    UIView *lineView1 = [UIView new];
    lineView1.backgroundColor = GlobalGrayColor;
    lineView1.alpha = 0.6;
    [footView addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-11);
        make.height.mas_equalTo(0.5);
    }];
    
    UIImageView *contestImageView = [UIImageView new];
    [footView addSubview:contestImageView];
    [contestImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCREENWIDTH/6 - 25);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
        make.bottom.mas_equalTo(-15);
    }];
    contestImageView.image = [UIImage imageNamed:@"球门"];
    
    UILabel *subTitle = [UILabel new];
    [footView addSubview:subTitle];
    [subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(contestImageView);
        make.bottom.mas_equalTo(contestImageView.mas_top).mas_offset(-5);
    }];
    subTitle.text = @"只推最稳的比赛";
    subTitle.font = [UIFont systemFontOfSize:10];
    subTitle.textColor = [UIColor redColor];
    
    UILabel *titleLabel = [UILabel new];
    [footView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(contestImageView);
        make.bottom.mas_equalTo(subTitle.mas_top).mas_equalTo(-2);
    }];
    titleLabel.text = @"每日竞彩";
    titleLabel.font = [UIFont systemFontOfSize:12];
    titleLabel.textColor = GlobalBlackColor;
    
    UIButton *contestBtn = [UIButton new];
    [footView addSubview:contestBtn];
//    contestBtn.backgroundColor = [UIColor redColor];
    [contestBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.top.mas_equalTo(16);
        make.height.mas_equalTo(79);
        make.width.mas_equalTo(SCREENWIDTH/3-10);
    }];
    [contestBtn addTarget:self action:@selector(didClickContestBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *contestImageView1 = [UIImageView new];
    [footView addSubview:contestImageView1];
    [contestImageView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(verticalView.mas_right).mas_offset(SCREENWIDTH/6 - 25);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
        make.bottom.mas_equalTo(-15);
    }];
    contestImageView1.image = [UIImage imageNamed:@"奖杯"];
    
    UILabel *subTitle1 = [UILabel new];
    [footView addSubview:subTitle1];
    [subTitle1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(contestImageView1);
        make.bottom.mas_equalTo(contestImageView1.mas_top).mas_offset(-5);
    }];
    subTitle1.text = @"最新赔率随时看";
    subTitle1.font = [UIFont systemFontOfSize:10];
    subTitle1.textColor = [UIColor redColor];
    
    UILabel *titleLabel1 = [UILabel new];
    [footView addSubview:titleLabel1];
    [titleLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(contestImageView1);
        make.bottom.mas_equalTo(subTitle1.mas_top).mas_equalTo(-2);
    }];
    titleLabel1.text = @"赔率信息";
    titleLabel1.font = [UIFont systemFontOfSize:12];
    titleLabel1.textColor = GlobalBlackColor;
    
    UIButton *uncoverWinnerBtn = [UIButton new];
    [footView addSubview:uncoverWinnerBtn];
//    uncoverWinnerBtn.backgroundColor = [UIColor redColor];
    [uncoverWinnerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(verticalView.mas_right).mas_offset(5);
        make.top.mas_equalTo(16);
        make.height.mas_equalTo(79);
        make.width.mas_equalTo(SCREENWIDTH/3-10);
    }];
    [uncoverWinnerBtn addTarget:self action:@selector(didClickUncoverWinnerBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *contestImageView2 = [UIImageView new];
    [footView addSubview:contestImageView2];
    [contestImageView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(verticalView1.mas_right).mas_offset(SCREENWIDTH/6 - 25);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(50);
        make.bottom.mas_equalTo(-15);
    }];
    contestImageView2.image = [UIImage imageNamed:@"礼品盒"];
    
    UILabel *subTitle2 = [UILabel new];
    [footView addSubview:subTitle2];
    [subTitle2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(contestImageView2);
        make.bottom.mas_equalTo(contestImageView2.mas_top).mas_offset(-5);
    }];
    subTitle2.text = @"小投入=大回报";
    subTitle2.font = [UIFont systemFontOfSize:10];
    subTitle2.textColor = [UIColor redColor];
    
    UILabel *titleLabel2 = [UILabel new];
    [footView addSubview:titleLabel2];
    [titleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(contestImageView2);
        make.bottom.mas_equalTo(subTitle2.mas_top).mas_equalTo(-2);
    }];
    titleLabel2.text = @"积分商城";
    titleLabel2.font = [UIFont systemFontOfSize:12];
    titleLabel2.textColor = GlobalBlackColor;
    
    UIButton *storeBtn = [UIButton new];
    [footView addSubview:storeBtn];
//    storeBtn.backgroundColor = [UIColor redColor];
    [storeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(verticalView1.mas_right).mas_offset(5);
        make.top.mas_equalTo(16);
        make.height.mas_equalTo(79);
        make.width.mas_equalTo(SCREENWIDTH/3-10);
    }];
    [storeBtn addTarget:self action:@selector(didClickStoreBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *lineView3 = [UIView new];
    lineView3.backgroundColor = GlobalLightGreyColor;
//    lineView3.alpha = 0.6;
    [footView addSubview:lineView3];
    [lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.right.left.mas_equalTo(0);
        make.height.mas_equalTo(10);
    }];
}

-(void)didClickContestBtn:(UIButton *)sender
{
    BPBaseWebViewController *webVC = [BPBaseWebViewController new];
    webVC.title = @"每日竞彩";
    webVC.urlString = @"http://m.zhuoyicp.com/topics?param=eyJzaWQiOiIzMTAwMjAwMTAwNiIsInNlaWQiOiItMTExMSIsInVzZXJJZCI6Ii0xMTExIiwiYXBwVmVyc2lvbiI6IjMuMi43IiwiZnJvbSI6ImlvcyJ9";
    [self.navigationController pushViewController:webVC animated:YES];
}

-(void)didClickUncoverWinnerBtn:(UIButton *)sender
{
    BPBaseWebViewController *webVC = [BPBaseWebViewController new];
    webVC.title = @"最新赔率";
    webVC.urlString = @"http://live.zhuoyicp.com/plzx/index?param=eyJzaWQiOiIzMTAwMjAwMTAwNiIsInNlaWQiOiI1Qjk1MzYxMUM1NzA0RUY2RkU4RkIzNjkzRkZCODQ4QSIsInVzZXJJZCI6IjI3NTU4OTkiLCJhcHBWZXJzaW9uIjoiMy4yLjciLCJmcm9tIjoiaW9zIn0=";
    [self.navigationController pushViewController:webVC animated:YES];
}

-(void)didClickStoreBtn:(UIButton *)sender
{
    BPBaseWebViewController *webVC = [BPBaseWebViewController new];
    webVC.title = @"积分娱乐城";
    webVC.urlString = @"http://www.zhuoyicp.com/appGame/index.html?param=eyJzaWQiOiIzMTAwMjAwMTAwNiIsInNlaWQiOiI1Qjk1MzYxMUM1NzA0RUY2RkU4RkIzNjkzRkZCODQ4QSIsInVzZXJJZCI6IjI3NTU4OTkiLCJhcHBWZXJzaW9uIjoiMy4yLjciLCJmcm9tIjoiaW9zIn0=";;
    [self.navigationController pushViewController:webVC animated:YES];
}

-(void)setupTimer
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    self.timer = timer;
    [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)nextImage
{
    if (_page == self.pageView.numberOfPages - 1) {
        _page = 0;
    }else{
        _page++;
    }
    _pageView.currentPage = _page;
    CGFloat offsetX = _page * SCREENWIDTH;
    
    [self.bannerView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if(scrollView == self.bannerView)
    {
        //停止定时器
        [self.timer invalidate];
        self.timer = nil;
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self setupTimer];
}

-(void)getData
{
    [[BPNetRequest getInstance] getListDataWithUrl:@"http://mapi.yjcp.com/center/homePageInfo" parameters:nil success:^(id responseObject) {
        if([responseObject[@"msg"] isEqualToString:@"查询成功！"])
        {
            self.bannerArr = [BPBannerModel mj_objectArrayWithKeyValuesArray:responseObject[@"lunboList"]];
            _pageView.numberOfPages = self.bannerArr.count;
            [self.bannerView reloadData];
        }
    
    } fail:^(NSError *error) {
        
    }];
    
    [[BPNetRequest getInstance]postDataWithUrl:@"http://api.cz.a8tiyu.com/v1/lottery_type_list" parameters:nil success:^(id responseObject) {
        
        NSArray *result = responseObject;
        
        if(result.count)
        {
            self.lotteryArr = [BPLotteryKindModel  mj_objectArrayWithKeyValuesArray:result];
            [self.lotteryCollectionView reloadData];
        }
        
    } fail:^(NSError *error) {
        
    }];
    
    [[BPNetRequest getInstance]postDataWithUrl:@"http://api.cz.a8tiyu.com/v1/hot_match_list" parameters:nil success:^(id responseObject) {
        
        NSArray *result = responseObject;
        
        if(result.count)
        {
            self.contestInfoModel = [BPContestInfoModel mj_objectWithKeyValues:result[0]];
            _contestInfoView.hidden = NO;
            _scrollview.contentSize = CGSizeMake(SCREENWIDTH, 667);
            _contestInfoView.frame = CGRectMake(0, 150, SCREENWIDTH, 50);
            _lotteryCollectionView.frame = CGRectMake(0, 200, SCREENWIDTH, 5 * 55 + 4 * 2 +10);
            _liveView.frame = CGRectMake(0, 493, SCREENWIDTH, 64);
            _footView.frame = CGRectMake(0, 557, SCREENWIDTH, 110);
            [self setDataToContestView];
        }else{
            _contestInfoView.hidden = YES;
            _scrollview.contentSize = CGSizeMake(SCREENWIDTH, 617);
            _contestInfoView.frame = CGRectMake(0, -50, SCREENWIDTH, 50);
            _lotteryCollectionView.frame = CGRectMake(0, 150, SCREENWIDTH, 5 * 55 + 4 * 2 +10);
            _liveView.frame = CGRectMake(0, 443, SCREENWIDTH, 64);
            _footView.frame = CGRectMake(0, 507, SCREENWIDTH, 110);
        }
        
    } fail:^(NSError *error) {
        
    }];
}

-(void)setupBanner{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(SCREENWIDTH, 150);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *bannerView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 150) collectionViewLayout:layout];
    [self.scrollview addSubview:bannerView];
    bannerView.tag = 100;
    bannerView.backgroundColor = [UIColor whiteColor];
    _bannerView = bannerView;
    bannerView.pagingEnabled = YES;
    bannerView.delegate = self;
    bannerView.dataSource = self;
    [bannerView registerClass:[BPBannerViewCell class] forCellWithReuseIdentifier:@"bannerViewCell"];
    UIPageControl *pageView = [UIPageControl new];
    [self.scrollview addSubview:pageView];
    pageView.frame = CGRectMake(0, 130, 0, 15);
    _pageView = pageView;
    pageView.numberOfPages = 3;
}

-(void)setupLotteryCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake((SCREENWIDTH)/2, 55);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 10;
    
    UICollectionView *lotteryView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 200, SCREENWIDTH, 5 * 55 + 4 * 2 +10) collectionViewLayout:layout];
    lotteryView.backgroundColor = GlobalLightGreyColor;
    self.lotteryCollectionView  = lotteryView;
    lotteryView.scrollEnabled = NO;
    [lotteryView setContentInset:UIEdgeInsetsMake(5,9, 5, 9)];
    [self.scrollview addSubview:lotteryView];
    lotteryView.tag = 200;
    lotteryView.delegate = self;
    lotteryView.dataSource = self;
    [lotteryView registerClass:[BPLotteriesTypeCollectionViewCell class] forCellWithReuseIdentifier:@"lotteryCell"];
//    [lotteryView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LotteryViewHeader"];
}

-(void)setupContestInfoView
{
    UIView *contestInfoView = [UIView new];
    _contestInfoView = contestInfoView;
    [self.scrollview addSubview:contestInfoView];
    _contestInfoView.frame = CGRectMake(0, 150, SCREENWIDTH, 50);
    _contestInfoView.backgroundColor = GlobalLightGreyColor;
    
    UIView *backView = [UIView new];
    [contestInfoView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(2);
        make.right.bottom.mas_equalTo(-2);
    }];
    backView.backgroundColor = [UIColor colorWithHexString:@"AED83A"];
    backView.layer.cornerRadius = 23;
    backView.layer.masksToBounds = YES;
    
    UIImageView *homeLogo = [UIImageView new];
    [contestInfoView addSubview:homeLogo];
    _homeLogo = homeLogo;
    [homeLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(contestInfoView);
        make.left.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    UILabel *homeLabel = [UILabel new];
    _homeLabel = homeLabel;
    [contestInfoView addSubview:homeLabel];
    [homeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(contestInfoView);
        make.left.mas_equalTo(homeLogo.mas_right).mas_offset(5);
    }];
    homeLabel.textColor = [UIColor whiteColor];
    homeLabel.font = [UIFont systemFontOfSize:13];
    homeLabel.textAlignment = NSTextAlignmentLeft;
    
    UIImageView *awayLogo = [UIImageView new];
    _awayLogo = awayLogo;
    [contestInfoView addSubview:awayLogo];
    [awayLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(contestInfoView);
        make.right.mas_equalTo(-10);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    UILabel *awayLabel = [UILabel new];
    _awayLabel = awayLabel;
    [contestInfoView addSubview:awayLabel];
    [awayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(contestInfoView);
        make.right.mas_equalTo(awayLogo.mas_left).mas_offset(-5);
    }];
    awayLabel.textColor = [UIColor whiteColor];
    awayLabel.font = [UIFont systemFontOfSize:13];
    awayLabel.textAlignment = NSTextAlignmentRight;
    
    UILabel *contestLabel = [UILabel new];
    _contestLabel = contestLabel;
    [contestInfoView addSubview:contestLabel];
    [contestLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(contestInfoView);
        make.top.mas_equalTo(5);
    }];
    contestLabel.textColor = [UIColor lightGrayColor];
    contestLabel.font = [UIFont systemFontOfSize:12];
    contestLabel.textAlignment = NSTextAlignmentCenter;
    
    UILabel *timeLabel = [UILabel new];
    _timeLabel = timeLabel;
    [contestInfoView addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(contestInfoView);
        make.top.mas_equalTo(contestLabel.mas_bottom).mas_offset(5);
    }];
    timeLabel.textColor = [UIColor lightGrayColor];
    timeLabel.font = [UIFont systemFontOfSize:14];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(collectionView.tag == 100){
        BPBannerModel *bannerModel = _bannerArr[indexPath.row];
        BPBaseWebViewController *webVC = [BPBaseWebViewController new];
        webVC.urlString = bannerModel.linkAddress;
        webVC.title = bannerModel.activityTitle;
        [self.navigationController pushViewController:webVC animated:YES];
        
    }else{
        BPLotteryKindModel *model = self.lotteryArr[indexPath.row];
        BPLotteryViewController *lotteryVC = [BPLotteryViewController new];
        lotteryVC.title = model.title;
        [self.navigationController pushViewController:lotteryVC animated:YES];
    }
}

-(void)setDataToContestView
{
    _homeLabel.text = _contestInfoModel.homeTeam;
    [_homeLogo sd_setImageWithURL:[NSURL URLWithString: _contestInfoModel.logo1] placeholderImage:[UIImage imageNamed:@"占位图"]];
    
    _awayLabel.text = _contestInfoModel.visitorTeam;
    [_awayLogo sd_setImageWithURL:[NSURL URLWithString: _contestInfoModel.logo2] placeholderImage:[UIImage imageNamed:@"占位图"]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [formatter dateFromString:_contestInfoModel.endDate];
    [formatter setDateFormat:@"MM月dd日"];
    NSString *dateStr = [formatter stringFromDate:date];
    [formatter setDateFormat:@"HH:mm"];
    NSString *hourStr = [formatter stringFromDate:date];
    _contestLabel.text = [NSString stringWithFormat:@"%@ %@",dateStr,_contestInfoModel.matchName];
    _timeLabel.text = hourStr;

}

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
//           viewForSupplementaryElementOfKind:(NSString *)kind
//                                 atIndexPath:(NSIndexPath *)indexPath {
//    UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"LotteryViewHeader"forIndexPath:indexPath];
//    headView.backgroundColor = [UIColor redColor];
//    return headView;
//}
//
//// 设置section头视图的参考大小，与tableheaderview类似
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout
//referenceSizeForHeaderInSection:(NSInteger)section {
//    
//    if (section == 0) {
//        return CGSizeMake(SCREENWIDTH, SCREENHEIGHT / 4);
//    }
//    else {
//        return CGSizeMake(0, 0);
//    }
//}

-(CGFloat )collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if(collectionView.tag == 100){
        return 0;
    }else{
        
        return 2;
    }
}

-(CGFloat )collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


- (CGSize)collectionView:(UICollectionView *)collectionView  layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if(collectionView.tag == 100){
        
       return CGSizeMake(SCREENWIDTH,150);
        
    }else{
        
      return CGSizeMake((SCREENWIDTH - 20) /2,55);
        
    }
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(collectionView.tag == 100){
        
        return self.bannerArr.count;
        
    }else{
        
        return self.lotteryArr.count <= 10 ? self.lotteryArr.count : 10;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(collectionView.tag == 100){
        
        BPBannerModel *bannerModel = _bannerArr[indexPath.row];
        BPBannerViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"bannerViewCell" forIndexPath:indexPath];
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:bannerModel.mapAddress] placeholderImage:[UIImage imageNamed:@"占位图"]];
//        cell.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1.0];
        
        return cell;
        
    }else{
        BPLotteriesTypeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"lotteryCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        BPLotteryKindModel *model = self.lotteryArr[indexPath.row];
        if(self.lotteryArr.count >10 && indexPath.row == 9)
        {
            cell.iconView.image= [UIImage imageNamed:@"更多"];
            cell.titleLabel.hidden = YES;
            cell.subTiTleLabel.hidden = YES;
            cell.moreLabel.hidden = NO;
            
        }else{
            [cell.iconView sd_setImageWithURL:[NSURL URLWithString:model.icon] placeholderImage:[UIImage imageNamed:@"占位图"]];
            cell.titleLabel.text = model.title;
            cell.subTiTleLabel.text = model.subTitle;
            cell.moreLabel.hidden = YES;
            cell.titleLabel.hidden = NO;
            cell.subTiTleLabel.hidden = NO;
        }
        
        return cell;
    }
}

-(void)dealloc
{
    [self.timer invalidate];
    self.timer = nil;
}

-(NSMutableArray <BPBannerModel *>*)bannerArr
{
    if(_bannerArr == nil)
    {
        _bannerArr = [NSMutableArray array];
    }
    return _bannerArr;
}

-(NSMutableArray <BPLotteryKindModel *> *)lotteryArr
{
    if(_lotteryArr == nil)
    {
        _lotteryArr = [NSMutableArray array];
    }
    return _lotteryArr;
}

@end

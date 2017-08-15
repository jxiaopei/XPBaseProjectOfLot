//
//  BPLiveCollectionViewCell.m
//  baseProgram
//
//  Created by iMac on 2017/7/29.
//  Copyright © 2017年 eirc. All rights reserved.
//

#import "BPLiveCollectionViewCell.h"
#import "BPLiveDataModel.h"
#import "BPLiveDataCell.h"
#import "BPBaskectBallLiveCell.h"


@interface BPLiveCollectionViewCell ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation BPLiveCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.tableView = [UITableView new];
        [self addSubview:self.tableView];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.backgroundColor = [UIColor whiteColor];//[UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1.0];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.right.mas_equalTo(0);
        }];
        
        [self.tableView registerClass:[BPLiveDataCell class] forCellReuseIdentifier:@"liveDataCell"];
        [self.tableView registerClass:[BPBaskectBallLiveCell class] forCellReuseIdentifier:@"baskectBallLiveCell"];
        self.tableView.tableFooterView = [UIView new];
        
    }
    return self;
}

-(void)setStatusNameDict:(NSDictionary *)statusNameDict
{
    _statusNameDict = statusNameDict;
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BPLiveDataModel *dataModel = self.dataSource[indexPath.row];
    if(self.contestType == 0)
    {
        return 80;
    }else{
        return dataModel.rowHeight;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_jumpToWebVCBlock)
    {
        _jumpToWebVCBlock(indexPath.row);
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BPLiveDataModel *dataModel = self.dataSource[indexPath.row];
    if(self.contestType == 0)
    {
        BPLiveDataCell *cell = [tableView dequeueReusableCellWithIdentifier:@"liveDataCell" forIndexPath:indexPath];
        NSString *key = [NSString stringWithFormat:@"%zd",dataModel.ss];
        cell.statusName = self.statusNameDict[key];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.dataModel = dataModel;
        return cell;
    }else{
        
        BPBaskectBallLiveCell *cell = [tableView dequeueReusableCellWithIdentifier:@"baskectBallLiveCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.dataModel = dataModel;
        return cell;
    }

}

-(NSMutableArray <BPLiveDataModel *>*)dataSource
{
    if(_dataSource == nil)
    {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}


@end

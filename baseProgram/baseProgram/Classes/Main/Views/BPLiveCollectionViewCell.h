//
//  BPLiveCollectionViewCell.h
//  baseProgram
//
//  Created by iMac on 2017/7/29.
//  Copyright © 2017年 eirc. All rights reserved.
//


#import "BPLiveDataViewController.h"
#import <UIKit/UIKit.h>
@class BPLiveDataModel;

@interface BPLiveCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong)NSMutableArray <BPLiveDataModel *>*dataSource;
@property(nonatomic,strong)NSDictionary *statusNameDict;
@property(nonatomic,assign)BPContestType contestType;
@property(nonatomic,copy) void(^jumpToWebVCBlock)(NSInteger index);

@end

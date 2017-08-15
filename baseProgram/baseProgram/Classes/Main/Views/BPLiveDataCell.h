//
//  BPLiveDataCell.h
//  baseProgram
//
//  Created by iMac on 2017/7/29.
//  Copyright © 2017年 eirc. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BPLiveDataModel;

@interface BPLiveDataCell : UITableViewCell


@property(nonatomic,strong)BPLiveDataModel *dataModel;
@property(nonatomic,copy)NSString *statusName;

@end

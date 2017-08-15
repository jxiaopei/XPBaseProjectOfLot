//
//  LiveDataViewController.h
//  baseProgram
//
//  Created by iMac on 2017/7/29.
//  Copyright © 2017年 eirc. All rights reserved.
//

typedef NS_ENUM(NSInteger, BPContestType){
    
    BPFootballContestType = 0,
    BPBaskectballContestType,
};

#import "BPBaseViewController.h"

@interface BPLiveDataViewController : BPBaseViewController

@property (nonatomic,assign)BPContestType contestType;

@end

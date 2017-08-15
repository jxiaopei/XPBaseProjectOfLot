//
//  BPLiveDataModel.h
//  baseProgram
//
//  Created by iMac on 2017/7/29.
//  Copyright © 2017年 eirc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BPLiveDataModel : NSObject

//足球
@property (nonatomic, strong) NSString * awary;
@property (nonatomic, assign) NSInteger awayHome;
@property (nonatomic, strong) NSString * bc;
@property (nonatomic, strong) NSString * dt;
@property (nonatomic, strong) NSString * guestLogo;
@property (nonatomic, strong) NSString * guestOrder;
@property (nonatomic, strong) NSString * home;
@property (nonatomic, strong) NSString * homeLogo;
@property (nonatomic, assign) NSInteger homeNum;
@property (nonatomic, strong) NSString * homeOrder;
@property (nonatomic, strong) NSString * hr;
@property (nonatomic, strong) NSString * hy;
@property (nonatomic, strong) NSString * issue;
@property (nonatomic, strong) NSString * leagueColor;
@property (nonatomic, strong) NSString * leidaMatchid;
@property (nonatomic, assign) NSInteger let;
@property (nonatomic, strong) NSObject * liveVideo;
@property (nonatomic, assign) NSInteger matchId;
@property (nonatomic, strong) NSString * mid;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, assign) NSInteger num;
@property (nonatomic, strong) NSString * oc;
@property (nonatomic, strong) NSString * pc;
@property (nonatomic, strong) NSString * sc;
@property (nonatomic, assign) NSInteger ss;
@property (nonatomic, strong) NSString * tem;
@property (nonatomic, assign) NSInteger tstime;
@property (nonatomic, strong) NSObject * turnNum;
@property (nonatomic, strong) NSString * weather;
@property (nonatomic, assign) NSInteger isFocus;

//篮球
@property (nonatomic, assign) NSInteger awayFirst;
@property (nonatomic, assign) NSInteger awayFirstot;
@property (nonatomic, assign) NSInteger awayFourth;
@property (nonatomic, strong) NSString * awayLogo;
@property (nonatomic, strong) NSString * awayOdds;
@property (nonatomic, assign) NSInteger awayOrder;
@property (nonatomic, assign) NSInteger awayPoints;
@property (nonatomic, assign) NSInteger awaySecond;
@property (nonatomic, assign) NSInteger awaySecondot;
@property (nonatomic, strong) NSString * awayShort;
@property (nonatomic, assign) NSInteger awayThird;
@property (nonatomic, assign) NSInteger awayThirdot;
@property (nonatomic, strong) NSString * dxfLet;
@property (nonatomic, strong) NSString * dxfSp0;
@property (nonatomic, strong) NSString * dxfSp3;
@property (nonatomic, assign) NSInteger homeFirst;
@property (nonatomic, assign) NSInteger homeFirstot;
@property (nonatomic, assign) NSInteger homeFourth;
@property (nonatomic, strong) NSString * homeOdds;
@property (nonatomic, assign) NSInteger homePoints;
@property (nonatomic, assign) NSInteger homeSecond;
@property (nonatomic, assign) NSInteger homeSecondot;
@property (nonatomic, strong) NSString * homeShort;
@property (nonatomic, assign) NSInteger homeThird;
@property (nonatomic, assign) NSInteger homeThirdot;
@property (nonatomic, assign) NSInteger isSwapped;
@property (nonatomic, strong) NSString * jieshu;
@property (nonatomic, strong) NSString * live;
@property (nonatomic, assign) NSInteger matchStatus;
@property (nonatomic, strong) NSString * overtimes;
@property (nonatomic, strong) NSString * remainTime;
@property (nonatomic, strong) NSString * rqLet;
@property (nonatomic, strong) NSString * rqsfSp0;
@property (nonatomic, strong) NSString * rqsfSp3;

//动态行高
@property (nonatomic, assign) CGFloat rowHeight;
@property (nonatomic, assign)BOOL isShowMore;

@end


//
//  BPLiveDataModel.m
//  baseProgram
//
//  Created by iMac on 2017/7/29.
//  Copyright © 2017年 eirc. All rights reserved.
//

#import "BPLiveDataModel.h"

@implementation BPLiveDataModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{
             @"leagueColor" : @"league_color",
             @"leidaMatchid": @"leida_matchid",
             @"turnNum"     : @"turn_num",
             @"liveVideo"   : @"live_video",
             @"homeOrder"   : @"home_order",
             @"guestOrder"  : @"guest_order",
             @"homeNum"     : @"home_num",
             @"matchId"     : @"match_id",
             @"guestLogo"   : @"guest_logo",
             @"homeLogo"    : @"home_logo",
             @"isFocus"     : @"is_focus",
             @"rqLet"       : @"rq_let",
             @"dxfLet"      : @"dxf_let",
             @"rqsfSp3"     : @"rqsf_sp3",
             @"rqsfSp0"     : @"rqsf_sp0",
             @"dxfSp3"      : @"dxf_sp3",
             @"dxfSp0"      : @"dxf_sp0",
             @"isSwapped"   : @"is_swapped",
             @"homeShort"   : @"home_short",
             @"awayShort"   : @"away_short",
             @"matchId"     : @"match_id",
             @"matchStatus" : @"match_status",
             @"remainTime"  : @"remain_time",
             @"homePoints"  : @"home_points",
             @"awayPoints"  : @"away_points",
             @"homeFirst"   : @"home_first",
             @"awayFirst"   : @"away_first",
             @"homeSecond"  : @"home_second",
             @"awaySecond"  : @"away_second",
             @"homeThird"   : @"home_third",
             @"awayThird"   : @"away_third",
             @"homeFourth"  : @"home_fourth",
             @"awayFourth"  : @"away_fourth",
             @"homeOdds"    : @"home_odds",
             @"awayOdds"    : @"away_odds",
             @"homeFirstot" : @"home_firstot",
             @"awayFirstot" : @"away_firstot",
             @"homeSecondot": @"home_secondot",
             @"awaySecondot": @"away_secondot",
             @"homeThirdot" : @"home_thirdot",
             @"awayThirdot" : @"away_thirdot",
             };
}


-(CGFloat)rowHeight
{
    if(_isShowMore)
    {
        return 90 + 70 *20;
        
    }else{
        return 90;
    }
}

@end

//
//  BPBaskectBallLiveCell.m
//  baseProgram
//
//  Created by iMac on 2017/8/1.
//  Copyright © 2017年 eirc. All rights reserved.
//

#import "BPBaskectBallLiveCell.h"

@interface BPBaskectBallLiveCell ()

@property(nonatomic,strong)UILabel *homeLabel;
@property(nonatomic,strong)UIImageView *homeLogo;
@property(nonatomic,strong)UILabel *awayLabel;
@property(nonatomic,strong)UIImageView *awayLogo;
@property(nonatomic,strong)UILabel *dateLabel;
@property(nonatomic,strong)UILabel *titleLabel;
//@property(nonatomic,strong)UILabel *halfYieldLabel;
//@property(nonatomic,strong)UILabel *yieldLabel;
@property(nonatomic,strong)UIButton *attentionBtn;
@property(nonatomic,strong)UILabel *allScoreLabel;
//@property(nonatomic,strong)UILabel *halfScoreLabel;

@end

@implementation BPBaskectBallLiveCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    
        UILabel *titleLabel = [UILabel new];
        [self addSubview:titleLabel];
        _titleLabel = titleLabel;
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(5);
            make.left.mas_equalTo(10);
        }];
        titleLabel.font = [UIFont systemFontOfSize:10];
        titleLabel.textColor = [UIColor grayColor];
        
        
        UIImageView *homeLogo = [UIImageView new];
        [self addSubview:homeLogo];
        _homeLogo = homeLogo;
        [homeLogo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.left.mas_equalTo(titleLabel);
            make.top.mas_equalTo(titleLabel.mas_bottom).mas_offset(5);
        }];
        
        UILabel *homeLabel = [UILabel new];
        [self addSubview:homeLabel];
        _homeLabel = homeLabel;
        [homeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(homeLogo);
            make.left.mas_equalTo(homeLogo.mas_right).offset(5);
        }];
        homeLabel.font = [UIFont systemFontOfSize:14];
        homeLabel.textColor = [UIColor blackColor];
        
        UIImageView *awayLogo = [UIImageView new];
        [self addSubview:awayLogo];
        _awayLogo = awayLogo;
        [awayLogo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.left.mas_equalTo(titleLabel);
            make.top.mas_equalTo(homeLogo.mas_bottom).mas_offset(5);
        }];
        
        UILabel *awayLabel = [UILabel new];
        [self addSubview:awayLabel];
        _awayLabel = awayLabel;
        [awayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(awayLogo);
            make.left.mas_equalTo(awayLogo.mas_right).mas_offset(5);
        }];
        awayLabel.font = [UIFont systemFontOfSize:14];
        awayLabel.textColor = [UIColor blackColor];
        
        UIButton *attentionBtn = [UIButton new];
        [self addSubview:attentionBtn];
        _attentionBtn = attentionBtn;
        [attentionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-5);
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.top.mas_equalTo(titleLabel);
        }];
        [attentionBtn setImage:[UIImage imageNamed:@"未关注"] forState:UIControlStateNormal];
        [attentionBtn setImage:[UIImage imageNamed:@"关注"]  forState:UIControlStateSelected];
        
        UILabel *dateLabel = [UILabel new];
        [self addSubview:dateLabel];
        _dateLabel = dateLabel;
        [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.bottom.mas_equalTo(-25);
        }];
        dateLabel.font = [UIFont systemFontOfSize:12];
        dateLabel.textColor = [UIColor grayColor];
        
        UILabel *allScoreLabel = [UILabel new];
        [self addSubview:allScoreLabel];
        _allScoreLabel = allScoreLabel;
        [allScoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.centerX.mas_equalTo(0);
        }];
        allScoreLabel.font = [UIFont systemFontOfSize:13];
        allScoreLabel.textColor = [UIColor grayColor];
        allScoreLabel.textAlignment = NSTextAlignmentCenter;
        
        UIView *lineView = [UIView new];
        [self addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(dateLabel.mas_bottom).mas_offset(5);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(20);
        }];
        
    }
    return self;
}

-(void)setDataModel:(BPLiveDataModel *)dataModel
{
    _dataModel = dataModel;
    
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [formatter dateFromString:dataModel.issue];
    
    NSArray *weekDayStrArr = @[@"星期天",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];
    NSCalendar*calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone*timeZone = [[NSTimeZone alloc]initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit =NSCalendarUnitWeekday;
    
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:date];
    
    NSString *weekdayStr = [weekDayStrArr objectAtIndex:theComponents.weekday - 1];
    _titleLabel.text = [NSString stringWithFormat:@"%@%@ %@",weekdayStr,[dataModel.mid substringFromIndex:8],dataModel.name];
    [_homeLogo sd_setImageWithURL:[NSURL URLWithString:dataModel.homeLogo] placeholderImage:[UIImage imageNamed: @"篮球"]];
    _homeLabel.text = dataModel.homeShort;
    [_awayLogo sd_setImageWithURL:[NSURL URLWithString:dataModel.guestLogo] placeholderImage:[UIImage imageNamed: @"篮球"]];
    _awayLabel.text = dataModel.awayShort;
    
    _dateLabel.text = dataModel.matchStatus  ? @"已结束" : dataModel.dt;
    _allScoreLabel.text = dataModel.matchStatus ? [NSString stringWithFormat:@"%zd : %zd",dataModel.awayPoints , dataModel.homePoints] : @"未开赛";
    
    if(dataModel.isFocus)
    {
        _attentionBtn.selected = YES;
    }
    
    
}

@end

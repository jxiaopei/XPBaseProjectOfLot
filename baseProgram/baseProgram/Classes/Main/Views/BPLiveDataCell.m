//
//  BPLiveDataCell.m
//  baseProgram
//
//  Created by iMac on 2017/7/29.
//  Copyright © 2017年 eirc. All rights reserved.
//

#import "BPLiveDataCell.h"
#import "BPLiveDataModel.h"

@interface BPLiveDataCell()

@property(nonatomic,strong)UILabel *homeLabel;
@property(nonatomic,strong)UIImageView *homeLogo;
@property(nonatomic,strong)UILabel *awayLabel;
@property(nonatomic,strong)UIImageView *awayLogo;
@property(nonatomic,strong)UILabel *dateLabel;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *halfYieldLabel;
@property(nonatomic,strong)UILabel *yieldLabel;
@property(nonatomic,strong)UIButton *attentionBtn;
@property(nonatomic,strong)UILabel *allScoreLabel;
@property(nonatomic,strong)UILabel *halfScoreLabel;

@end

@implementation BPLiveDataCell

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
        
        UILabel *yieldLabel = [UILabel new];
        [self addSubview:yieldLabel];
        _yieldLabel = yieldLabel;
        [yieldLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(attentionBtn);
            make.top.mas_equalTo(attentionBtn.mas_bottom).mas_offset(5);
        }];
        yieldLabel.font = [UIFont systemFontOfSize:12];
        yieldLabel.textColor = [UIColor grayColor];
        
        UILabel *halfYieldLabel = [UILabel new];
        _halfYieldLabel = halfYieldLabel;
        [self addSubview:halfYieldLabel];
        [halfYieldLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(attentionBtn);
            make.top.mas_equalTo(yieldLabel.mas_bottom).mas_offset(5);
        }];
        halfYieldLabel.font = [UIFont systemFontOfSize:12];
        halfYieldLabel.textColor = [UIColor grayColor];
        
        
        UILabel *dateLabel = [UILabel new];
        [self addSubview:dateLabel];
        _dateLabel = dateLabel;
        [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(yieldLabel.mas_left).mas_offset(-20);
            make.centerY.mas_equalTo(0);
            make.width.mas_equalTo(70);
        }];
        dateLabel.numberOfLines = 2;
        dateLabel.font = [UIFont systemFontOfSize:12];
        dateLabel.textColor = [UIColor blackColor];
        dateLabel.textAlignment = NSTextAlignmentCenter;
        
        UILabel *allScoreLabel = [UILabel new];
        [self addSubview:allScoreLabel];
        _allScoreLabel = allScoreLabel;
        [allScoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.mas_equalTo(dateLabel);
        }];
        allScoreLabel.font = [UIFont systemFontOfSize:18];
        allScoreLabel.textColor = [UIColor grayColor];
        allScoreLabel.textAlignment = NSTextAlignmentCenter;
        
        UILabel *halfScoreLabel = [UILabel new];
        [self addSubview:halfScoreLabel];
        _halfScoreLabel = halfScoreLabel;
        [halfScoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(allScoreLabel.mas_bottom).mas_offset(2);
            make.centerX.mas_equalTo(dateLabel);
        }];
        halfScoreLabel.font = [UIFont systemFontOfSize:12];
        halfScoreLabel.textColor = [UIColor grayColor];
        halfScoreLabel.textAlignment = NSTextAlignmentCenter;
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
    
    // 得到星期几
    // 1(星期天) 2(星期二) 3(星期三) 4(星期四) 5(星期五) 6(星期六) 7(星期天)

    
    _titleLabel.text = [NSString stringWithFormat:@"%@%@ %@",weekdayStr,[dataModel.mid substringFromIndex:8],dataModel.name];
    [_homeLogo sd_setImageWithURL:[NSURL URLWithString:dataModel.homeLogo] placeholderImage:[UIImage imageNamed: @"足球"]];
    _homeLabel.text = dataModel.home;
    [_awayLogo sd_setImageWithURL:[NSURL URLWithString:dataModel.guestLogo] placeholderImage:[UIImage imageNamed: @"足球"]];
    _awayLabel.text = dataModel.awary;
    _yieldLabel.text = [NSString stringWithFormat:@"让分 : %zd",dataModel.let];
//    _halfYieldLabel.text = [NSString stringWithFormat:@"%lf",dataModel.zf];

    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date1 = [formatter dateFromString:dataModel.dt];
    [formatter setDateFormat:@"HH:mm"];
    NSString *dateString = [formatter stringFromDate:date1];
    
    if([self.statusName isEqualToString:@"完场"])
    {
        _dateLabel.hidden = YES;
        _allScoreLabel.hidden = NO;
        _halfScoreLabel.hidden = NO;
        _allScoreLabel.text = dataModel.sc;
        _halfScoreLabel.text = dataModel.bc;
        
    }else{
        _dateLabel.hidden = NO;
        _allScoreLabel.hidden = YES;
        _halfScoreLabel.hidden = YES;
        _dateLabel.text = [NSString stringWithFormat:@"%@ %@",self.statusName, dateString];
    }
    
    if(dataModel.isFocus)
    {
        _attentionBtn.selected = YES;
    }
    
}


@end

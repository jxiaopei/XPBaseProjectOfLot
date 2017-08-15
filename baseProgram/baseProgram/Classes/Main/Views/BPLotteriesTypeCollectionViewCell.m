//
//  BPLotteriesTypeCollectionViewCell.m
//  baseProgram
//
//  Created by iMac on 2017/7/27.
//  Copyright © 2017年 eirc. All rights reserved.
//

#import "BPLotteriesTypeCollectionViewCell.h"

@implementation BPLotteriesTypeCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.iconView = [UIImageView new];
        [self addSubview:self.iconView];
        self.iconView.frame = CGRectMake(10, 5, 45, 45);
        
        self.titleLabel = [UILabel new];
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.iconView.mas_right).mas_offset(5);
            make.top.mas_equalTo(5);
        }];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        self.subTiTleLabel = [UILabel new];
        [self addSubview:self.subTiTleLabel];
        [self.subTiTleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleLabel);
            make.right.mas_equalTo(-5);
            make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(10);
        }];
        self.subTiTleLabel.font = [UIFont systemFontOfSize:12];
        self.subTiTleLabel.textColor = [UIColor lightGrayColor];
        self.subTiTleLabel.textAlignment = NSTextAlignmentCenter;
        
        self.moreLabel = [UILabel new];
        [self addSubview:self.moreLabel];
        [self.moreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self);
            make.left.mas_equalTo(self.iconView.mas_right).mas_offset(5);
        }];
        self.moreLabel.text = @"更多";
        self.moreLabel.font = [UIFont systemFontOfSize:16];
        self.moreLabel.textColor = [UIColor blackColor];
        self.moreLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return self;
    
}

@end

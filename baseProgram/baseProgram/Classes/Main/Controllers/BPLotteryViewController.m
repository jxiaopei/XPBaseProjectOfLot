//
//  BPLotteryViewController.m
//  baseProgram
//
//  Created by iMac on 2017/7/29.
//  Copyright © 2017年 eirc. All rights reserved.
//

#import "BPLotteryViewController.h"

@interface BPLotteryViewController ()

@end

@implementation BPLotteryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
 
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [MBProgressHUD showMessage:@"加载中" toView:self.view ];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [MBProgressHUD showError:@"您非正常会员,无法使用这个功能"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.navigationController popViewControllerAnimated:YES];
        });
       
    });
    
}

@end

//
//  BPUnCoverWinnerViewController.m
//  baseProgram
//
//  Created by iMac on 2017/7/31.
//  Copyright © 2017年 eirc. All rights reserved.
//

#import "BPUnCoverWinnerViewController.h"

@interface BPUnCoverWinnerViewController ()

@end

@implementation BPUnCoverWinnerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
}

-(void)getData
{
    [[BPNetRequest getInstance]postListDataWithUrl:@"http://client.win310.com:8080/api/award/list" parameters:nil success:^(id responseObject) {
        
        NSLog(@"%@",[responseObject mj_JSONString]);
        
    } fail:^(NSError *error) {
        NSLog(@"%@",error.description);
    }];
}



@end

//
//  BPBaseWebViewController.m
//  baseProgram
//
//  Created by iMac on 2017/7/29.
//  Copyright © 2017年 eirc. All rights reserved.
//

#import "BPBaseWebViewController.h"
#import "BPLotteryViewController.h"

@interface BPBaseWebViewController ()<UIWebViewDelegate>

@property(nonatomic,strong)UIWebView *webView;

@end

@implementation BPBaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupWebView];
}

-(void)setupWebView
{
    self.webView = [UIWebView new];
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.left.mas_equalTo(0);
    }];
    self.webView.delegate = self;
    self.webView.scrollView.bounces = NO;
    self.webView.scalesPageToFit = YES;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_urlString]];
    [self.webView loadRequest:request];
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *URL = request.URL;
    NSString *scheme = [URL scheme];
    if ([scheme isEqualToString:@"yjcp"]) {
        NSLog(@"tiao");
        BPLotteryViewController *lotteryVC = [BPLotteryViewController new];
        lotteryVC.title = @"积分竞技场";
        [self.navigationController pushViewController:lotteryVC animated:YES];
        return NO;
    }
    return YES;
}


-(void)webViewDidStartLoad:(UIWebView *)webView{
    [MBProgressHUD showMessage:@"正在加载中..." toView:self.view];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUDForView:self.view];
    
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUDForView:self.view];
}


@end

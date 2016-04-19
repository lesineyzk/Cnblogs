//
//  BlogBodyViewController.m
//  Cnblogs
//
//  Created by lesiney on 16/4/9.
//  Copyright © 2016年 LongHairPig. All rights reserved.
//

#import "BlogBodyViewController.h"
#import "View+MASAdditions.h"



@interface BlogBodyViewController ()<UIWebViewDelegate>

@property (nonatomic,strong) UIWebView *webView;

@end

@implementation BlogBodyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutSubviews];
    [self requestBlogBodyString];

    self.title = self.blogTitle;
    
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
//    [self.navigationItem setBackBarButtonItem:backItem];
}

- (void)layoutSubviews {
    self.webView = [[UIWebView alloc] init];
    self.webView.scalesPageToFit = YES;
    self.webView.dataDetectorTypes = UIDataDetectorTypeAll;
    [self.view addSubview:self.webView];
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)requestBlogBodyString {
    
    if (self.contentType == WebViewDisplayTypeBlog) {
        [[BlogAdapter new] getBlogBodyString:self.blogId andBlock:^(NSString *bodyString) {
            [self.webView loadHTMLString:bodyString baseURL:nil];
        }];
    } else {
        [[NewsAdapter new] getNewsBodyString:self.blogId andBlock:^(NSString *bodyString) {
            [self.webView loadHTMLString:bodyString baseURL:nil];
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

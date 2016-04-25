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
    
    
//    self.navigationController.navigationItem.title = @"返回";
//    self.navigationController.title = @"返回";
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
//    self.navigationItem.leftBarButtonItem.title = @"返回";
//    [self.navigationItem setBackBarButtonItem:backItem];
//    self.navigationItem.backBarButtonItem
}

- (void)layoutSubviews {
    self.webView = [[UIWebView alloc] init];
    self.webView.scalesPageToFit = YES;
    self.webView.delegate = self;
    self.webView.dataDetectorTypes = UIDataDetectorTypeAll;
    [self.view addSubview:self.webView];
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)requestBlogBodyString {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    if (self.contentType == WebViewDisplayTypeBlog) {
        [[BlogAdapter new] getBlogBodyString:self.blogId andBlock:^(NSString *bodyString) {
            [self.webView loadHTMLString:[self handleHtmlString:bodyString] baseURL:nil];
        }];
    } else {
        [[NewsAdapter new] getNewsBodyString:self.blogId andBlock:^(NSString *bodyString) {
            [self.webView loadHTMLString:[self handleHtmlString:bodyString] baseURL:nil];
        }];
    }
}

- (NSString *)handleHtmlString : (NSString *)bodyString {
    
    NSString *jsString = [NSString stringWithFormat:@"<html> \n"
                          "<head> \n"
                          "<style type=\"text/css\"> \n"
                          "body {font-size: %f; font-family: \"%@\"; color: %@;}\n"
                          "</style> \n"
                          "</head> \n"
                          "<body>%@</body> \n"
                          "</html>", 20.0, @"", @"", bodyString];
    
    return jsString;
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // finished loading, hide the activity indicator in the status bar
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= ’200%’"];
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

//
//  NewsViewController.m
//  Cnblogs
//
//  Created by lesiney on 16/4/11.
//  Copyright © 2016年 LongHairPig. All rights reserved.
//

#import "NewsTableViewController.h"
#import "BlogsContentTableViewCell.h"
#import "NewsInfo.h"
#import "NewsAdapter.h"
#import "BlogBodyViewController.h"

static NSString *blogContentCell= @"BlogsContentTableViewCell";
static NSString *blogContentCellIdentifier= @"BlogsContentTableViewCellIdentifier";

@interface NewsTableViewController ()

@property (strong,nonatomic) NewsAdapter *newsAdapter;

@property (strong,nonatomic) NSMutableArray *currentNewsInfos;

@end

@implementation NewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.newsAdapter = [NewsAdapter new];
    
    __weak typeof(self) weakSelf = self;
    
    [self.newsAdapter getNewInfosByPageIndex:@"1" andPageSize:@"10" andBlock:^(NSMutableArray *blogInfos) {
        weakSelf.currentNewsInfos = blogInfos;
        [weakSelf.tableView reloadData];
    }];
    
    
    UINib *blogContentNib = [UINib nibWithNibName:blogContentCell bundle:nil];
    [self.tableView registerNib:blogContentNib forCellReuseIdentifier:blogContentCellIdentifier];
    
    self.title = self.tabBarController.tabBar.items[1].title;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  self.currentNewsInfos.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.currentNewsInfos) {
        return nil;
    }
    
    NewsInfo *newsInfo = ((NewsInfo *)(self.currentNewsInfos[indexPath.row]));
    
    BlogsContentTableViewCell *contentCell=[tableView dequeueReusableCellWithIdentifier:blogContentCellIdentifier forIndexPath:indexPath];
    [contentCell setInfoViewData:(id)newsInfo];
    return contentCell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NewsInfo *newsInfo = ((NewsInfo *)(self.currentNewsInfos[indexPath.row]));
    
    BlogBodyViewController *blogBodyViewController = [BlogBodyViewController new];
    blogBodyViewController.blogId = newsInfo.blogId;
    blogBodyViewController.contentType = WebViewDisplayTypeNews;
    
    blogBodyViewController.blogTitle = newsInfo.blogTitle;
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    
    blogBodyViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:blogBodyViewController animated:YES];
    
}

#pragma mark 设置每行高度（每行高度可以不一样）
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180;
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

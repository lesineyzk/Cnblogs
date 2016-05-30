//
//  NewsViewController.m
//  Cnblogs
//
//  Created by lesiney on 16/4/11.
//  Copyright © 2016年 LongHairPig. All rights reserved.
//

#import "BlogTableViewController.h"
#import "BlogsContentTableViewCell.h"
#import "NewsInfo.h"
#import "NewsAdapter.h"
#import "BlogBodyViewController.h"
#import "HomePageAdapter.h"
#import "GlobalData.h"
#import "Enum.h"

static NSString *blogContentCell= @"BlogsContentTableViewCell";
static NSString *blogContentCellIdentifier= @"BlogsContentTableViewCellIdentifier";

@interface BlogTableViewController ()

//@property (strong,nonatomic) NewsAdapter *newsAdapter;
@property (strong,nonatomic) HomePageAdapter *homePageAdapter;

@property (strong,nonatomic) NSMutableArray *currentNewsInfos;

@property (assign,nonatomic) HomePageDisplayContent currentHomePageDisplayContent;

@end

@implementation BlogTableViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if(self = [super initWithCoder:aDecoder]){
        self.currentHomePageDisplayContent = HomePageDisplayContentNews;
    }
    
    return self;
}

- (instancetype)initWithHomePageType :(HomePageDisplayContent)homePageDisplayContent
{
    if(self = [super init]){
        
        self.currentHomePageDisplayContent = homePageDisplayContent;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    self.newsAdapter = [NewsAdapter new];
    //    [self.newsAdapter getNewInfosByPageIndex:@"1" andPageSize:@"10" andBlock:^(NSMutableArray *blogInfos) {
    //        weakSelf.currentNewsInfos = blogInfos;
    //        [weakSelf.tableView reloadData];
    //    }];
    
    __weak typeof(self) weakSelf = self;
    
    self.homePageAdapter = [[HomePageAdapter alloc] initWithHomePageType:self.currentHomePageDisplayContent];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.homePageAdapter setHomePageBlogsInfo:^{
        
        switch (weakSelf.currentHomePageDisplayContent) {
            case HomePageDisplayContentFrist :
                weakSelf.currentNewsInfos = [GlobalData getBlogsInfoArray];
                break;
            case HomePageDisplayContentEssence :
                weakSelf.currentNewsInfos = [GlobalData getBlogsPickInfoArray];
                break;
            case HomePageDisplayContentCandidate :
                weakSelf.currentNewsInfos = [GlobalData getBlogsCandidateInfoArray];
                break;
            case HomePageDisplayContentNews :
                weakSelf.currentNewsInfos = [GlobalData getNewsInfoArray];
                break;
            default:
                break;
        }
        
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
    
    BlogAndNewsInfo *newsInfo = ((BlogAndNewsInfo *)(self.currentNewsInfos[indexPath.row]));
    
    BlogsContentTableViewCell *contentCell=[tableView dequeueReusableCellWithIdentifier:blogContentCellIdentifier forIndexPath:indexPath];
    [contentCell setInfoViewData:(id)newsInfo];
    return contentCell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BlogAndNewsInfo *newsInfo = ((BlogAndNewsInfo *)(self.currentNewsInfos[indexPath.row]));
    
    BlogBodyViewController *blogBodyViewController = [BlogBodyViewController new];
    blogBodyViewController.blogId = newsInfo.blogId;
    
    if (self.currentHomePageDisplayContent == HomePageDisplayContentNews) {
        blogBodyViewController.contentType = WebViewDisplayTypeNews;
    } else {
        blogBodyViewController.contentType = WebViewDisplayTypeBlog;
    }
    
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

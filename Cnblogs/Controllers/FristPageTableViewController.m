//
//  BlogsTableViewController.m
//  Cnblogs
//
//  Created by lesiney on 16/3/20.
//  Copyright © 2016年 LongHairPig. All rights reserved.
//

#import "FristPageTableViewController.h"
#import "HomePageAdapter.h"
#import "BlogsContentTableViewCell.h"
#import "ImportantRecommandTableViewCell.h"
#import "GlobalData.h"
#import "ImportantRecommandBlog.h"
#import "BlogAndNewsInfo.h"
#import "BlogBodyViewController.h"

static NSString *blogContentCell= @"BlogsContentTableViewCell";
static NSString *blogContentCellIdentifier= @"BlogsContentTableViewCellIdentifier";
static NSString *recommandBlogCellIdentifier = @"ImportantRecommandTableViewCellIdentifier";

@interface FristPageTableViewController ()

@property (strong,nonatomic) HomePageAdapter *homePageAdapter;

@property (strong,nonatomic) BlogAdapter *blogAdapter;

@end

@implementation FristPageTableViewController {
    NSLock *_lock;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化锁对象
    _lock=[[NSLock alloc]init];
    
    self.homePageAdapter = [[HomePageAdapter alloc] initWithHomePageType:HomePageDisplayContentFrist];
    self.blogAdapter = [BlogAdapter new];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    __weak typeof(self) weakSelf = self;
    [self.homePageAdapter setHomePageBlogsInfo:^{
        [weakSelf reloadTableViewData];
    }];
    
    
    UINib *blogContentNib = [UINib nibWithNibName:blogContentCell bundle:nil];
    [self.tableView registerNib:blogContentNib forCellReuseIdentifier:blogContentCellIdentifier];
    [self.tableView registerClass:[ImportantRecommandTableViewCell class] forCellReuseIdentifier:recommandBlogCellIdentifier];
    
    
}

- (void)reloadTableViewData {
    
    //加锁
    [_lock lock];
    [self.tableView reloadData];
    //使用完解锁
    [_lock unlock];
    
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
    return [GlobalData getImportentRecommandArray].count + [GlobalData getBlogsInfoArray].count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (![GlobalData getImportentRecommandArray] || ![GlobalData getBlogsInfoArray]) {
        return nil;
    }
    
    NSInteger rowIndex =indexPath.row >= [GlobalData getImportentRecommandArray].count ? (indexPath.row - [GlobalData getImportentRecommandArray].count) : indexPath.row;
    
    if(indexPath.row < [GlobalData getImportentRecommandArray].count){
        ImportantRecommandBlog *importantRecommandBlog = ((ImportantRecommandBlog *)([GlobalData getImportentRecommandArray][rowIndex]));
        
        ImportantRecommandTableViewCell *recommandCell=[tableView dequeueReusableCellWithIdentifier:recommandBlogCellIdentifier forIndexPath:indexPath];
        [recommandCell setViewData:importantRecommandBlog];
        return recommandCell;
    }else{
        BlogAndNewsInfo *blogInfo = ((BlogAndNewsInfo *)([GlobalData getBlogsInfoArray][rowIndex]));
        
        BlogsContentTableViewCell *contentCell=[tableView dequeueReusableCellWithIdentifier:blogContentCellIdentifier forIndexPath:indexPath];
        [contentCell setInfoViewData:(id)blogInfo];
        return contentCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *currentSelectBlogId = nil;
    NSString *currentTitle = nil;
    
    NSInteger rowIndex =indexPath.row >= [GlobalData getImportentRecommandArray].count ? (indexPath.row - [GlobalData getImportentRecommandArray].count) : indexPath.row;
    
    if (indexPath.row < [GlobalData getImportentRecommandArray].count) {
        ImportantRecommandBlog *importantRecommandBlog = ((ImportantRecommandBlog *)([GlobalData getImportentRecommandArray][rowIndex]));
        currentSelectBlogId = importantRecommandBlog.blogId;
        currentTitle = importantRecommandBlog.content;
    } else {
        BlogAndNewsInfo *blogInfo = ((BlogAndNewsInfo *)([GlobalData getBlogsInfoArray][rowIndex]));
        currentSelectBlogId = blogInfo.blogId;
        currentTitle = blogInfo.blogTitle;
    }
    if (currentSelectBlogId) {
        
        WebViewDisplayType displayType;
        if ([currentTitle containsString:@"[新闻"] || [currentTitle containsString:@"新闻]"] ) {
            displayType = WebViewDisplayTypeNews;
        } else {
            displayType = WebViewDisplayTypeBlog;
        }
        
        if (self.gotoBlogBodyViewController) {
            self.gotoBlogBodyViewController(currentSelectBlogId,currentTitle,displayType);
        }
        
    }
}

#pragma mark 设置每行高度（每行高度可以不一样）
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row < [GlobalData getImportentRecommandArray].count){
        return 40;
    }
    return 180;
}

//#pragma mark 设置分组标题内容高度
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if(section==0){
//        return 10;
//    }
//    return 6;
//}
//
//#pragma mark 设置尾部说明内容高度
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 2;
//}
//
//#pragma mark 返回每组头标题名称
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    NSLog(@"生成组（组%li）名称",(long)section);
//    return @"";
//}
//
//#pragma mark 返回每组尾部说明
//- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
//    NSLog(@"生成尾部（组%li）详情",(long)section);
//    return @"";
//}
//
//- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
//    view.tintColor = [UIColor clearColor];
//}
//
//- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(nonnull UIView *)view forSection:(NSInteger)section {
//    view.tintColor = [UIColor clearColor];
//}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

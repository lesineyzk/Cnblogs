//
//  BlogMainViewController.m
//  Cnblogs
//
//  Created by lesiney on 16/4/14.
//  Copyright © 2016年 LongHairPig. All rights reserved.
//

#import "BlogMainViewController.h"
#import "FristPageTableViewController.h"
#import "View+MASAdditions.h"
#import "GlobalCommonData.h"
#import "Enum.h"
#import "BlogBodyViewController.h"

#import "BlogTableViewController.h"

@interface BlogMainViewController ()


@end

@implementation BlogMainViewController{
    
    FristPageTableViewController *blogsTableViewController;
    NSArray *headArray;
    UIScrollView *headScrollView;
    UIViewController *currentVC;
    NSInteger currentBlogType;
    UILabel *headerUnderLineLable;
    NSMutableArray *headerButtonArray;
    
    BlogTableViewController *secondVC;
    BlogTableViewController *threeVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self layoutSubView];
}

- (void)layoutSubView {
    [self layoutHeaderView];
    [self layoutSubViewControllers];
    self.title = self.tabBarController.tabBar.items[0].title;
}

- (void)layoutHeaderView {
    
    headArray = @[@"首页",@"精华",@"候选"];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    headScrollView = [[UIScrollView alloc] init];
    headScrollView.backgroundColor = [GlobalCommonData getThemeGray];
    headScrollView.contentSize = CGSizeMake(560, 0);
    headScrollView.bounces = NO;
    headScrollView.pagingEnabled = YES;
    [self.view addSubview:headScrollView];
    [headScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.right.equalTo(self.view).offset(0);
        make.height.offset(40);
    }];
    
    headerButtonArray = [NSMutableArray new];
    for (int i = 0; i < [headArray count]; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.frame = CGRectMake(0 + i*80, 0, 80, 40);
        
        [button setTitle:[headArray objectAtIndex:i] forState:UIControlStateNormal];
        button.tag = i;
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(didClickHeadButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [headScrollView addSubview:button];
        [headerButtonArray addObject:button];
    }
    
    headerUnderLineLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 36, 40, 2)];
    headerUnderLineLable.backgroundColor = [GlobalCommonData getThemeBlue];
    [headScrollView addSubview:headerUnderLineLable];
}

- (void)layoutSubViewControllers {
    
    __weak typeof(self) weakSelf = self;
    blogsTableViewController = [FristPageTableViewController new];
    blogsTableViewController.gotoBlogBodyViewController = ^(NSString *blogId, NSString *blogTitle, WebViewDisplayType dispalyType){
        
        [weakSelf gotoBlogBodyViewController:blogId withBlogTitle:blogTitle withDisplayType:dispalyType];
        
    };
    
    [self addChildViewController:blogsTableViewController];
    [self.view addSubview:blogsTableViewController.view];
    
    [blogsTableViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(104, 0, 0, 0));
    }];
    
    currentBlogType = 0;
    currentVC = blogsTableViewController;
    [((UIButton *)[headerButtonArray objectAtIndex:0]) setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];;
}

- (void)gotoBlogBodyViewController: (NSString *)blogId withBlogTitle:(NSString *)blogTitle withDisplayType:(WebViewDisplayType) dispalyType {
    
    BlogBodyViewController *blogBodyViewController = [BlogBodyViewController new];
    blogBodyViewController.blogId = blogId;
    blogBodyViewController.blogTitle = blogTitle;
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    blogBodyViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:blogBodyViewController animated:YES];
    
}

- (void)didClickHeadButtonAction:(UIButton *)button
{
    //  点击处于当前页面的按钮,直接跳出
    if (currentBlogType == button.tag) {
        return;
    }
    
    switch (button.tag) {
        case BlogDisplayContentFrist:
            [self replaceController:button oldController:currentVC newController:blogsTableViewController];
            break;
        case BlogDisplayContentEssence:
            if (!secondVC) {
                secondVC = [[NewsTableViewController alloc] initWithHomePageType:HomePageDisplayContentEssence];
            }
            [self replaceController:button oldController:currentVC newController:secondVC];
            break;
        case BlogDisplayContentCandidate:
            if (!threeVC) {
                threeVC = [[NewsTableViewController alloc] initWithHomePageType:HomePageDisplayContentCandidate];
            }
            [self replaceController:button oldController:currentVC newController:threeVC];
            break;
        default:
            break;
    }
    
}

//  切换各个标签内容
- (void)replaceController:(UIButton *)button oldController:(UIViewController *)oldController newController:(UIViewController *)newController
{
    /**
     *  transitionFromViewController:toViewController:duration:options:animations:completion:
     *  fromViewController      当前显示在父视图控制器中的子视图控制器
     *  toViewController        将要显示的姿势图控制器
     *  duration                动画时间(这个属性,old friend 了 O(∩_∩)O)
     *  options                 动画效果(渐变,从下往上等等,具体查看API)
     *  animations              转换过程中得动画
     *  completion              转换完成
     */
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.7];
    CGPoint point = headerUnderLineLable.center;
    if (currentBlogType < button.tag) {
        point.x += 80;
    } else {
        point.x -= 80;
    }
    
    [headerUnderLineLable setCenter:point];
    [UIView commitAnimations];
    for (int i = 0; i<headerButtonArray.count; i++) {
        UIButton *currentButton = ((UIButton *)[headerButtonArray objectAtIndex:i]);
        if (currentButton.tag == button.tag) {
            [currentButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        } else {
            [currentButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
    }
    //???????
//    for (id headerButton in headerButtonArray) {
//        if ((UIButton *)headerButton == button) {
//            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        } else {
//            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//        }
//    }
    
    [self addChildViewController:newController];
    [self transitionFromViewController:oldController toViewController:newController duration:0.0 options:UIViewAnimationOptionTransitionNone animations:nil completion:^(BOOL finished) {
        
        if (finished) {
            
            [newController didMoveToParentViewController:self];
            [newController.view mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(104, 0, 0, 0));
            }];
            
            [oldController willMoveToParentViewController:nil];
            [oldController removeFromParentViewController];
            currentVC = newController;
        } else {
            
            currentVC = oldController;
        }
        currentBlogType = button.tag;
    }];
    
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

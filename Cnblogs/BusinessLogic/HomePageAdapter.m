//
//  BlogAdapter.m
//  Cnblogs
//
//  Created by lesiney on 16/3/20.
//  Copyright © 2016年 LongHairPig. All rights reserved.
//

#import "HomePageAdapter.h"
#import "NetworkingAPI.h"
#import "TFHpple.h"
#import "ImportantRecommandBlog.h"
#import "GlobalData.h"
#import "IdConvertToSome.h"
#import "NetworkingAPI.h"
#import "BlogInfo.h"
#import "Enum.h"

typedef void(^TestBlock)(id data,NSError *error);

@interface HomePageAdapter()

@property (readwrite,nonatomic,copy) TestBlock testBlock;

@end

@implementation HomePageAdapter {
    
    NSMutableString *httpAddress;
    BOOL isLoadBaseInfo;
    HomePageDisplayContent currentHomePageDisplayContent;
    
}

- (HomePageAdapter *)initWithHomePageType :(HomePageDisplayContent)homePageDisplayContent
{
    if(self = [super init]){
        isLoadBaseInfo = NO;
        httpAddress = [NSMutableString stringWithString: @"http://www.cnblogs.com"];
        currentHomePageDisplayContent = homePageDisplayContent;
        switch (homePageDisplayContent) {
            case HomePageDisplayContentFrist :
                isLoadBaseInfo = YES;
                break;
            case HomePageDisplayContentEssence :
                [httpAddress appendFormat:@"/pick"];
                break;
            case HomePageDisplayContentCandidate :
                [httpAddress appendFormat:@"/candidate"];
                break;
            case HomePageDisplayContentNews :
                [httpAddress appendFormat:@"/news"];
                break;
            default:
                break;
        }
    }
    
    return self;
}

- (void)setImportRecommandInfo:(TFHpple *)htmlTFHpple{
    
    //获取推荐博客信息
    static NSString *divFroIdString = @"//div[@id='headline_block']/ul/li/a[1]";
    NSArray *elements  = [htmlTFHpple searchWithXPathQuery:divFroIdString];
    
    NSMutableArray *improtantRecommand = [[NSMutableArray alloc] init];
    
    for (TFHppleElement *element in elements) {
        ImportantRecommandBlog *importantRecommandBlog = [[ImportantRecommandBlog alloc] init];
        
        importantRecommandBlog.content = ((TFHppleElement *)(element.children[0])).content;
        importantRecommandBlog.blogHttpAddress = [element.attributes objectForKey:@"href"];
        
        [improtantRecommand addObject:importantRecommandBlog];
    }
    
    [GlobalData setImportRecommandArray:improtantRecommand];
    
}

- (void)setBlogsInfo:(TFHpple *)htmlTFHpple{
    
    //获取博客主体信息
    static NSString *recommandCountSpanString = @"//div[@class='post_item']/div[@class='digg']/div[@class='diggit']/span";
    NSArray *recommandCountElements = [htmlTFHpple searchWithXPathQuery:recommandCountSpanString];
    
    static NSString *blogTitleString = @"//div[@class='post_item']/div[@class='post_item_body']/h3/a";
    static NSString *blogContentString = @"//div[@class='post_item']/div[@class='post_item_body']/p";
    static NSString *blogDateString = @"//div[@class='post_item']/div[@class='post_item_body']/div";
    static NSString *blogAuthorString = @"//div[@class='post_item']/div[@class='post_item_body']/div/a";
    static NSString *blogCommentString = @"//div[@class='post_item']/div[@class='post_item_body']/div/span[@class='article_comment']/a";
    static NSString *blogReadString = @"//div[@class='post_item']/div[@class='post_item_body']/div/span[@class='article_view']/a";
    
    NSArray *blogsTitleElements = [htmlTFHpple searchWithXPathQuery:blogTitleString];
    NSArray *blogsContentElements = [htmlTFHpple searchWithXPathQuery:blogContentString];
    NSArray *blogsDateElements = [htmlTFHpple searchWithXPathQuery:blogDateString];
    NSArray *blogsAuthorElements = [htmlTFHpple searchWithXPathQuery:blogAuthorString];
    NSArray *blogsCommentElements = [htmlTFHpple searchWithXPathQuery:blogCommentString];
    NSArray *blogsReadElements = [htmlTFHpple searchWithXPathQuery:blogReadString];
    
    NSMutableArray *blogInfoArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i<recommandCountElements.count; i++) {
        
        BlogAndNewsInfo *blogInfo = [[BlogAndNewsInfo alloc] init];
        blogInfo.recommandCount = ((TFHppleElement *)((TFHppleElement *)recommandCountElements[i]).children[0]).content;
        
        blogInfo.blogId = [((TFHppleElement *)recommandCountElements[i]).attributes objectForKey:@"id"];
        
        blogInfo.blogTitle = ((TFHppleElement *)((TFHppleElement *)blogsTitleElements[i]).children[0]).content;
        blogInfo.blogHttpAddress = [((TFHppleElement *)((TFHppleElement *)blogsTitleElements[i]).children[0]).attributes objectForKey:@"href"];
        if (!blogInfo.blogHttpAddress) {
            blogInfo.blogHttpAddress = [((TFHppleElement *)blogsTitleElements[0]).attributes objectForKey:@"href"];
        }
        if (((TFHppleElement *)blogsContentElements[i]).children.count == 3) {
            blogInfo.blogContent = ((TFHppleElement *)((TFHppleElement *)blogsContentElements[i]).children[2]).content;
            blogInfo.blogAuthorHttpAddress = [((TFHppleElement *)((TFHppleElement *)blogsContentElements[i]).children[1]).attributes objectForKey:@"href"];
            blogInfo.blogAuthorLogoHttpAddress = [((TFHppleElement *)((TFHppleElement *)((TFHppleElement *)blogsContentElements[i]).children[1]).children[0]).attributes objectForKey:@"src"];
        }else{
            blogInfo.blogContent = ((TFHppleElement *)((TFHppleElement *)blogsContentElements[i]).children[((TFHppleElement *)blogsContentElements[i]).children.count - 1]).content;
        }
        blogInfo.blogDate = ((TFHppleElement *)((TFHppleElement *)blogsDateElements[i]).children[2]).content;
        blogInfo.blogAuthor = ((TFHppleElement *)((TFHppleElement *)blogsAuthorElements[i]).children[0]).content;
        blogInfo.commentCount = ((TFHppleElement *)((TFHppleElement *)blogsCommentElements[i]).children[0]).content;
        blogInfo.readCount = ((TFHppleElement *)((TFHppleElement *)blogsReadElements[i]).children[0]).content;
        
        [blogInfoArray addObject:blogInfo];
    }
    
    [self setInfoArray:blogInfoArray];
    
}

- (void)setHomePageBlogsInfo:(void (^)(void))block{
    
    [[[NetworkingAPI alloc] init]
     getRequestDataWithPath:httpAddress
     withParams:nil
     andBlock: ^(id data, NSError *error) {
         TFHpple *tfhpple =  [IdConvertToSome idConvertToTFHppleForHTML:data];
         [self setBlogsInfo:tfhpple];
         
         if (isLoadBaseInfo) {
             [self setImportRecommandInfo:tfhpple];
         }
         
         block();
     }];
}

- (void)setInfoArray: (NSMutableArray *)infoArray {
    
    switch (currentHomePageDisplayContent) {
        case HomePageDisplayContentFrist :
            [GlobalData setBlogsInfoArray:infoArray];
            break;
        case HomePageDisplayContentEssence :
            [GlobalData setBlogsPickInfoArray:infoArray];
            break;
        case HomePageDisplayContentCandidate :
            [GlobalData setBlogsCandidateInfoArray:infoArray];
            break;
        case HomePageDisplayContentNews :
            [GlobalData setNewsInfoArray:infoArray];
            break;
        default:
            break;
    }

    
}




























@end

//
//  GlobalData.m
//  Cnblogs
//
//  Created by lesiney on 16/3/30.
//  Copyright © 2016年 LongHairPig. All rights reserved.
//

#import "GlobalData.h"

static NSMutableArray *importantRecommandArray;
static NSMutableArray *blogsInfoArray;
static NSMutableArray *blogsPickInfoArray;
static NSMutableArray *blogsCandidateInfoArray;

static NSMutableArray *newsInfoArray;

@implementation GlobalData

+ (NSMutableArray *)getImportentRecommandArray{
    if (!importantRecommandArray) {
        importantRecommandArray = [[NSMutableArray alloc] init];
    }
    return importantRecommandArray;
}

+ (void)setImportRecommandArray:(NSMutableArray *) _importantRecommandArray{
    
    importantRecommandArray = _importantRecommandArray;
}

+ (NSMutableArray *)getBlogsInfoArray{
    if (!blogsInfoArray) {
        blogsInfoArray = [[NSMutableArray alloc] init];
    }
    return blogsInfoArray;
}

+ (void)setBlogsInfoArray:(NSMutableArray *) _blogsInfoArray{
    
    blogsInfoArray = _blogsInfoArray;
}

+ (NSMutableArray *)getBlogsPickInfoArray{
    if (!blogsPickInfoArray) {
        blogsPickInfoArray = [[NSMutableArray alloc] init];
    }
    return blogsPickInfoArray;
}

+ (void)setBlogsPickInfoArray:(NSMutableArray *) _blogsPickInfoArray{
    
    blogsPickInfoArray = _blogsPickInfoArray;
}

+ (NSMutableArray *)getBlogsCandidateInfoArray{
    if (!blogsCandidateInfoArray) {
        blogsCandidateInfoArray = [[NSMutableArray alloc] init];
    }
    return blogsCandidateInfoArray;
}

+ (void)setBlogsCandidateInfoArray:(NSMutableArray *) _blogsCandidateInfoArray{
    
    blogsCandidateInfoArray = _blogsCandidateInfoArray;
}



+ (NSMutableArray *)getNewsInfoArray{
    if (!newsInfoArray) {
        newsInfoArray = [[NSMutableArray alloc] init];
    }
    return newsInfoArray;
}

+ (void)setNewsInfoArray:(NSMutableArray *) _newsInfoArray{
    
    newsInfoArray = _newsInfoArray;
}

@end

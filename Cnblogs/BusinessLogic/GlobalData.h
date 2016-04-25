//
//  GlobalData.h
//  Cnblogs
//
//  Created by lesiney on 16/3/30.
//  Copyright © 2016年 LongHairPig. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalData : NSObject

+ (NSMutableArray *)getImportentRecommandArray;
+ (void)setImportRecommandArray:(NSMutableArray *) _importantRecommandArray;

+ (NSMutableArray *)getBlogsInfoArray;
+ (void)setBlogsInfoArray:(NSMutableArray *) _blogsInfoArray;

+ (NSMutableArray *)getBlogsPickInfoArray;
+ (void)setBlogsPickInfoArray:(NSMutableArray *) _blogsPickInfoArray;

+ (NSMutableArray *)getBlogsCandidateInfoArray;
+ (void)setBlogsCandidateInfoArray:(NSMutableArray *) _blogsCandidateInfoArray;

+ (NSMutableArray *)getNewsInfoArray;
+ (void)setNewsInfoArray:(NSMutableArray *) _newsInfoArray;

@end

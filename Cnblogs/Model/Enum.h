//
//  Enum.h
//  Cnblogs
//
//  Created by lesiney on 16/4/15.
//  Copyright © 2016年 LongHairPig. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Enum : NSObject

typedef NS_ENUM(NSInteger, WebViewDisplayType) {
    WebViewDisplayTypeBlog = 0,
    WebViewDisplayTypeNews
};

typedef NS_ENUM(NSInteger, BlogDisplayContent) {
    BlogDisplayContentFrist = 0, //首页
    BlogDisplayContentEssence,//精华
    BlogDisplayContentCandidate//候选
};

typedef NS_ENUM(NSInteger, HomePageDisplayContent) {
    HomePageDisplayContentFrist = 0, //首页
    HomePageDisplayContentEssence,//精华
    HomePageDisplayContentCandidate,//候选
    HomePageDisplayContentNews//新闻
};

@end

//
//  NewsInfo.h
//  Cnblogs
//
//  Created by lesiney on 16/4/12.
//  Copyright © 2016年 LongHairPig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BlogAndNewsInfo.h"

@interface NewsInfo : BlogAndNewsInfo

@property (readwrite,nonatomic,strong) NSString *newsSource, *newsTopicIcon;

@end

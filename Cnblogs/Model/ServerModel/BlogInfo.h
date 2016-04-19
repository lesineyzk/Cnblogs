//
//  BlogInfo.h
//  Cnblogs
//
//  Created by lesiney on 16/4/4.
//  Copyright © 2016年 LongHairPig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BlogAndNewsInfo.h"

@interface BlogInfo : BlogAndNewsInfo

@property (readwrite,nonatomic,strong) NSString *blogAuthor, *blogAuthorLogoHttpAddress;

@end

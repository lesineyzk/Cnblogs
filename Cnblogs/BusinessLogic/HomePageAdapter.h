//
//  BlogAdapter.h
//  Cnblogs
//
//  Created by lesiney on 16/3/20.
//  Copyright © 2016年 LongHairPig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Enum.h"

@interface HomePageAdapter : NSObject

- (HomePageAdapter *)initWithHomePageType :(HomePageDisplayContent)homePageDisplayContent;

- (void)setHomePageBlogsInfo:(void (^)(void))block;

@end

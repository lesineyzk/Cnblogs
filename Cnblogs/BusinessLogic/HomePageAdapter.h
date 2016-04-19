//
//  BlogAdapter.h
//  Cnblogs
//
//  Created by lesiney on 16/3/20.
//  Copyright © 2016年 LongHairPig. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomePageAdapter : NSObject

- (void)setHomePageBlogsInfo:(void (^)(void))block;

@end

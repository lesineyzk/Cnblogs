//
//  BlogAndNewsInfo.h
//  Cnblogs
//
//  Created by lesiney on 16/4/12.
//  Copyright © 2016年 LongHairPig. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlogAndNewsInfo : NSObject

@property (readwrite,nonatomic,strong) NSString *recommandCount, *blogTitle, *blogHttpAddress, *blogId;

@property (readwrite,nonatomic,strong) NSString *blogAuthorHttpAddress, *blogContent;

@property (readwrite,nonatomic,strong) NSString *commentCount, *readCount, *blogDate;

@end

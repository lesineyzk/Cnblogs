//
//  BlogAdapter.h
//  Cnblogs
//
//  Created by lesiney on 16/4/9.
//  Copyright © 2016年 LongHairPig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkingAPI.h"
#import "IdConvertToSome.h"
#import "BlogInfo.h"


@interface BlogAdapter : NSObject<NSXMLParserDelegate>

- (void)getBlogBodyString: (NSString *)blogId andBlock: (void (^)(NSString *))myBlock;

- (void)getBlogInfosByPageIndex: (NSString *)pageIndex andPageSize: (NSString *)pageSize andBlock: (void (^)(NSMutableArray *))myBlock;

@end

//
//  NewsAdapter.h
//  Cnblogs
//
//  Created by lesiney on 16/4/12.
//  Copyright © 2016年 LongHairPig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkingAPI.h"
#import "NewsInfo.h"

@interface NewsAdapter : NSObject<NSXMLParserDelegate>

- (void)getNewsBodyString: (NSString *)newsId andBlock: (void (^)(NSString *))myBlock;

- (void)getNewInfosByPageIndex: (NSString *)pageIndex andPageSize: (NSString *)pageSize andBlock: (void (^)(NSMutableArray *))myBlock;

@end

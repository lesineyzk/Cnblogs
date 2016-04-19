//
//  ImportantRecommandBlog.m
//  Cnblogs
//
//  Created by lesiney on 16/3/29.
//  Copyright © 2016年 LongHairPig. All rights reserved.
//

#import "ImportantRecommandBlog.h"

@interface ImportantRecommandBlog()


@end

@implementation ImportantRecommandBlog

- (void)setBlogHttpAddress:(NSString *)blogHttpAddress{
    
    _blogHttpAddress = blogHttpAddress;
    
    NSString *temp = nil;
    if (_blogHttpAddress) {
        NSArray *arrayP = [_blogHttpAddress componentsSeparatedByString:@"/p/"];
        if (arrayP.count>1) {
            temp = [(NSString *)arrayP[1] stringByReplacingOccurrencesOfString:@".html" withString:@""];
            temp = [temp stringByReplacingOccurrencesOfString:@"/" withString:@""];
        }else{
            NSArray *arrayN = [_blogHttpAddress componentsSeparatedByString:@"/n/"];
            if (arrayN.count>1) {
                temp = [(NSString *)arrayN[1] stringByReplacingOccurrencesOfString:@".html" withString:@""];
                temp = [temp stringByReplacingOccurrencesOfString:@"/" withString:@""];
            }
        }
    }
    self.blogId = temp;
}

@end

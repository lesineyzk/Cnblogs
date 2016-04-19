//
//  NewsAdapter.m
//  Cnblogs
//
//  Created by lesiney on 16/4/12.
//  Copyright © 2016年 LongHairPig. All rights reserved.
//

#import "NewsAdapter.h"

typedef void (^NewsStringBlock)(NSString *bodyString);
typedef void (^NewsInfosBlock)(NSMutableArray *newsInfosArray);

@interface NewsAdapter()

@property (nonatomic,strong) NSMutableString *newsBodyString;

@property (nonatomic,copy) NewsStringBlock newsStringBlock;

@property (nonatomic,copy) NewsInfosBlock newsInfosBlock;

@property (nonatomic,strong) NSMutableArray *newsInfosArray;

@property (nonatomic,strong) NewsInfo *newsInfo;

@property (nonatomic,strong) NSMutableString *newsInfoField;

@property (nonatomic,strong) NSString *newsInfoAttribute;

@end

@implementation NewsAdapter{
    NSString *newsBodyPublicID;
    NSString *newsInfosPublicID;
}

- (void)getNewsBodyString: (NSString *)newsId andBlock: (void (^)(NSString *))myBlock {
    
    [self getBodyString:newsId withHttpAddress:@"http://wcf.open.cnblogs.com/news/item" andBlock:myBlock];
    
}

- (void)getBodyString: (NSString *)blogId withHttpAddress:(NSString *)httpAddress andBlock: (void (^)(NSString *))myBlock {
    
    [[[NetworkingAPI alloc] init]
     getRequestXMLWithPath: [NSString stringWithFormat:@"%@/%@",httpAddress,blogId]
     withParams:nil
     andBlock: ^(id data, NSError *error) {
         if (data) {
             self.newsStringBlock = myBlock;
             
             NSXMLParser *parser = (NSXMLParser *)data;
             newsBodyPublicID = [parser description];
             [parser setDelegate:self];
             [parser parse];
         }
     }];
}

- (void)getNewInfosByPageIndex: (NSString *)pageIndex andPageSize: (NSString *)pageSize andBlock: (void (^)(NSMutableArray *))myBlock{
    
    [self getInfosByPageIndex:pageIndex andPageSize:pageSize andHttpAddress:@"http://wcf.open.cnblogs.com/news/recent/paged" andBlock:myBlock];
    
}

- (void)getInfosByPageIndex: (NSString *)pageIndex andPageSize: (NSString *)pageSize andHttpAddress: (NSString *)openHttpAddress andBlock: (void (^)(NSMutableArray *))myBlock{
    
    [[[NetworkingAPI alloc] init]
     getRequestXMLWithPath: [NSString stringWithFormat:@"%@/%@/%@",openHttpAddress,pageIndex,pageSize]
     withParams:nil
     andBlock: ^(id data, NSError *error) {
         if (data) {
             self.newsInfosBlock = myBlock;
             
             NSXMLParser *parser = (NSXMLParser *)data;
             newsInfosPublicID = [parser description];
             [parser setDelegate:self];
             [parser parse];
         }
     }];
}

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
    
    if ([[parser description] isEqualToString:newsBodyPublicID]) {
        if ([elementName isEqualToString:@"Content"]) {
            if (!self.newsBodyString) {
                self.newsBodyString = [[NSMutableString alloc] init];
            }
        }
    } else if ([[parser description] isEqualToString:newsInfosPublicID]) {
        
        if (!self.newsInfosArray) {
            self.newsInfosArray = [NSMutableArray new];
        }
        if (!self.newsInfoField) {
            self.newsInfoField = [[NSMutableString alloc] init];
        }
        if ([elementName isEqualToString:@"entry"]) {
            self.newsInfo = [NewsInfo new];
        }
        if ([elementName isEqualToString:@"link"] && self.newsInfo) {
            self.newsInfoAttribute = [attributeDict objectForKey:@"href"];
        }
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if (self.newsBodyString) {
        [self.newsBodyString appendString:string];
//        [self.newsBodyString setString:[self.newsBodyString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
//        NSString *stringOne = [self.newsBodyString stringByReplacingOccurrencesOfString:@"<" withString:@""];
//        NSString *stringTwo = [stringOne stringByReplacingOccurrencesOfString:@">" withString:@""];
//        self.newsBodyString = [NSMutableString stringWithString:stringTwo];
    }
    
    if ([[parser description] isEqualToString:newsBodyPublicID]) {
        
        if (self.newsBodyString) {
            [self.newsBodyString appendString:string];
        }
        
    } else if ([[parser description] isEqualToString:newsInfosPublicID]) {
        if (!self.newsInfo) {
            return;
        }
        [self.newsInfoField appendString:string];
    }
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName{
    
    if ([[parser description] isEqualToString:newsBodyPublicID]) {
        if ([elementName isEqualToString:@"Content"]) {
            self.newsStringBlock(self.newsBodyString);
        }
        self.newsBodyString = nil;
    } else if ([[parser description] isEqualToString:newsInfosPublicID]) {
        if ([elementName isEqualToString:@"feed"]) {
            self.newsInfosBlock(self.newsInfosArray);
        } else if ([elementName isEqualToString:@"entry"]) {
            [self.newsInfosArray addObject: self.newsInfo];
            self.newsInfo = nil;
        }
        if (!self.newsInfo) {
            return;
        }
        if ([elementName isEqualToString:@"id"]) {
            self.newsInfo.blogId = self.newsInfoField;
        } else if ([elementName isEqualToString:@"title"]) {
            self.newsInfo.blogTitle = self.newsInfoField;
        } else if ([elementName isEqualToString:@"summary"]) {
            self.newsInfo.blogContent = self.newsInfoField;
        } else if ([elementName isEqualToString:@"published"]) {
            self.newsInfo.blogDate = self.newsInfoField;
        } else if ([elementName isEqualToString:@"sourceName"]) {
            self.newsInfo.newsSource = self.newsInfoField;
        } else if ([elementName isEqualToString:@"uri"]) {
            self.newsInfo.blogAuthorHttpAddress = self.newsInfoField;
        } else if ([elementName isEqualToString:@"topicIcon"]) {
            self.newsInfo.newsTopicIcon = self.newsInfoField;
        } else if ([elementName isEqualToString:@"views"]) {
            self.newsInfo.readCount = self.newsInfoField;
        } else if ([elementName isEqualToString:@"comments"]) {
            self.newsInfo.commentCount = self.newsInfoField;
        } else if ([elementName isEqualToString:@"diggs"]) {
            self.newsInfo.recommandCount = self.newsInfoField;
        } else if ([elementName isEqualToString:@"link"]) {
            self.newsInfo.blogHttpAddress = self.newsInfoAttribute;
        }
        self.newsInfoField = nil;
        self.newsInfoAttribute = nil;
        
    }
}




























@end

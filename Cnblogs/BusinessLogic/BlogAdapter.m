//
//  BlogAdapter.m
//  Cnblogs
//
//  Created by lesiney on 16/4/9.
//  Copyright © 2016年 LongHairPig. All rights reserved.
//

#import "BlogAdapter.h"

typedef void (^BlogStringBlock)(NSString *bodyString);
typedef void (^BlogInfosBlock)(NSMutableArray *blogInfosArray);

@interface BlogAdapter()

@property (nonatomic,copy) BlogStringBlock blogStringBlock;

@property (nonatomic,copy) BlogInfosBlock blogInfosBlock;

@property (nonatomic,strong) NSMutableString *blogBodyString;

@property (nonatomic,strong) NSMutableArray *blogInfosArray;

@property (nonatomic,strong) BlogInfo *blogInfo;

@property (nonatomic,strong) NSMutableString *blogInfoField;

@property (nonatomic,strong) NSString *blogInfoAttribute;


@end

@implementation BlogAdapter{
    NSString *blogBodyPublicID;
    NSString *blogInfosPublicID;
}

- (void)getBlogBodyString: (NSString *)blogId andBlock: (void (^)(NSString *))myBlock {
    
    [self getBodyString:blogId withHttpAddress:@"http://wcf.open.cnblogs.com/blog/post/body" andBlock:myBlock];
}

- (void)getBodyString: (NSString *)blogId withHttpAddress:(NSString *)httpAddress andBlock: (void (^)(NSString *))myBlock {
    
    [[[NetworkingAPI alloc] init]
     getRequestXMLWithPath: [NSString stringWithFormat:@"%@/%@",httpAddress,blogId]
     withParams:nil
     andBlock: ^(id data, NSError *error) {
         if (data) {
             self.blogStringBlock = myBlock;
             
             NSXMLParser *parser = (NSXMLParser *)data;
             blogBodyPublicID = [parser description];
             [parser setDelegate:self];
             [parser parse];
         }
     }];
}

- (void)getBlogInfosByPageIndex: (NSString *)pageIndex andPageSize: (NSString *)pageSize andBlock: (void (^)(NSMutableArray *))myBlock{

    [self getInfosByPageIndex:pageIndex andPageSize:pageSize andHttpAddress:@"http://wcf.open.cnblogs.com/blog/sitehome/paged" andBlock:myBlock];
}

- (void)getInfosByPageIndex: (NSString *)pageIndex andPageSize: (NSString *)pageSize andHttpAddress: (NSString *)openHttpAddress andBlock: (void (^)(NSMutableArray *))myBlock{
    
    [[[NetworkingAPI alloc] init]
     getRequestXMLWithPath: [NSString stringWithFormat:@"%@/%@/%@",openHttpAddress,pageIndex,pageSize]
     withParams:nil
     andBlock: ^(id data, NSError *error) {
         if (data) {
             self.blogInfosBlock = myBlock;
             
             NSXMLParser *parser = (NSXMLParser *)data;
             blogInfosPublicID = [parser description];
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
    
    if ([[parser description] isEqualToString:blogBodyPublicID]) {
        if (!self.blogBodyString) {
            self.blogBodyString = [[NSMutableString alloc] init];
        }
    } else if ([[parser description] isEqualToString:blogInfosPublicID]) {
     
        if (!self.blogInfosArray) {
            self.blogInfosArray = [NSMutableArray new];
        }
        if (!self.blogInfoField) {
            self.blogInfoField = [[NSMutableString alloc] init];
        }
        if ([elementName isEqualToString:@"entry"]) {
            self.blogInfo = [BlogInfo new];
        }
        if ([elementName isEqualToString:@"link"] && self.blogInfo) {
            self.blogInfoAttribute = [attributeDict objectForKey:@"href"];
        }
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if ([[parser description] isEqualToString:blogBodyPublicID]) {

        [self.blogBodyString appendString:string];
        
    } else if ([[parser description] isEqualToString:blogInfosPublicID]) {
        if (!self.blogInfo) {
            return;
        }
        [self.blogInfoField appendString:string];
    }
    
    //    [currentString setString:[currentString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
}


- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName{
    
    if ([[parser description] isEqualToString:blogBodyPublicID]) {
        if ([elementName isEqualToString:@"string"]) {
            self.blogStringBlock(self.blogBodyString);
        }
    } else if ([[parser description] isEqualToString:blogInfosPublicID]) {
        if ([elementName isEqualToString:@"feed"]) {
            self.blogInfosBlock(self.blogInfosArray);
        } else if ([elementName isEqualToString:@"entry"]) {
            [self.blogInfosArray addObject: self.blogInfo];
            self.blogInfo = nil;
        }
        if (!self.blogInfo) {
            return;
        }
        if ([elementName isEqualToString:@"id"]) {
            self.blogInfo.blogId = self.blogInfoField;
        } else if ([elementName isEqualToString:@"title"]) {
            self.blogInfo.blogTitle = self.blogInfoField;
        } else if ([elementName isEqualToString:@"summary"]) {
            self.blogInfo.blogContent = self.blogInfoField;
        } else if ([elementName isEqualToString:@"published"]) {
            self.blogInfo.blogDate = self.blogInfoField;
        } else if ([elementName isEqualToString:@"name"]) {
            self.blogInfo.blogAuthor = self.blogInfoField;
        } else if ([elementName isEqualToString:@"uri"]) {
            self.blogInfo.blogAuthorHttpAddress = self.blogInfoField;
        } else if ([elementName isEqualToString:@"avatar"]) {
            self.blogInfo.blogAuthorLogoHttpAddress = self.blogInfoField;
        } else if ([elementName isEqualToString:@"views"]) {
            self.blogInfo.readCount = self.blogInfoField;
        } else if ([elementName isEqualToString:@"comments"]) {
            self.blogInfo.commentCount = self.blogInfoField;
        } else if ([elementName isEqualToString:@"diggs"]) {
            self.blogInfo.recommandCount = self.blogInfoField;
        } else if ([elementName isEqualToString:@"link"]) {
            self.blogInfo.blogHttpAddress = self.blogInfoAttribute;
        }
        self.blogInfoField = nil;
        self.blogInfoAttribute = nil;
        
    }
}






















@end

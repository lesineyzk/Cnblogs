//
//  NetAPICommon.m
//  Cnblogs
//
//  Created by lesiney on 16/3/26.
//  Copyright © 2016年 LongHairPig. All rights reserved.
//

#import "NetworkingAPI.h"
#import "TFHpple.h"
#import "ImportantRecommandBlog.h"

@implementation NetworkingAPI

- (void)requestJsonDataWithPath:(NSString *)aPath
                           file:(NSDictionary *)file
                     withParams:(NSDictionary *)params
                 withMethodType:(NetworkMethod)method andBlock:(void (^)(id, NSError *))block
{
    
}

- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(NetworkMethod)method
                  autoShowError:(BOOL)autoShowError
                       andBlock:(void (^)(id data, NSError *error))block
{
    
}

-(void)getRequestDataWithPath:(NSString *)aPath
                   withParams:(NSDictionary*)params
                     andBlock:(void (^)(id data,NSError *error))block
{
    //所有 Get 请求，增加缓存机制
    NSMutableString *localPath = [aPath mutableCopy];
    if (params) {
        [localPath appendString:params.description];
    }
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    
    //2.设置返回数据类型
    manager.responseSerializer = [AFHTTPResponseSerializer serializer]; //先实例化一下
    

    
    [manager GET:aPath parameters:params
        progress:nil
         success:^(NSURLSessionDataTask *operation, id responseObject) {
             
             block(responseObject,nil);
             
         } failure:^(NSURLSessionDataTask *operation, NSError *error) {
             
             DebugLog(@"\n===========response===========\n%@:\n%@", aPath, error);
             
             block(nil,error);
         }];
    
}

- (void)getRequestXMLWithPath:(NSString *)aPath
                   withParams:(NSDictionary*)params
                     andBlock:(void (^)(id data,NSError *error))block
{
    //所有 Get 请求，增加缓存机制
    NSMutableString *localPath = [aPath mutableCopy];
    if (params) {
        [localPath appendString:params.description];
    }
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    //2.设置返回数据类型
    manager.responseSerializer = [AFXMLParserResponseSerializer serializer]; //先实例化一下
    
    
    
    [manager GET:aPath parameters:params
        progress:nil
         success:^(NSURLSessionDataTask *operation, id responseObject) {
             
             
             block(responseObject,nil);
             
         } failure:^(NSURLSessionDataTask *operation, NSError *error) {
             
             DebugLog(@"\n===========response===========\n%@:\n%@", aPath, error);
             
             block(nil,error);
         }];
    
}



@end

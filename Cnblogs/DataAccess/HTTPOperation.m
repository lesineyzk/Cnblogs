//
//  HTTPOperation.m
//  Cnblogs
//
//  Created by lesiney on 16/3/23.
//  Copyright © 2016年 LongHairPig. All rights reserved.
//

#import "HTTPOperation.h"
#import "AFHTTPSessionManager.h"

#import "AFURLRequestSerialization.h"
#import "AFURLResponseSerialization.h"

//progress:(void (^)(NSProgress *downloadProgress)) downloadProgressBlock
//destination:(NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destination
//completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandler
//typedef NSInputStream * (^AFURLSessionTaskNeedNewBodyStreamBlock)(NSURLSession *session, NSURLSessionTask *task);
//typedef void (^AFURLSessionDataTaskDidBecomeDownloadTaskBlock)(NSURLSession *session, NSURLSessionDataTask *dataTask, NSURLSessionDownloadTask *downloadTask);

typedef void (^downloadProgressBlock)(NSProgress *downloadProgress);
typedef NSURL * (^destinationBlock)(NSURL *targetPath, NSURLResponse *response);
typedef void (^completionHandlerBlock)(NSURLResponse *response, NSURL *filePath, NSError *error);

@interface HTTPOperation()

@property (readwrite,nonatomic, copy) downloadProgressBlock downloadProgress;
@property (readwrite,nonatomic, copy) destinationBlock destination;
@property (readwrite,nonatomic, copy) completionHandlerBlock completionHandler;

@end

@implementation HTTPOperation

- (void)getCnblogHomePage
{
    
}




- (void)downloadDataWithHttpAddress:(NSString *)httpAddress
                           progress:(void (^)(NSProgress *downloadProgress)) downloadProgressBlock
                        destination:(NSURL * (^)(NSURL *targetPath, NSURLResponse *response))destinationBlock
                  completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath, NSError *error))completionHandlerBlock
{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:httpAddress];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request
                                                                     progress:downloadProgressBlock
                                                                  destination:destinationBlock
                                                            completionHandler:completionHandlerBlock
                                              ];
    [downloadTask resume];
}

+ (void)downloadDataWithGet:(NSString *)httpAddress
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    
    // Get请求
    [manager GET:httpAddress parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 请求失败
        NSLog(@"%@", [error localizedDescription]);
    }];
}























@end

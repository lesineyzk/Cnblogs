//
//  NSObject+Common.m
//  Cnblogs
//
//  Created by lesiney on 16/3/27.
//  Copyright © 2016年 LongHairPig. All rights reserved.
//
#define kPath_ResponseCache @"ResponseCache"

#import "NSObject+Common.h"

@implementation NSObject (Common)

#pragma mark File M
//获取fileName的完整地址
+ (NSString* )pathInCacheDirectory:(NSString *)fileName
{
    NSArray *cachePaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [cachePaths objectAtIndex:0];
    return [cachePath stringByAppendingPathComponent:fileName];
}
//创建缓存文件夹
+ (BOOL) createDirInCache:(NSString *)dirName
{
    NSString *dirPath = [self pathInCacheDirectory:dirName];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:dirPath isDirectory:&isDir];
    BOOL isCreated = NO;
    if ( !(isDir == YES && existed == YES) )
    {
        isCreated = [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    if (existed) {
        isCreated = YES;
    }
    return isCreated;
}

//网络请求
+ (BOOL)saveResponseData:(NSDictionary *)data
                  toPath:(NSString *)requestPath{
    if ([self createDirInCache:kPath_ResponseCache]) {
        NSString *abslutePath = [NSString stringWithFormat:@"%@/%@.plist", [self pathInCacheDirectory:kPath_ResponseCache], requestPath];
        return [data writeToFile:abslutePath atomically:YES];
    }else{
        return NO;
    }
}

+ (id) loadResponseWithPath:(NSString *)requestPath{//返回一个NSDictionary类型的json数据
        NSString *abslutePath = [NSString stringWithFormat:@"%@/%@.plist", [self pathInCacheDirectory:kPath_ResponseCache], requestPath];
    return [NSMutableDictionary dictionaryWithContentsOfFile:abslutePath];
}

+ (BOOL)deleteResponseCacheForPath:(NSString *)requestPath{
   
    NSString *abslutePath = [NSString stringWithFormat:@"%@/%@.plist", [self pathInCacheDirectory:kPath_ResponseCache], requestPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:abslutePath]) {
        return [fileManager removeItemAtPath:abslutePath error:nil];
    }else{
        return NO;
    }
}

+ (BOOL) deleteResponseCache{
    return [self deleteCacheWithPath:kPath_ResponseCache];
}

+ (BOOL) deleteCacheWithPath:(NSString *)cachePath{
    NSString *dirPath = [self pathInCacheDirectory:cachePath];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:dirPath isDirectory:&isDir];
    bool isDeleted = false;
    if ( isDir == YES && existed == YES )
    {
        isDeleted = [fileManager removeItemAtPath:dirPath error:nil];
    }
    return isDeleted;
}

#pragma mark NetError
-(id)handleResponse:(id)responseJSON{
    return [self handleResponse:responseJSON autoShowError:YES];
}

-(id)handleResponse:(id)responseJSON autoShowError:(BOOL)autoShowError{
    NSError *error = nil;
//    //code为非0值时，表示有错
//    NSNumber *resultCode = [responseJSON valueForKeyPath:@"code"];
//    
//    if (resultCode.intValue != 0) {
//        error = [NSError errorWithDomain:[NSObject baseURLStr] code:resultCode.intValue userInfo:responseJSON];
//        
//        if (resultCode.intValue == 1000 || resultCode.intValue == 3207) {//用户未登录
//            if ([Login isLogin]) {
//                [Login doLogout];//已登录的状态要抹掉
//                //更新 UI 要延迟 >1.0 秒，否则屏幕可能会不响应触摸事件。。暂不知为何
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [((AppDelegate *)[UIApplication sharedApplication].delegate) setupLoginViewController];
//                    kTipAlert(@"%@", [NSObject tipFromError:error]);
//                });
//            }
//        }else{
//            if (autoShowError) {
//                [NSObject showError:error];
//            }
//        }
//    }
    return error;
}


@end

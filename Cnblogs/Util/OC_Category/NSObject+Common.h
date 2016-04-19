//
//  NSObject+Common.h
//  Cnblogs
//
//  Created by lesiney on 16/3/27.
//  Copyright © 2016年 LongHairPig. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Common)

//网络请求
+ (BOOL)saveResponseData:(NSDictionary *)data toPath:(NSString *)requestPath;//缓存请求回来的json对象
+ (id)loadResponseWithPath:(NSString *)requestPath;//返回一个NSDictionary类型的json数据
+ (BOOL)deleteResponseCacheForPath:(NSString *)requestPath;
+ (BOOL)deleteResponseCache;

#pragma mark NetError
-(id)handleResponse:(id)responseJSON;
-(id)handleResponse:(id)responseJSON autoShowError:(BOOL)autoShowError;

@end

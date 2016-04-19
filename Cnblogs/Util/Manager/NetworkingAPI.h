//
//  NetAPICommon.h
//  Cnblogs
//
//  Created by lesiney on 16/3/26.
//  Copyright © 2016年 LongHairPig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef enum {

    Get = 0,
    Post,
    Put,
    Delete
    
} NetworkMethod;

typedef NS_ENUM(NSInteger, IllegalContentType) {
    IllegalContentTypeTweet = 0,
    IllegalContentTypeTopic,
    IllegalContentTypeProject,
    IllegalContentTypeWebsite
};


@interface NetworkingAPI : NSObject

//+ (id)sharedJsonClient;
//+ (id)changeJsonClient;
//
//- (void)requestJsonDataWithPath:(NSString *)aPath
//                     withParams:(NSDictionary*)params
//                 withMethodType:(NetworkMethod)method
//                       andBlock:(void (^)(id data, NSError *error))block;
//
//- (void)requestJsonDataWithPath:(NSString *)aPath
//                     withParams:(NSDictionary*)params
//                 withMethodType:(NetworkMethod)method
//                  autoShowError:(BOOL)autoShowError
//                       andBlock:(void (^)(id data, NSError *error))block;
//
//- (void)requestJsonDataWithPath:(NSString *)aPath
//                           file:(NSDictionary *)file
//                     withParams:(NSDictionary*)params
//                 withMethodType:(NetworkMethod)method
//                       andBlock:(void (^)(id data, NSError *error))block;
//
//
//- (void)reportIllegalContentWithType:(IllegalContentType)type
//                          withParams:(NSDictionary*)params;
//
//- (void)uploadImage:(UIImage *)image path:(NSString *)path name:(NSString *)name
//       successBlock:(void (^)(AFHTTPRequestSerializer *operation, id responseObject))success
//       failureBlock:(void (^)(AFHTTPRequestSerializer *operation, NSError *error))failure
//      progerssBlock:(void (^)(CGFloat progressValue))progress;
//
//- (void)uploadVoice:(NSString *)file
//           withPath:(NSString *)path
//         withParams:(NSDictionary*)params
//           andBlock:(void (^)(id data, NSError *error))block;

-(void)getRequestDataWithPath:(NSString *)aPath
                   withParams:(NSDictionary*)params
                     andBlock:(void (^)(id data, NSError *error))block;




-(void)getRequestXMLWithPath:(NSString *)aPath
                  withParams:(NSDictionary*)params
                    andBlock:(void (^)(id data,NSError *error))block;






@end

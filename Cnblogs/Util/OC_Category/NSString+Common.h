//
//  NSString+Common.h
//  Cnblogs
//
//  Created by lesiney on 16/3/27.
//  Copyright © 2016年 LongHairPig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+Emojize.h"
//#import "HtmlMedia.h"

@interface NSString (Common)
+ (NSString *)userAgentStr;

- (NSString *)URLEncoding;
- (NSString *)URLDecoding;
- (NSString *)md5Str;
- (NSString*) sha1Str;
- (NSURL *)urlWithCodePath;
//- (NSURL *)urlImageWithCodePathResize:(CGFloat)width;
//- (NSURL *)urlImageWithCodePathResize:(CGFloat)width crop:(BOOL)needCrop;
//- (NSURL *)urlImageWithCodePathResizeToView:(UIView *)view;
//
//
//- (NSString *)stringByRemoveHtmlTag;
//+ (NSString *)handelRef:(NSString *)ref path:(NSString *)path;
//
//
//- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
//- (CGFloat)getHeightWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
//- (CGFloat)getWidthWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
//-(BOOL)containsEmoji;
//
//- (NSString *)emotionMonkeyName;
//
//+ (NSString *)sizeDisplayWithByte:(CGFloat)sizeOfByte;

- (NSString *)trimWhitespace;
- (BOOL)isEmpty;
- (BOOL)isEmptyOrListening;
//判断是否为整形
- (BOOL)isPureInt;
//判断是否为浮点形
- (BOOL)isPureFloat;
//判断是否是手机号码或者邮箱
- (BOOL)isPhoneNo;
- (BOOL)isEmail;
- (BOOL)isGK;

- (NSRange)rangeByTrimmingLeftCharactersInSet:(NSCharacterSet *)characterSet;
- (NSRange)rangeByTrimmingRightCharactersInSet:(NSCharacterSet *)characterSet;

- (NSString *)stringByTrimmingLeftCharactersInSet:(NSCharacterSet *)characterSet;
- (NSString *)stringByTrimmingRightCharactersInSet:(NSCharacterSet *)characterSet;

//转换拼音
- (NSString *)transformToPinyin;

//是否包含语音解析的图标
- (BOOL)hasListenChar;

@end
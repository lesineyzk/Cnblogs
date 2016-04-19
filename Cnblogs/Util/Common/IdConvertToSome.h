//
//  IdConvertToSome.h
//  Cnblogs
//
//  Created by lesiney on 16/3/30.
//  Copyright © 2016年 LongHairPig. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TFHpple.h"
#import <UIKit/UIKit.h>

@interface IdConvertToSome : NSObject

+ (TFHpple *)idConvertToTFHppleForHTML:(id)responseObject;

+ (UIColor *)rgbConvertToUIColorByR:(int)rValue withG:(int)gValue withB:(int)bValue;

+ (NSString *)idConvertToStringForHTML:(id)responseObject;

@end

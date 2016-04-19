//
//  GlobalCommonData.m
//  Cnblogs
//
//  Created by lesiney on 16/4/2.
//  Copyright © 2016年 LongHairPig. All rights reserved.
//

#import "GlobalCommonData.h"
#import "IdConvertToSome.h"

@implementation GlobalCommonData

+ (UIColor *)getThemeBlue {
    return [IdConvertToSome rgbConvertToUIColorByR:(73) withG:(192) withB:235];
}

+ (UIColor *)getThemeGray {
    return [IdConvertToSome rgbConvertToUIColorByR:241 withG:242 withB:246];
}

@end

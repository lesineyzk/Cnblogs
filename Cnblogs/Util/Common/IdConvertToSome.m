//
//  IdConvertToSome.m
//  Cnblogs
//
//  Created by lesiney on 16/3/30.
//  Copyright © 2016年 LongHairPig. All rights reserved.
//

#import "IdConvertToSome.h"


@implementation IdConvertToSome

//response html convert to TFHpple
+ (TFHpple *)idConvertToTFHppleForHTML:(id)responseObject {
    
    NSString* htmlString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    NSData *htmlData = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
    TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:htmlData];
    
    return xpathParser;
}

+ (NSString *)idConvertToStringForHTML:(id)responseObject {
    
    NSString* htmlString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
    
    return htmlString;
}


//RGB convert to UIColor
+ (UIColor *)rgbConvertToUIColorByR:(int)rValue withG:(int)gValue withB:(int)bValue {
    UIColor *color = [UIColor colorWithRed:(float)rValue/255.0f green:(float)gValue/255.0f blue:(float)bValue/255.0f alpha:1];
    return color;
}

@end

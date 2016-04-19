//
//  CALayer+UIColor.m
//  Cnblogs
//
//  Created by lesiney on 16/4/4.
//  Copyright © 2016年 LongHairPig. All rights reserved.
//

#import "CALayer+UIColor.h"

@implementation CALayer (UIColor)

- (void)setBorderUIColor:(UIColor*)color {
    self.borderColor = color.CGColor;
}

- (UIColor*)borderUIColor {
    return [UIColor colorWithCGColor:self.borderColor];
}

@end

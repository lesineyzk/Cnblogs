//
//  UIViewController+Base.m
//  Cnblogs
//
//  Created by lesiney on 16/4/21.
//  Copyright © 2016年 LongHairPig. All rights reserved.
//

#import "UIViewController+Base.h"

@implementation UIViewController (Base)

//消除警告
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"

- (void)viewDidLoad {
    
    //获取类名
    NSLog(@"Current ViewController Type is: %@",[NSString stringWithUTF8String:object_getClassName(self)]);
    
}

#pragma clang diagnostic pop

@end

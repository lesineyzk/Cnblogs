//
//  BlogBodyViewController.h
//  Cnblogs
//
//  Created by lesiney on 16/4/9.
//  Copyright © 2016年 LongHairPig. All rights reserved.
//

#import "BlogAdapter.h"
#import "NewsAdapter.h"
#import "Enum.h"
#import <UIKit/UIKit.h>



@interface BlogBodyViewController : UIViewController

@property (nonatomic,strong) NSString *blogId;

@property (nonatomic,assign) WebViewDisplayType contentType;

@property (nonatomic,strong) NSString *blogTitle;

@end

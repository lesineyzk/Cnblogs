//
//  BlogsTableViewController.h
//  Cnblogs
//
//  Created by lesiney on 16/3/20.
//  Copyright © 2016年 LongHairPig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Enum.h"

@interface FristPageTableViewController : UITableViewController

@property (nonatomic, copy) void (^gotoBlogBodyViewController)(NSString *blogId, NSString *blogTitle, WebViewDisplayType displayType);

@end

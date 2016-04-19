//
//  ImportantRecommandTableViewCell.h
//  Cnblogs
//
//  Created by lesiney on 16/3/31.
//  Copyright © 2016年 LongHairPig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImportantRecommandBlog.h"

@interface ImportantRecommandTableViewCell : UITableViewCell

@property (strong,nonatomic) NSString *recommandId;

- (void)setViewData:(ImportantRecommandBlog *)importantRecommandBlog;

@end

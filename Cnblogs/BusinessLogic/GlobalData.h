//
//  GlobalData.h
//  Cnblogs
//
//  Created by lesiney on 16/3/30.
//  Copyright © 2016年 LongHairPig. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalData : NSObject

+ (NSMutableArray *)getImportentRecommandArray;
+ (void)setImportRecommandArray:(NSMutableArray *) _importantRecommandArray;

@end

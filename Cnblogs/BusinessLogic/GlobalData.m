//
//  GlobalData.m
//  Cnblogs
//
//  Created by lesiney on 16/3/30.
//  Copyright © 2016年 LongHairPig. All rights reserved.
//

#import "GlobalData.h"

static NSMutableArray * importantRecommandArray;

@implementation GlobalData

+ (NSMutableArray *)getImportentRecommandArray{
    if (!importantRecommandArray) {
        importantRecommandArray = [[NSMutableArray alloc] init];
    }
    return importantRecommandArray;
}

+ (void)setImportRecommandArray:(NSMutableArray *) _importantRecommandArray{
    
    importantRecommandArray = _importantRecommandArray;
}

@end

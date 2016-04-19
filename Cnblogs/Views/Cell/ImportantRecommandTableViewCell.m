//
//  ImportantRecommandTableViewCell.m
//  Cnblogs
//
//  Created by lesiney on 16/3/31.
//  Copyright © 2016年 LongHairPig. All rights reserved.
//

#import "ImportantRecommandTableViewCell.h"
#import "ImportantRecommandBlog.h"
#import "View+MASAdditions.h"
#import "GlobalCommonData.h"

@interface ImportantRecommandTableViewCell()

@property (strong,nonatomic) UILabel *recommandBlogTitleLable;

@end


@implementation ImportantRecommandTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.backgroundColor = [UIColor whiteColor];
    self.accessoryType = UITableViewCellAccessoryNone;
    [self layoutSubviews];
    
    return self;
}

- (void)layoutSubviews{
    WS(weakSelfVar);
    
    UIView *myView = [[UIView alloc] init];
    
    if (!self.recommandBlogTitleLable) {
        self.recommandBlogTitleLable  = [[UILabel alloc] init];
        self.recommandBlogTitleLable.font = [UIFont systemFontOfSize:14];
        self.recommandBlogTitleLable.backgroundColor = [UIColor clearColor];
        self.recommandBlogTitleLable.textColor = [UIColor whiteColor];
        [myView addSubview:self.recommandBlogTitleLable];
        
        UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"button_arrow_right@2x.png"]];
        img.contentMode = UIViewContentModeScaleAspectFit;
        [myView  addSubview:img];
        
        [self.recommandBlogTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(myView).insets(UIEdgeInsetsMake(2, 5, 2, 45));
        }];
        [img mas_makeConstraints:^(MASConstraintMaker *make){
            make.top.bottom.right.equalTo(myView).insets(UIEdgeInsetsMake(5, 0, 5, 15));
            make.width.mas_equalTo(@20);
        }];
        
        myView.backgroundColor = [GlobalCommonData getThemeBlue];
        [self.contentView addSubview:myView];
        
        [myView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelfVar.contentView).insets(UIEdgeInsetsMake(4, 5, 4, 5));
        }];

    }
}

- (void)setViewData:(ImportantRecommandBlog *)importantRecommandBlog{
    self.recommandBlogTitleLable.text = importantRecommandBlog.content;
    self.recommandId = importantRecommandBlog.blogId;
}
















@end

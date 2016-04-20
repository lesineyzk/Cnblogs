//
//  BlogsContentTableViewCell.m
//  Cnblogs
//
//  Created by lesiney on 16/3/20.
//  Copyright © 2016年 LongHairPig. All rights reserved.
//

#import "BlogsContentTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface BlogsContentTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *blogTtileLable;
@property (weak, nonatomic) IBOutlet UIImageView *blogHeadLogoImg;
@property (weak, nonatomic) IBOutlet UILabel *recommandCountLable;
@property (weak, nonatomic) IBOutlet UILabel *blogContentLable;
@property (weak, nonatomic) IBOutlet UILabel *dateLable;
@property (weak, nonatomic) IBOutlet UIButton *authorButton;
@property (weak, nonatomic) IBOutlet UIImageView *nextImg;

@end

@implementation BlogsContentTableViewCell

- (void)setInfoViewData:(id) infos {
    
    if ([infos isKindOfClass:[BlogAndNewsInfo class]]) {
        [self setBlogAndNewsViewData:(BlogAndNewsInfo *)infos];
    }
    
    if ([infos isMemberOfClass:[NewsInfo class]]) {
        [self setNewsViewData:(NewsInfo *)infos];
    } else if ([infos isMemberOfClass:[BlogInfo class]]) {
        [self setBlogViewData:(BlogInfo *)infos];
    }
}

- (void)setBlogViewData:(BlogInfo *)blogInfo {
    
    [self setBlogHeadLogoImgByURL:blogInfo.blogAuthorLogoHttpAddress];
    
    [self.authorButton setTitle:blogInfo.blogAuthor forState:UIControlStateNormal];
}

- (void)setNewsViewData:(NewsInfo *)newsInfo {
    
    [self setBlogHeadLogoImgByURL:newsInfo.newsTopicIcon];
    
    [self.authorButton setTitle:newsInfo.newsSource forState:UIControlStateNormal];
}

- (void)setBlogHeadLogoImgByURL:(NSString *)url {
    
    [self.blogHeadLogoImg sd_setImageWithURL:[NSURL URLWithString:url]
                      placeholderImage:nil];
    
}

- (void)setBlogAndNewsViewData:(BlogAndNewsInfo *) blogAndNewsInfo {
    
    self.blogTtileLable.text = blogAndNewsInfo.blogTitle;
    self.recommandCountLable.text = blogAndNewsInfo.recommandCount;
    self.blogContentLable.text = blogAndNewsInfo.blogContent;
    
    self.dateLable.text = [NSString stringWithFormat:@"%@ %@ %@",blogAndNewsInfo.blogDate,blogAndNewsInfo.commentCount,blogAndNewsInfo.readCount];
    self.nextImg.image = [UIImage imageNamed:@"button_arrow_right@2x.png"];
    
    self.blogHeadLogoImg.layer.masksToBounds = YES;
    self.blogHeadLogoImg.layer.cornerRadius = 25.0f;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

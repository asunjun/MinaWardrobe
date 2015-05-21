//
//  CommunityTableViewCell.m
//  MinaWardrobe
//
//  Created by 米娜 上海文星广告传媒有限公司 on 15/5/19.
//  Copyright (c) 2015年 wenxing. All rights reserved.
//

#import "CommunityTableViewCell.h"
#import "UIViewExt.h"
@implementation CommunityTableViewCell

- (void)awakeFromNib {
    self.title=[[UILabel alloc]initWithFrame:CGRectMake(0, 3, 320, 60)];
    self.title.numberOfLines=0;
    self.title.lineBreakMode=NSLineBreakByCharWrapping;
    
    self.title.backgroundColor=[UIColor clearColor];
    [self addSubview:self.title];
    
    self.img1=[[UIImageView alloc]initWithFrame:CGRectZero];
    [self addSubview:self.img1];
    
    
    
    
    // Initialization code
}

-(void)layoutSubviews{
    CGFloat height = [self heightContentBackgroundView:self.title.text];
    self.title.frame=CGRectMake(0, 5, 320, height);
    if(self.img1.image)
        self.img1.frame=CGRectMake(5, self.title.bottom, 100, 100);
    
    
}

- (CGFloat)heightContentBackgroundView:(NSString *)content
{
    CGFloat height = [self heigtOfLabelForFromString:content fontSizeandLabelWidth:290 andFontSize:16.0];
    if (height<30)
    {
        height = 30;
    }
    height += 10;
    
    return height;
}

- (CGFloat)heigtOfLabelForFromString:(NSString *)text fontSizeandLabelWidth:(CGFloat)width andFontSize:(CGFloat)fontSize
{
    
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width, 20000)];
    return size.height;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

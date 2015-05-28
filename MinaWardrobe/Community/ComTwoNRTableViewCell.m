//
//  ComTwoNRTableViewCell.m
//  MinaWardrobe
//
//  Created by 米娜 上海文星广告传媒有限公司 on 15/5/26.
//  Copyright (c) 2015年 wenxing. All rights reserved.
//

#import "ComTwoNRTableViewCell.h"

@implementation ComTwoNRTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)configCellByTradeModel:(ComNRModel  *)trade{
    self.img1=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 300, 400)];
     self.img2=[[UIImageView alloc]initWithFrame:CGRectMake(10, 420, 300, 400)];
     self.img3=[[UIImageView alloc]initWithFrame:CGRectMake(10, 830, 300, 400)];
    [self addSubview:self.img1];
    [self addSubview:self.img2];
    [self addSubview:self.img3];
    
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

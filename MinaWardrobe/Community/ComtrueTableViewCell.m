//
//  ComtrueTableViewCell.m
//  MinaWardrobe
//
//  Created by 米娜 上海文星广告传媒有限公司 on 15/5/28.
//  Copyright (c) 2015年 wenxing. All rights reserved.
//

#import "ComtrueTableViewCell.h"
#import "UIViewExt.h"
@implementation ComtrueTableViewCell

- (void)awakeFromNib {
    
    // Initialization code
}
-(void)configCellByTradeModel:(NSString *)name and:(NSInteger )loushu and:(NSString *)imageurl and:(NSString *)time and:(NSString *)message{
    self.lab1=[[UILabel alloc]initWithFrame:CGRectZero];
    self.lab1.text=name;
    
    
    [self addSubview:self.lab1];
    self.lab2=[[UILabel alloc]initWithFrame:CGRectZero];
    self.lab2.text=[NSString stringWithFormat:@"%ld楼",loushu];
    
    
    [self addSubview:self.lab2];
    
    
    self.lab3=[[UILabel alloc]initWithFrame:CGRectZero];
    self.lab3.text=message;
     [self addSubview:self.lab3];
    
    self.img1=[[UIImageView alloc]initWithFrame:CGRectZero];
    [self addSubview:self.img1];
    
    
    
}
-(void)layoutSubviews{
    self.lab1.frame=CGRectMake(15,10, 60, 30);
    self.lab2.frame=CGRectMake(WIDTH-30, 10, 30, 30);
    CGFloat height=[self.lab3.text boundingRectWithSize:CGSizeMake(WIDTH, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} context:nil].size.height;
    
    self.lab3.frame=CGRectMake(15, 35, WIDTH-20, height);
    self.img1.frame=CGRectMake(0, 0, 30, 30);
    
    
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

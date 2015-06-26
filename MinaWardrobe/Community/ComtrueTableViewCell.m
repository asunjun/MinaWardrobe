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
-(void)configCellByTradeModel:(NSString *)name and:(NSInteger )loushu and:(NSString *)imageurl and:(NSString *)time and:(NSString *)message and:(NSString *)height{
    
#warning 添加
    
    
    
    self.imgheight=height;
    
    self.lab1.frame=CGRectZero;
      self.lab2.frame=CGRectZero;
      self.lab3.frame=CGRectZero;
      self.lab4.frame=CGRectZero;
      self.img1.frame=CGRectZero;
    self.lab6.frame=CGRectZero;
    self.lab6.backgroundColor=lightgray;
    
    
    self.lab1.text=name;
    
 
 
    self.lab2.text=[NSString stringWithFormat:@"%ld楼",loushu+1];
    self.lab2.textAlignment=NSTextAlignmentCenter;
    
   
  
    self.lab3.text=message;
    self.lab3.numberOfLines=0;
    self.lab3.lineBreakMode=NSLineBreakByCharWrapping;
    
    
    
}
-(void)layoutSubviews{
    self.lab1.frame=CGRectMake(15,10, 60, 30);
    self.lab2.frame=CGRectMake(WIDTH-100, 10, 100, 30);
    CGFloat height=[self.lab3.text boundingRectWithSize:CGSizeMake(WIDTH, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} context:nil].size.height;
    
    self.lab3.frame=CGRectMake(15, 35, WIDTH-20, height);
    self.img1.frame=CGRectMake(10, 37+height, WIDTH-20, [self.imgheight intValue]);
    self.lab6.frame=CGRectMake(0, 35+height+[self.imgheight intValue]+8, WIDTH,6);
    
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

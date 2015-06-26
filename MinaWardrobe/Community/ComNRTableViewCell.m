//
//  ComNRTableViewCell.m
//  MinaWardrobe
//
//  Created by 米娜 上海文星广告传媒有限公司 on 15/5/25.
//  Copyright (c) 2015年 wenxing. All rights reserved.
//

#import "ComNRTableViewCell.h"
#import "ComNRModel.h"
#import "UIViewExt.h"
@implementation ComNRTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configCellByTradeModel:(NSString *)titile and:(NSString *)message{
    
    self.lab1.frame=CGRectZero;
     self.lab2.frame=CGRectZero;
     self.lab3.frame=CGRectZero;
    
   
    NSString *st2=@"正文：";
      // self.lab1=[[UILabel alloc]initWithFrame:CGRectZero];
       self.lab1.font=[UIFont boldSystemFontOfSize:15];
    self.lab1.text=[NSString stringWithFormat:@"标题:%@",titile];
    
    self.lab1.numberOfLines=2;
     self.lab2.text=st2;
    self.lab3.text=message;
    
      self.lab3.numberOfLines=0;
     self.lab3.font=[UIFont boldSystemFontOfSize:15];

    
}
-(void)layoutSubviews{
    NSLog(@"%@",self.lab1.text);
    
    
    CGFloat height=[self.lab1.text boundingRectWithSize:CGSizeMake(WIDTH, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} context:nil].size.height;
    
    NSLog(@"%f",height);
    
    self.lab1.frame=CGRectMake(8, 0, WIDTH-18, height);
    self.lab2.frame=CGRectMake(8, height+5, WIDTH-18, height);
   CGFloat height1 = [self.lab3.text boundingRectWithSize:CGSizeMake(WIDTH, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} context:nil].size.height;

    self.lab3.frame=CGRectMake(8, height+35, WIDTH-18, height1);

    
}

//- (CGFloat)heightContentBackgroundView:(NSString *)content
//{
//    CGFloat height = [self heigtOfLabelForFromString:content fontSizeandLabelWidth:290 andFontSize:15.0];
//
//    return height;
//}
//
//- (CGFloat)heigtOfLabelForFromString:(NSString *)text fontSizeandLabelWidth:(CGFloat)width andFontSize:(CGFloat)fontSize
//{
//    
//    
//    
//    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width, 20000)];
//    return size.height;
//}
//





@end

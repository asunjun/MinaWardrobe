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
- (void)configCellByTradeModel:(ComNRModel *)trade{
    NSString *st1=@"标题：啊锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕";
    NSString *st2=@"正文：";
    NSString *st3=@"底的策略飞机饿哦喷雾剂佛锕陪我减肥我发觉锕我非常呢无法内侧为 i 哦腐女次额外付出哪哦我能否次饿哦无法内侧晚饭吃呢哦我吃饭呢哦我 i 吃饭呢哦 win 服从额外 i 付出";
    self.lab1=[[UILabel alloc]initWithFrame:CGRectZero];
    self.lab1.text=st1;
    self.lab1.font=[UIFont boldSystemFontOfSize:15];
    
    self.lab1.numberOfLines=2;
    self.lab2=[[UILabel alloc]initWithFrame:CGRectZero];
    self.lab3=[[UILabel alloc]initWithFrame:CGRectZero];
    self.lab4=[[UILabel alloc]initWithFrame:CGRectZero];
    
    self.lab2.text=st2;
    
    self.lab3.text=st3;
    self.lab3.numberOfLines=0;
     self.lab3.font=[UIFont boldSystemFontOfSize:15];
    [self addSubview:self.lab1];
    [self addSubview:self.lab2];
    [self addSubview:self.lab3];
    [self addSubview:self.lab4];

    
}
-(void)layoutSubviews{
    CGFloat height = [self heightContentBackgroundView:self.lab1.text];
    
    NSLog(@"%f",height);
    
    self.lab1.frame=CGRectMake(8, 0, WIDTH-18, height);
    self.lab2.frame=CGRectMake(8, height+5, WIDTH-18, height);
   CGFloat height1 = [self heightContentBackgroundView:self.lab3.text];

    self.lab3.frame=CGRectMake(8, height+35, WIDTH-18, height1);

    
}

- (CGFloat)heightContentBackgroundView:(NSString *)content
{
    CGFloat height = [self heigtOfLabelForFromString:content fontSizeandLabelWidth:290 andFontSize:15.0];

    return height;
}

- (CGFloat)heigtOfLabelForFromString:(NSString *)text fontSizeandLabelWidth:(CGFloat)width andFontSize:(CGFloat)fontSize
{
    
    
    
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width, 20000)];
    return size.height;
}






@end

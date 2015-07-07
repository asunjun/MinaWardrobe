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
#import "ComQuestionNRModel.h"
@implementation ComNRTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configCellByTradeModel:(ComQuestionNRModel *)trane{
    
    self.lab1.frame=CGRectZero;
     self.lab2.frame=CGRectZero;
     self.lab3.frame=CGRectZero;
    self.lab4.frame=CGRectZero;
    self.img1.frame=CGRectZero;
    
   
    
      // self.lab1=[[UILabel alloc]initWithFrame:CGRectZero];
       //self.lab1.font=[UIFont boldSystemFontOfSize:16];
    self.lab1.text=[NSString stringWithFormat:@"%@",trane.title];
    [self.lab1 setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
    self.lab1.numberOfLines=0;
    
    self.lab3.text=trane.message;
    
      self.lab3.numberOfLines=0;
     //self.lab3.font=[UIFont boldSystemFontOfSize:14];

    [self.lab3 setFont:[UIFont fontWithName:@"Helvetica" size:14]];
    
    self.lab2.text=trane.plname;
    NSTimeInterval time1 = [trane.time doubleValue];
    
    NSTimeInterval _interval=time1;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    self.lab4.text=[self compareCurrentTime:date];
    self.lab4.font=[UIFont boldSystemFontOfSize:10];
    self.lab4.textColor=kUIColorFromRGB(0xb6b6b8);
    [self.img1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://sq.mina.cn/uploads/avatar/%@",trane.img]]];
    
    self.lab2.font=[UIFont boldSystemFontOfSize:12];
    self.lab2.textColor=kUIColorFromRGB(0x747475);
}
-(void)layoutSubviews{
    NSLog(@"%@",self.lab1.text);
    
    self.img1.frame=CGRectMake(8, 5, 30, 30);
    self.lab2.frame=CGRectMake(45, 5, 80, 15);
    self.lab4.frame=CGRectMake(45, 20, 80, 15);
    
    CGFloat height=[self.lab1.text boundingRectWithSize:CGSizeMake(WIDTH-16, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16]} context:nil].size.height;
    
    NSLog(@"%f",height);
    
    self.lab1.frame=CGRectMake(8, 37, WIDTH-18, height);
   // self.lab2.frame=CGRectMake(8, height+5, WIDTH-18, height);
   CGFloat height1 = [self.lab3.text boundingRectWithSize:CGSizeMake(WIDTH-16, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]} context:nil].size.height;

    self.lab3.frame=CGRectMake(8, height+35, WIDTH-18, height1);

    
}

//时间的调用

-(NSString *) compareCurrentTime:(NSDate*) compareDate
{
    NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60)
    {
        result = [NSString stringWithFormat:@"刚刚"];
        
    }
    else if((temp = timeInterval/60) <60)
    {
        result = [NSString stringWithFormat:@"%ld分前",temp];
        
    }
    else if((temp = temp/60) <24)
    {
        result = [NSString stringWithFormat:@"%ld小时前",temp];
        
    }
    else if((temp = temp/24) <3)
    {
        result = [NSString stringWithFormat:@"%ld天前",temp];
        
    }
    else
    {
        NSDateFormatter *datefor = [[NSDateFormatter alloc]init];
        [datefor setDateFormat:@"MM/dd HH:mm"];
        NSString *timeString = [datefor stringFromDate:compareDate];
        //        //cell.timeLabel.text = [timeString description];
        // NSLog(@"--ttt-%@",[timeString description]);
        
        result = [NSString stringWithFormat:@"%@",[timeString description]];
        
    }
    
    return  result;
    
}




@end

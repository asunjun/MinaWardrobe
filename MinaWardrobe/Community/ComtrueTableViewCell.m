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
    
    NSTimeInterval time1 = [time doubleValue];
    
    NSTimeInterval _interval=time1;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    self.lab4.text=[self compareCurrentTime:date];
    self.lab4.font=[UIFont boldSystemFontOfSize:12];
    self.lab4.textColor=kUIColorFromRGB(0xb6b6b8);

    NSLog(@"%@",[self compareCurrentTime:date]);
    
    
    self.imgheight=height;
    
    self.lab1.frame=CGRectZero;
      self.lab2.frame=CGRectZero;
      self.lab3.frame=CGRectZero;
      self.lab4.frame=CGRectZero;
      self.img1.frame=CGRectZero;
    self.lab6.frame=CGRectZero;
    self.lab6.backgroundColor=lightgray;
    self.touxiang.frame=CGRectZero;
    
    self.lab1.text=name;
    self.lab1.font=[UIFont boldSystemFontOfSize:12];
    
    //调用
    self.img1.layer.masksToBounds = YES;
    self.img1.layer.cornerRadius=3;
    self.lab1.textColor=kUIColorFromRGB(0x747475);
 
 
    self.lab2.text=[NSString stringWithFormat:@"第%ld楼",loushu+1];
    self.lab2.textAlignment=NSTextAlignmentCenter;
    self.lab2.font=[UIFont boldSystemFontOfSize:12];
   
  
    self.lab3.text=message;
    self.lab3.numberOfLines=0;
    self.lab3.lineBreakMode=NSLineBreakByCharWrapping;
    
    
    
}
-(void)layoutSubviews{
    
     self.touxiang.frame=CGRectMake(8,10, 30, 30);//头像
    self.lab1.frame=CGRectMake(45,10, 60, 15);//名字
   
   
    CGFloat height=[self.lab3.text boundingRectWithSize:CGSizeMake(WIDTH-50, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} context:nil].size.height;
    
    self.lab3.frame=CGRectMake(40, 25, WIDTH-50, height+3);
    self.img1.frame=CGRectMake(10, 30+height, WIDTH-20, [self.imgheight intValue]);
    self.lab6.frame=CGRectMake(0, 56+height+[self.imgheight intValue], WIDTH,1);
    
    self.lab4.frame=CGRectMake(45,35+height+[self.imgheight intValue], 80, 15);//时间
    
    UIFont *font = [UIFont fontWithName:@"Arial" size:12];
    CGSize size = CGSizeMake(WIDTH,2000);
    CGSize labelsize = [self.lab2.text sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
   
    
    
    self.lab2.frame=CGRectMake(WIDTH-100, 35+height+[self.imgheight intValue], labelsize.width, 15);
    
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

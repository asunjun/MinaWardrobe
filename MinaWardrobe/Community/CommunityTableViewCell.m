//
//  CommunityTableViewCell.m
//  MinaWardrobe
//
//  Created by 米娜 上海文星广告传媒有限公司 on 15/5/19.
//  Copyright (c) 2015年 wenxing. All rights reserved.
//

#import "CommunityTableViewCell.h"
#import "UIViewExt.h"
#import "SQmainlist.h"
#import "UIImageView+WebCache.h"
@implementation CommunityTableViewCell
@synthesize ishidder,view1;

- (void)awakeFromNib {
    //[self setBackgroundColor:[UIColor lightGrayColor]];
   
    
    
    
    // Initialization code
}

- (void)configCellByTradeModel:(SQmainlist*)trade
{
    ishidder=YES;
    
    [self.contentView setBackgroundColor:lightgray];
    
  // view1=[[UIView alloc]initWithFrame:CGRectZero];
    view1.frame=CGRectZero;
    
    view1.layer.cornerRadius=5;
    
    [view1 setBackgroundColor:[UIColor whiteColor]];
    
  
    
    if (trade.imageurl==nil) {
        NSLog(@"sdwedededeede");
        ishidder=NO;
        
    }
    
    
      self.img1.frame=CGRectZero;
     self.img2.frame=CGRectZero;
    
    self.img3.frame=CGRectZero;

  self.img1.layer.masksToBounds = YES;
    self.img1.layer.cornerRadius=3;
    self.img2.layer.masksToBounds = YES;
    self.img2.layer.cornerRadius=3;
    self.img3.layer.masksToBounds = YES;
    self.img3.layer.cornerRadius=3;

    self.title.frame=CGRectZero;
    self.title.numberOfLines=2;
    self.title.lineBreakMode=NSLineBreakByCharWrapping;
    self.title.text=trade.fabutitle;
   
    self.title.backgroundColor=[UIColor clearColor];
    [view1 addSubview:self.title];

    self.img4.frame=CGRectZero;

    
     self.img4.image=[UIImage imageNamed:@"789.jpg"];
    
    self.name.frame=CGRectZero;
    
    
    self.time.frame=CGRectZero;
    
  
    
    self.pinglun.frame=CGRectZero;
    
    self.shouchangshu.frame=CGRectZero;
    
    self.pinglunshu.frame=CGRectZero;
    
   self.name.text=trade.fabuname;
    self.name.font=[UIFont boldSystemFontOfSize:12];
    
    //调用
    
   
    NSTimeInterval time = [trade.fabutime doubleValue];
    
       NSTimeInterval _interval=time;
       NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
     self.time.text=[self compareCurrentTime:date];
    
    NSLog(@"%@",[self compareCurrentTime:date]);
    
    
     self.time.font=[UIFont boldSystemFontOfSize:10];
    self.time.textColor=lightgray;
    
  
    
}




-(void)layoutSubviews{
    CGFloat height = [self heightContentBackgroundView:self.title.text];
    self.title.frame=CGRectMake(8,0, WIDTH-18, height);

    if (ishidder==YES) {
        self.img1.frame=CGRectMake(8, self.title.bottom, 80, 80);
        self.img2.frame=CGRectMake(100, self.title.bottom, 80, 80);
        self.img3.frame=CGRectMake(192, self.title.bottom, 80, 80);
        
        self.img4.frame=CGRectMake(8, self.title.bottom+85, 20, 20);
        self.name.frame=CGRectMake(33, self.title.bottom+85, 100, 10);
        self.time.frame=CGRectMake(33, self.title.bottom+95, 100, 10);
        self.view1.frame=CGRectMake(8, 8, WIDTH-16,height+115-8);
        
    }else{
        self.img4.frame=CGRectMake(8, self.title.bottom, 20, 20);
        self.name.frame=CGRectMake(33, self.title.bottom, 100, 10);
        self.time.frame=CGRectMake(33, self.title.bottom+10, 100, 10);
        self.view1.frame=CGRectMake(8, 8, WIDTH-16,height+28);
        
        
        
    }
    
   
    
             
}
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
        NSLog(@"--ttt-%@",[timeString description]);
        
        result = [NSString stringWithFormat:@"%@",[timeString description]];
        
    }
    
    return  result;
    
}




- (CGFloat)heightContentBackgroundView:(NSString *)content
{
    CGFloat height = [self heigtOfLabelForFromString:content fontSizeandLabelWidth:WIDTH andFontSize:30.0];
    if (height<30)
    {
        height = 30;
    }else {
    height =60;
    }
    
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

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
    
  
    
    if (trade.imageurl.count==0) {
               ishidder=NO;
        
    }
    self.xiantiao.frame=CGRectZero;
     [self.xiantiao setBackgroundColor:lightgray];
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
    self.title.lineBreakMode=NSLineBreakByTruncatingTail;
    self.title.text=trade.fabutitle;
   [self.title setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
    //self.title.backgroundColor=[UIColor clearColor];
    self.title.textColor=kUIColorFromRGB(0x000000);
    [view1 addSubview:self.title];

    self.img4.frame=CGRectZero;

    self.img4.layer.masksToBounds = YES;
    self.img4.layer.cornerRadius=3;
    [self.img4 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://sq.mina.cn/uploads/avatar/%@",trade.fabutouxiang]]];
    // self.img4.image=[UIImage imageNamed:@"789.jpg"];
    
    self.name.frame=CGRectZero;
    
    
    self.time.frame=CGRectZero;
    
     self.message.frame=CGRectZero;
    self.message.text=trade.message;
    // self.message.font=[UIFont boldSystemFontOfSize:12];
    self.message.textColor=kUIColorFromRGB(0x2c2c2c);
    self.message.numberOfLines=2;
     [self.message setFont:[UIFont fontWithName:@"Helvetica" size:12]];
    self.message.lineBreakMode=NSLineBreakByTruncatingTail;

    self.pinglun.frame=CGRectZero;
    
    self.shouchangshu.frame=CGRectZero;
    self.shouchang.frame=CGRectZero;
    self.pinglun.frame=CGRectZero;
    
    self.shouchang.image=[UIImage imageNamed:@"阅读(zi).png"];
    self.pinglun.image=[UIImage imageNamed:@"阅读评论(zi).png"];
    
    self.pinglunshu.frame=CGRectZero;
    NSLog(@"%@,%@",trade.shouchanshu,trade.fabupinglun);
    
    NSLog(@"%@,%@",trade.shouchanshu,trade.fabupinglun);
    self.shouchangshu.text=[NSString stringWithFormat:@"%@",trade.shouchanshu];
    
    self.pinglunshu.text=[NSString stringWithFormat:@"%@",trade.fabupinglun];
    self.shouchangshu.textColor=kUIColorFromRGB(0x747475);
    self.pinglunshu.textColor=kUIColorFromRGB(0x747475);
    
    self.shouchangshu.font=[UIFont boldSystemFontOfSize:12];
    self.pinglunshu.font=[UIFont boldSystemFontOfSize:12];
    
   self.name.text=trade.fabuname;
    self.name.font=[UIFont boldSystemFontOfSize:12];
    
    //调用
    
    self.name.textColor=kUIColorFromRGB(0x747475);
    NSTimeInterval time = [trade.fabutime doubleValue];
    
       NSTimeInterval _interval=time;
       NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
     self.time.text=[self compareCurrentTime:date];
    
    NSLog(@"%@",[self compareCurrentTime:date]);
    
    
     self.time.font=[UIFont boldSystemFontOfSize:10];
    self.time.textColor=kUIColorFromRGB(0xb6b6b8);
    
  
    
}




-(void)layoutSubviews{
   // CGFloat height = [self heightContentBackgroundView:self.title.text];
     CGFloat height = [self.title.text boundingRectWithSize:CGSizeMake(WIDTH-28, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16]} context:nil].size.height;
   

    
    CGFloat height1 = [self.message.text boundingRectWithSize:CGSizeMake(WIDTH-28, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12]} context:nil].size.height;

    

    
    NSLog(@"%f",height);
    NSLog(@"%f",height1);
    
    
    if (height>20) {
        height=42;
        
    }else{
        height=20;
        
    }
    if (height1>20) {
       // height+=20;
        height1=30;
        
    }
     self.title.frame=CGRectMake(8,0, WIDTH-40, height);
    self.message.frame=CGRectMake(8, height+1, WIDTH-40, height1);
    
         if (ishidder==YES) {
        self.img1.frame=CGRectMake(8, height+height1+12, 80, 80);
        self.img2.frame=CGRectMake(100, height+height1+12, 80, 80);
        self.img3.frame=CGRectMake(192, height+height1+12, 80, 80);
        
        self.img4.frame=CGRectMake(8, height+90+height1+16, 20, 20);
        self.name.frame=CGRectMake(33, height+90+height1+16, 100, 10);
        self.time.frame=CGRectMake(33, height+101+height1+16, 100, 10);
        self.xiantiao.frame=CGRectMake(8, height+87+height1+12, WIDTH-32, 1);
        self.shouchang.frame=CGRectMake(WIDTH-120, height+90+height1+16, 20, 20);
        self.pinglun.frame=CGRectMake(WIDTH-70, height+90+height1+16, 20, 20);
        self.shouchangshu.frame=CGRectMake(WIDTH-95, height+90+height1+16, 30, 20);
        self.pinglunshu.frame=CGRectMake(WIDTH-50, height+90+height1+16, 30, 20);
        self.view1.frame=CGRectMake(8, 8, WIDTH-16,height+80+height1+55);
             
             NSLog(@"%f",height+80+height1+45);
             
        
    }else{
        self.img4.frame=CGRectMake(8, height+height1+26, 20, 20);
        self.pinglun.frame=CGRectMake(WIDTH-70,  height+height1+26, 20, 20);
        self.shouchangshu.frame=CGRectMake(WIDTH-95, height+height1+26, 30, 20);
        self.pinglunshu.frame=CGRectMake(WIDTH-50, height+height1+26, 30, 20);

        self.name.frame=CGRectMake(33, height+height1+26, 100, 10);
        self.time.frame=CGRectMake(33, height+13+height1+26, 100, 10);
        self.view1.frame=CGRectMake(8, 8, WIDTH-16,height+43+height1+12);
        self.xiantiao.frame=CGRectMake(8, height+height1+18, WIDTH-32, 1);
        self.shouchang.frame=CGRectMake(WIDTH-120,  height+height1+26, 20, 20);
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

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
    
   view1=[[UIView alloc]initWithFrame:CGRectZero];
    
    view1.layer.cornerRadius=5;
    
    [view1 setBackgroundColor:[UIColor whiteColor]];
    
  
    
    if (trade.imageurl==nil) {
        NSLog(@"sdwedededeede");
        ishidder=NO;
        
    }
    
    
    for (int i=0; i<trade.imageurl.count; i++) {
        NSString *imageurls=[trade.imageurl objectAtIndex:i];
      
        
        if (i==0) {
            self.img1=[[UIImageView alloc]initWithFrame:CGRectZero];
            [self.img1 sd_setImageWithURL:[NSURL URLWithString:imageurls]];
            
            
            
        }
        if (i==1) {
            self.img2=[[UIImageView alloc]initWithFrame:CGRectZero];
             [self.img2 sd_setImageWithURL:[NSURL URLWithString:imageurls]];
            
        }
        if (i==2) {
            self.img3=[[UIImageView alloc]initWithFrame:CGRectZero];
             [self.img3 sd_setImageWithURL:[NSURL URLWithString:imageurls]];

            
        }
        
        
    }
    
    [self.contentView addSubview:view1];

    self.title=[[UILabel alloc]initWithFrame:CGRectMake(8, 5, WIDTH-16, 60)];
    self.title.numberOfLines=2;
    self.title.lineBreakMode=NSLineBreakByCharWrapping;
    self.title.text=trade.fabutitle;
   
    self.title.backgroundColor=[UIColor clearColor];
    [view1 addSubview:self.title];

    self.img4=[[UIImageView alloc]initWithFrame:CGRectZero];

    
     self.img4.image=[UIImage imageNamed:@"789.jpg"];
    
    self.name=[[UILabel alloc]initWithFrame:CGRectZero];
    
    self.time=[[UILabel alloc]initWithFrame:CGRectZero];
    
    self.shoucang=[[UILabel alloc]initWithFrame:CGRectZero];
    
    self.pinglun=[[UILabel alloc]initWithFrame:CGRectZero];
    
    self.shouchangshu=[[UILabel alloc]initWithFrame:CGRectZero];
    
    self.pinglunshu=[[UILabel alloc]initWithFrame:CGRectZero];
    
   self.name.text=trade.fabuname;
    self.name.font=[UIFont boldSystemFontOfSize:12];
    
  //  self.time.text=trade.fabutime;
   // NSLog(@"%f",trade.fabutime);
    double unixTimeStamp = [trade.fabutime doubleValue];
    NSTimeInterval _interval=unixTimeStamp;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSDateFormatter *_formatter=[[NSDateFormatter alloc]init];
    [_formatter setLocale:[NSLocale currentLocale]];
    //[_formatter setDateFormat:@"dd.MM.yyyy"];
    [_formatter setDateFormat:@"yyyy.MM.dd"];
    NSString *_date=[_formatter stringFromDate:date];
    
    NSLog(@"%@",_date);
    self.time.text=_date;
     self.time.font=[UIFont boldSystemFontOfSize:10];
    self.time.textColor=lightgray;
    
    [view1 addSubview:self.img1];
    [view1 addSubview:self.img2];
    [view1 addSubview:self.img3];
    [view1 addSubview:self.img4];
    [view1 addSubview:self.name];
    [view1 addSubview:self.time];
    [view1 addSubview:self.shouchangshu];
    [view1 addSubview:self.shoucang];
    [view1 addSubview:self.pinglunshu];
    [view1 addSubview:self.pinglun];
 
    
}




-(void)layoutSubviews{
    CGFloat height = [self heightContentBackgroundView:self.title.text];
    self.title.frame=CGRectMake(8, 0, WIDTH-18, height);

    if (ishidder==YES) {
        self.img1.frame=CGRectMake(8, self.title.bottom, 80, 80);
        self.img2.frame=CGRectMake(WIDTH/3-8, self.title.bottom, 80, 80);
        self.img3.frame=CGRectMake(WIDTH/3*2-16, self.title.bottom, 80, 80);
        
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

- (CGFloat)heightContentBackgroundView:(NSString *)content
{
    CGFloat height = [self heigtOfLabelForFromString:content fontSizeandLabelWidth:290 andFontSize:30.0];
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

//
//  SQmainlist.m
//  MinaWardrobe
//
//  Created by 米娜 上海文星广告传媒有限公司 on 15/5/18.
//  Copyright (c) 2015年 wenxing. All rights reserved.
//

#import "SQmainlist.h"
#import "NSDictionary+Null.h"
@implementation SQmainlist
- (id)initWithDic:(NSDictionary*)dic
{
    self = [super init];
    if (self) {
        
        self.imageurl=[[NSMutableArray alloc]init];
        
        self.category=[dic notNullobjectForKey:@"post_type"];
        if ([self.category isEqualToString:@"question"]) {
            self.fabutitle=[dic notNullobjectForKey:@"question_content"];
            NSString *detail=[dic notNullobjectForKey:@"question_detail"];
            
            if([detail rangeOfString:@"[img]"].location !=NSNotFound)//_roaldSearchText
            {
                NSArray *a1=[detail componentsSeparatedByString:@"[img]"];
                
                NSLog(@"%@",[a1 objectAtIndex:0]);
                
                self.message=[a1 objectAtIndex:0];
                
                
                
                NSLog(@"yes");
            }
            else
            {
                self.message=detail;
                
                NSLog(@"no");
            }

            NSError *error = NULL;
            
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\[img\\](.*?)\\[\\/img\\]" options:NSRegularExpressionCaseInsensitive error:&error];
            
            //匹配出N个符合的
            NSArray *a1=[regex matchesInString:detail options:0 range:NSMakeRange(0, [detail length])];
            
            if (a1) {
                for (int i=0; i<a1.count; i++) {
                    NSTextCheckingResult *result=[a1 objectAtIndex:i];
                    NSString *st1=[detail substringWithRange:[result rangeAtIndex:1]];
                    //[result rangeAtIndex:1];
                    
                    NSLog(@"%@\n",st1);
                    [self.imageurl addObject:st1];
                    
                }
           
            }
            self.shouchanshu=[dic objectForKey:@"view_count"];
            
            self.fabupinglun=[dic notNullobjectForKey:@"answer_count"];
            self.idzhi=[dic notNullobjectForKey:@"question_id"];
            self.fabutime=[dic notNullobjectForKey:@"add_time"];
            NSDictionary *dic1=[dic notNullobjectForKey:@"user_info"];
            self.fabuname=[dic1 notNullobjectForKey:@"user_name"];
            self.fabutouxiang=[dic1 notNullobjectForKey:@"avatar_file"];
        
        }else{
            
            self.fabutitle=[dic notNullobjectForKey:@"title"];
            self.idzhi=[dic notNullobjectForKey:@"id"];
            
            self.fabutime=[dic notNullobjectForKey:@"add_time"];
            NSDictionary *dic1=[dic notNullobjectForKey:@"user_info"];
            self.fabuname=[dic1 notNullobjectForKey:@"user_name"];
            self.fabutouxiang=[dic1 notNullobjectForKey:@"avatar_file"];
            self.fabupinglun=[dic notNullobjectForKey:@"comment_count"];
            self.shouchanshu=[dic notNullobjectForKey:@"votes"];
            self.imageurl=[dic notNullobjectForKey:@"images"];
            
            
            
        }
        
        
        
    }
    return self;
}

@end

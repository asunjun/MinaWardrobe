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
       self.category=[dic notNullobjectForKey:@"post_type"];
        if ([self.category isEqualToString:@"question"]) {
            self.fabutitle=[dic notNullobjectForKey:@"question_content"];
            self.idzhi=[dic notNullobjectForKey:@"question_id"];
            
            self.fabutime=[dic notNullobjectForKey:@"add_time"];
            NSDictionary *dic1=[dic notNullobjectForKey:@"user_info"];
            self.fabuname=[dic1 notNullobjectForKey:@"user_name"];
            self.fabutouxiang=[dic1 notNullobjectForKey:@"avatar_file"];
            
//            self.fabupinglun=[dic notNullobjectForKey:@"comment_count"];
//            self.shouchanshu=[dic notNullobjectForKey:@"votes"];
            self.imageurl=[dic notNullobjectForKey:@"images"];

            
            
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

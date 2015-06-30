
//
//  Comcommodel.m
//  MinaWardrobe
//
//  Created by 米娜 上海文星广告传媒有限公司 on 15/6/4.
//  Copyright (c) 2015年 wenxing. All rights reserved.
//

#import "Comcommodel.h"
#import "NSDictionary+Null.h"
@implementation Comcommodel
- (id)initWithDic:(NSDictionary*)dic
{
    self = [super init];
    if (self) {
        NSDictionary *dic1=[dic notNullobjectForKey:@"user_info"];
       
        
        self.name=[dic1 notNullobjectForKey:@"user_name"];
        self.touxiang=[dic1 notNullobjectForKey:@"avatar_file"];
        self.time=[dic notNullobjectForKey:@"add_time"];
       NSString *zhongmessage=[dic notNullobjectForKey:@"answer_content"];
        
        NSLog(@"%@",zhongmessage);
        
        NSArray *a2=[dic notNullobjectForKey:@"img"];
        
        NSLog(@"%@",a2);
        if (a2.count!=0) {
           NSDictionary *dic2=[a2 objectAtIndex:0];
             NSLog(@"%@",dic2);
            self.imagesheight=[dic2 objectForKey:@"1"];
            
        }else{
             self.imagesheight=@"0";
            
        }
       
        
        
        if([zhongmessage rangeOfString:@"[img]"].location !=NSNotFound)
            {
                NSArray *h1=[zhongmessage componentsSeparatedByString:@"[img]"];
                
                            NSLog(@"%@",[h1 objectAtIndex:0]);
                
                self.huifu=[h1 objectAtIndex:0];
        NSRange range = [zhongmessage rangeOfString:@"\\[img\\](.*?)\\[\\/img\\]" options:NSRegularExpressionSearch];
        if (range.location != NSNotFound) {
            
            NSLog(@"%@", [zhongmessage substringWithRange:range]);
            NSString *st1=[zhongmessage substringWithRange:range];
            
            NSArray *a1=[st1 componentsSeparatedByString:@"[img]"];
            NSString *st2=[a1 objectAtIndex:1];
            NSLog(@"%@", st2);
            
             NSArray *a2=[st2 componentsSeparatedByString:@"[/img]"];
            
             self.images=[a2 objectAtIndex:0];
            NSLog(@"%@",self.images);
            
            
        }}else{
            
            
            self.huifu=zhongmessage;
            
            
            
        }
        
        
        

        
    }
    
    
    return self;
    
    
}
@end

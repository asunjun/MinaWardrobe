
//
//  ComQuestionNRModel.m
//  MinaWardrobe
//
//  Created by 米娜 上海文星广告传媒有限公司 on 15/6/4.
//  Copyright (c) 2015年 wenxing. All rights reserved.
//

#import "ComQuestionNRModel.h"
#import "NSDictionary+Null.h"
@implementation ComQuestionNRModel
- (id)initWithDic:(NSDictionary*)dic
{
    self = [super init];
    if (self) {
        
        
        NSDictionary *post=[dic notNullobjectForKey:@"post"];
        self.dic2=[dic notNullobjectForKey:@"comments"];
        NSLog(@"%ld",self.dic2.count);
        
        self.title=[post notNullobjectForKey:@"question_content"];
        NSString *mess=[post notNullobjectForKey:@"question_detail"];
        NSLog(@"%@",mess);
        NSLog(@"%@",self.title);
        if([mess rangeOfString:@"[img]"].location !=NSNotFound)//_roaldSearchText
        {
            NSArray *a1=[mess componentsSeparatedByString:@"[img]"];
            
            NSLog(@"%@",[a1 objectAtIndex:0]);
            
            self.message=[a1 objectAtIndex:0];
            
            NSLog(@"%@",[a1 objectAtIndex:1]);
            
            
            NSLog(@"yes");
        }
        else
        {
            self.message=mess;
            
        }
        
    }
    return self;
}
@end

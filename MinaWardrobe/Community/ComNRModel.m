//
//  ComNRModel.m
//  MinaWardrobe
//
//  Created by 米娜 上海文星广告传媒有限公司 on 15/5/25.
//  Copyright (c) 2015年 wenxing. All rights reserved.
//

#import "ComNRModel.h"
#import "NSDictionary+Null.h"
@implementation ComNRModel
- (id)initWithDic:(NSDictionary*)dic
{
    self = [super init];
    if (self) {
        
        
        NSDictionary *post=[dic notNullobjectForKey:@"post"];
        self.commons=[dic notNullobjectForKey:@"comments"];
        NSLog(@"%ld",_commons.count);
        
        self.title=[post notNullobjectForKey:@"title"];
        NSString *mess=[post notNullobjectForKey:@"message"];
        NSLog(@"%@",mess);
         NSLog(@"%@",self.title);
        if([mess rangeOfString:@"##########"].location !=NSNotFound)//_roaldSearchText
        {
            NSArray *a1=[mess componentsSeparatedByString:@"##########"];
           
                NSLog(@"%@",[a1 objectAtIndex:0]);
                
            self.message=[a1 objectAtIndex:0];
            
                 NSLog(@"%@",[a1 objectAtIndex:1]);
            
            
            NSLog(@"yes");
        }
        else
        {
            
            NSLog(@"no");
        }
        
    }
    return self;
}

@end

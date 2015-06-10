
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
        
        self.huifu=[dic notNullobjectForKey:@"answer_content"];
        
  
        
    }
    
    
    return self;
    
    
}
@end

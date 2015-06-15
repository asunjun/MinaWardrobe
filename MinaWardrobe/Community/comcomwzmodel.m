//
//  comcomwzmodel.m
//  MinaWardrobe
//
//  Created by 米娜 上海文星广告传媒有限公司 on 15/6/9.
//  Copyright (c) 2015年 wenxing. All rights reserved.
//

#import "comcomwzmodel.h"
#import "NSDictionary+Null.h"
@implementation comcomwzmodel
- (id)initWithDic:(NSDictionary*)dic
{
    self = [super init];
    if (self) {
        NSDictionary *dic1=[dic notNullobjectForKey:@"user_info"];
        
        self.name=[dic1 notNullobjectForKey:@"user_name"];
        
        self.huifu=[dic notNullobjectForKey:@"message"];
        NSLog(@"%@",self.huifu);
        
            
        
        
    }
    
    
    return self;
    
    
}
@end

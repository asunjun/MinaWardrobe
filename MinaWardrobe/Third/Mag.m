//
//  Mag.m
//  imag
//
//  Created by 米娜 上海文星广告传媒有限公司 on 14-8-12.
//
//

#import "Mag.h"

@implementation Mag
static Mag *singletonData = nil;
+(Mag *)shard {
    
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        singletonData = [[Mag alloc] init];
    });
    
    return singletonData;
    
}
@end

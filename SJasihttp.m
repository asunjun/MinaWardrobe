//
//  SJasihttp.m
//  MinaWardrobe
//
//  Created by 米娜 上海文星广告传媒有限公司 on 15/5/14.
//  Copyright (c) 2015年 wenxing. All rights reserved.
//

#import "SJasihttp.h"

@implementation SJasihttp
static SJasihttp *sharedAsi = nil;
+(SJasihttp*)sharedAMYHttpClient
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedAsi = [[SJasihttp alloc]init];
    });
    return sharedAsi;
}
@end

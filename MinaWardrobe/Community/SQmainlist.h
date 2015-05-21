//
//  SQmainlist.h
//  MinaWardrobe
//
//  Created by 米娜 上海文星广告传媒有限公司 on 15/5/18.
//  Copyright (c) 2015年 wenxing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQmainlist : NSObject
@property(copy,nonatomic)NSString *fabutime;//发布时间

@property(copy,nonatomic)NSString *fabuname;
//
@property(copy,nonatomic)NSString *fabutouxiang;
//
@property(copy,nonatomic)NSString *shouchanshu;
//
@property(copy,nonatomic)NSString *fabupinglun;
//
//@property(copy,nonatomic)NSString *fabutime;
- (id)initWithDic:(NSDictionary*)dic;


@end

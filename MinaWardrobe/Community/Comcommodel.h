//
//  Comcommodel.h
//  MinaWardrobe
//
//  Created by 米娜 上海文星广告传媒有限公司 on 15/6/4.
//  Copyright (c) 2015年 wenxing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comcommodel : NSObject

@property(copy,nonatomic)NSString *name;

@property(copy,nonatomic)NSString *huifu;

@property(copy,nonatomic)NSString *images;

@property(copy,nonatomic)NSString *imagesheight;

@property(copy,nonatomic)NSString *touxiang;

@property(copy,nonatomic)NSString *time;



- (id)initWithDic:(NSDictionary*)dic;



@end

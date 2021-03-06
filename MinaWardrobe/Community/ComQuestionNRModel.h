//
//  ComQuestionNRModel.h
//  MinaWardrobe
//
//  Created by 米娜 上海文星广告传媒有限公司 on 15/6/4.
//  Copyright (c) 2015年 wenxing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ComQuestionNRModel : NSObject
@property(copy,nonatomic)NSString *title;

@property(copy,nonatomic)NSMutableArray *images;

@property(copy,nonatomic)NSString *message;

@property(copy,nonatomic)NSString *pltitle;

@property(copy,nonatomic)NSString *plname;

@property(copy,nonatomic)NSArray *dic2;

@property(copy,nonatomic)NSString *time;

@property(copy,nonatomic)NSString *img;



- (id)initWithDic:(NSDictionary*)dic;

@end

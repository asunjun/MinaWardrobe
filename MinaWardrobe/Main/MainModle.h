//
//  MainModle.h
//  MinaWardrobe
//
//  Created by apple on 15/5/19.
//  Copyright (c) 2015年 wenxing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainModle : NSObject

@property (nonatomic, strong) NSString *imageName;//图片名
@property (nonatomic, strong) NSString *buyURL;//购买地址
@property (nonatomic, strong) NSString *imageURL;//图片地址
@property (nonatomic, strong) NSString *collectNumber;//收集人数

- (id)initWithDictionary:(NSDictionary *)dict;

@end

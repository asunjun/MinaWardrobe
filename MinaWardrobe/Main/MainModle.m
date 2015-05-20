//
//  MainModle.m
//  MinaWardrobe
//
//  Created by apple on 15/5/19.
//  Copyright (c) 2015年 wenxing. All rights reserved.
//

#import "MainModle.h"

@implementation MainModle

- (id)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        self.imageName = dict[@"name"];
//        NSLog(@"%@", self.imageName);
        self.buyURL = dict[@"taoke_url"];
        self.imageURL = dict[@"picurl_t"];
        self.collectNumber = dict[@"collect_count"];
    }
    return self;
}

@end

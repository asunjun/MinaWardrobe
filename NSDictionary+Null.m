//
//  NSDictionary+Null.m
//  AMY
//
//  Created by amy_hello on 15/3/23.
//  Copyright (c) 2015年 ASYH. All rights reserved.
//

#import "NSDictionary+Null.h"

@implementation NSDictionary (Null)
- (id)notNullobjectForKey:(id)aKey
{
    id object = [self objectForKey:aKey];
    if ([object isKindOfClass:[NSNull class]]) {
        return @"";
    }
    return object;
}
@end

//
//  NSDictionary+Null.h
//  AMY
//
//  Created by amy_hello on 15/3/23.
//  Copyright (c) 2015年 ASYH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Null)
//如果解析到没有的字段，则赋空值,防止因为空值而闪退
- (id)notNullobjectForKey:(id)aKey;
@end

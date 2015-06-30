//
//  Mag.h
//  imag
//
//  Created by 米娜 上海文星广告传媒有限公司 on 14-8-12.
//
//

#import <Foundation/Foundation.h>

@interface Mag : NSObject

@property (nonatomic, strong) NSMutableArray *imageArrrr;
@property (nonatomic, strong) NSMutableArray *imageHeightArrrrr;

+(Mag *)shard;

@end

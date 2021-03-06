//
//  ComTwoNRTableViewCell.h
//  MinaWardrobe
//
//  Created by 米娜 上海文星广告传媒有限公司 on 15/5/26.
//  Copyright (c) 2015年 wenxing. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ComNRModel.h"
@interface ComTwoNRTableViewCell : UITableViewCell<UIScrollViewDelegate, UIActionSheetDelegate>
@property(strong,nonatomic)UIImageView *img1;

@property(strong,nonatomic)UIImageView *img2;

@property(strong,nonatomic)UIImageView *img3;

@property(strong,nonatomic)UILabel *lab1;


- (void)configCellByTradeModel:(NSArray *)trade;

@property (nonatomic, strong) NSMutableArray *imageArr;

@end

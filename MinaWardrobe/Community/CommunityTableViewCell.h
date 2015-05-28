//
//  CommunityTableViewCell.h
//  MinaWardrobe
//
//  Created by 米娜 上海文星广告传媒有限公司 on 15/5/19.
//  Copyright (c) 2015年 wenxing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SQmainlist;
@interface CommunityTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *time;

@property (weak, nonatomic) IBOutlet UILabel *message;

@property (weak, nonatomic) IBOutlet UILabel *shouchangshu;

@property (weak, nonatomic) IBOutlet UILabel *pinglunshu;

@property (weak, nonatomic) IBOutlet UIImageView *img1;

@property (weak, nonatomic) IBOutlet UIImageView *img2;

@property (weak, nonatomic) IBOutlet UIImageView *img3;


@property (weak, nonatomic) IBOutlet UIImageView *img4;

@property (weak, nonatomic) IBOutlet UIImageView *shouchang;

@property (weak, nonatomic) IBOutlet UIImageView *pinglun;

@property (weak, nonatomic) IBOutlet UIView *view1;

@property(assign,nonatomic)BOOL ishidder;

- (void)configCellByTradeModel:(SQmainlist  *)trade;

@end

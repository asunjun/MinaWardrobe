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
@property(strong,nonatomic)UIView *view1;


@property(strong,nonatomic)UILabel *title;

@property(strong,nonatomic)UILabel *name;

@property(strong,nonatomic)UILabel *time;

@property(strong,nonatomic)UILabel *message;

@property(strong,nonatomic)UIImageView *img1;

@property(strong,nonatomic)UIImageView *img2;

@property(strong,nonatomic)UIImageView *img3;

@property(strong,nonatomic)UILabel *shoucang;

@property(strong,nonatomic)UILabel *shouchangshu;

@property(strong,nonatomic)UILabel *pinglun;

@property(strong,nonatomic)UILabel *pinglunshu;

@property(strong,nonatomic)UIImageView *img4;



@property(assign,nonatomic)BOOL ishidder;

- (void)configCellByTradeModel:(SQmainlist  *)trade;

@end

//
//  MainCollectionViewCell.h
//  MinaWardrobe
//
//  Created by apple on 15/5/19.
//  Copyright (c) 2015年 wenxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *tImage;//大图
@property (nonatomic, strong) UILabel *tName;//名字

@property (nonatomic, strong) UIImageView *collectImage;//收藏图
@property (nonatomic, strong) UILabel *collectLabel;//收藏人数
@property (nonatomic, strong) UIButton *collectButton;//收藏按钮

@property (nonatomic, strong) UIImageView *shareImage;//分享图
@property (nonatomic, strong) UILabel *shareLabel;//分享人数
@property (nonatomic, strong) UIButton *shareButton;//分享按钮

@end

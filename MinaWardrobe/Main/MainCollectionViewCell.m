//
//  MainCollectionViewCell.m
//  MinaWardrobe
//
//  Created by apple on 15/5/19.
//  Copyright (c) 2015年 wenxing. All rights reserved.
//

#import "MainCollectionViewCell.h"

@implementation MainCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    [self initImage];
    [self initLabel];
    [self initCollect];
    [self initShare];
}

- (void)initImage {
    self.tImage = [[UIImageView alloc] init];
    self.tImage.frame = CGRectMake(0, 0, self.contentView.bounds.size.width, 180);
    [self.contentView addSubview:self.tImage];
}

- (void)initLabel {
    self.tName = [[UILabel alloc] init];
    self.tName.frame = CGRectMake(5, self.tImage.frame.size.height + 5, self.contentView.frame.size.width - 10, 30);
    self.tName.font = [UIFont systemFontOfSize:12];
    self.tName.numberOfLines = 2;
    [self.contentView addSubview:self.tName];
}

- (void)initCollect {
    self.collectImage = [[UIImageView alloc] init];
    self.collectImage.backgroundColor = [UIColor redColor];
    self.collectImage.frame = CGRectMake(5, self.tImage.frame.size.height + 5 + self.tName.frame.size.height + 10, 15, 15);
    [self.contentView addSubview:self.collectImage];
    
    self.collectLabel = [[UILabel alloc] init];
//    self.collectLabel.backgroundColor = [UIColor redColor];
    self.collectLabel.frame = CGRectMake(21, self.tImage.frame.size.height + 5 + self.tName.frame.size.height + 10, 15, 15);
    self.collectLabel.font = [UIFont systemFontOfSize:10];
    self.collectLabel.textAlignment = NSTextAlignmentCenter;
    self.collectLabel.textColor = [UIColor darkGrayColor];
    [self.contentView addSubview:self.collectLabel];
    
    self.collectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.collectButton.frame = CGRectMake(5, self.tImage.frame.size.height + 5 + self.tName.frame.size.height + 10, 31, 15);
    [self.contentView addSubview:self.collectButton];
}

- (void)initShare {
    self.shareImage = [[UIImageView alloc] init];
    self.shareImage.backgroundColor = [UIColor blueColor];
    self.shareImage.frame = CGRectMake(40, self.tImage.frame.size.height + 5 + self.tName.frame.size.height + 10, 15, 15);
    [self.contentView addSubview:self.shareImage];
    
    self.shareLabel = [[UILabel alloc] init];
    self.shareLabel.backgroundColor = [UIColor greenColor];
    self.shareLabel.frame = CGRectMake(56, self.tImage.frame.size.height + 5 + self.tName.frame.size.height + 10, 15, 15);
    [self.contentView addSubview:self.shareLabel];
    
    self.shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.shareButton.frame = CGRectMake(56, self.tImage.frame.size.height + 5 + self.tName.frame.size.height + 10, 31, 15);
    [self.contentView addSubview:self.shareButton];
}

@end

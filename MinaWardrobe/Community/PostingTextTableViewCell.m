//
//  PostingTextTableViewCell.m
//  MinaWardrobe
//
//  Created by apple on 15/5/28.
//  Copyright (c) 2015年 wenxing. All rights reserved.
//

#import "PostingTextTableViewCell.h"

@implementation PostingTextTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self initSth];
    [self initFrame];
}

- (void)initSth {
    self.textView = [[UITextView alloc] init];
    self.textView.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:self.textView];
    
    self.addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addButton.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.addButton];
}

- (void)initFrame {
    self.textView.frame = CGRectMake(5, 5, WIDTH - 10, 80);
    self.addButton.frame = CGRectMake(5, 90, 50, 50);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

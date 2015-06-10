//
//  ComNRTableViewCell.h
//  MinaWardrobe
//
//  Created by 米娜 上海文星广告传媒有限公司 on 15/5/25.
//  Copyright (c) 2015年 wenxing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ComNRModel;
@interface ComNRTableViewCell : UITableViewCell
//@property(strong,nonatomic)UILabel *lab1;
//@property(strong,nonatomic)UILabel *lab2;
//@property(strong,nonatomic)UILabel *lab3;
//@property(strong,nonatomic)UILabel *lab4;

@property (weak, nonatomic) IBOutlet UILabel *lab1;


@property (weak, nonatomic) IBOutlet UILabel *lab2;

@property (weak, nonatomic) IBOutlet UILabel *lab3;

@property (weak, nonatomic) IBOutlet UILabel *lab4;

- (void)configCellByTradeModel:(NSString *)titile and:(NSString *)message;
@end

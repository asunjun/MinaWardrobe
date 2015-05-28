//
//  PostingViewController.h
//  MinaWardrobe
//
//  Created by apple on 15/5/28.
//  Copyright (c) 2015年 wenxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostingTextTableViewCell.h"
#import "PostingMapTableViewCell.h"

@interface PostingViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UIView *naviView;

@property (strong, nonatomic) IBOutlet UITableView *tView;

@end

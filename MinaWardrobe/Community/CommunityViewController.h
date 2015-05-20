//
//  CommunityViewController.h
//  MinaWardrobe
//
//  Created by apple on 15/5/14.
//  Copyright (c) 2015年 wenxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
@interface CommunityViewController : UIViewController<ASIHTTPRequestDelegate>
@property (weak, nonatomic) IBOutlet UIView *footview;
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

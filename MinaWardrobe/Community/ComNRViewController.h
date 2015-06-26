//
//  ComNRViewController.h
//  MinaWardrobe
//
//  Created by 米娜 上海文星广告传媒有限公司 on 15/5/25.
//  Copyright (c) 2015年 wenxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
@interface ComNRViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *table;
@property(strong,nonatomic)NSMutableArray *hufuimages;


-(id)initWith:(NSString *)idzhi and:(NSArray *)images and:(NSString *)catgroup;

@end

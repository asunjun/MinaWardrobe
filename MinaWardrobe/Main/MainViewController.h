//
//  MainViewController.h
//  MinaWardrobe
//
//  Created by apple on 15/5/14.
//  Copyright (c) 2015年 wenxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainModle.h"
#import "MainCollectionViewCell.h"
#import "TaoKeWebViewController.h"

#import "AFHTTPRequestOperationManager.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"

@interface MainViewController : UIViewController<UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *btnsView;
@property (strong, nonatomic) IBOutlet UIScrollView *baseScrollView;

@property (nonatomic, strong) UICollectionView *hCollection;
@property (nonatomic, strong) UICollectionView *nCollection;

@property (nonatomic, strong) NSMutableArray *datasource;//请求到的数据
@property (nonatomic, strong) NSMutableArray *datasource1;//请求到的数据

@property (nonatomic, strong) NSArray *btnsArr;

@property (nonatomic, strong) UILabel *lineLab;


@end

//
//  MainViewController.m
//  MinaWardrobe
//
//  Created by apple on 15/5/14.
//  Copyright (c) 2015年 wenxing. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationController.navigationBarHidden = YES;
    
    [self initArray];
    [self initView];
    [self initScrollView];
    [self inithCollectionView];
//    [self initnCollectionView];
    [self setupRefresh];
}

- (void)initArray {
    self.datasource = [[NSMutableArray alloc] init];
    self.btnsArr = [[NSArray alloc] initWithObjects:@"11", @"22", nil];
}

- (void)initScrollView {
    self.baseScrollView.delegate = self;
    self.baseScrollView.contentSize = CGSizeMake(WIDTH * self.btnsArr.count, HEIGHT - 119);
    self.baseScrollView.pagingEnabled = YES;
    self.baseScrollView.backgroundColor = [UIColor lightGrayColor];
    self.baseScrollView.frame = CGRectMake(0, 70, WIDTH, HEIGHT - 119);
    self.baseScrollView.tag = 555;
}

- (void)initView {
    UIImageView *iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, 40, 40)];
    iconImage.backgroundColor = [UIColor yellowColor];
    [self.btnsView addSubview:iconImage];
    
    self.lineLab = [[UILabel alloc] initWithFrame:CGRectMake(53, 44, WIDTH / self.btnsArr.count - 36, 1)];
    self.lineLab.backgroundColor = [UIColor redColor];
    [self.btnsView addSubview:self.lineLab];
    
    for (int i = 0; i < self.btnsArr.count; i++) {
        UIButton *naviButton = [UIButton buttonWithType:UIButtonTypeCustom];
        naviButton.frame = CGRectMake(45 + ((WIDTH - 45) / self.btnsArr.count * i), 15, (WIDTH - 45) / self.btnsArr.count - 5, 20);
        [naviButton setTitle:self.btnsArr[i] forState:UIControlStateNormal];
        naviButton.backgroundColor = [UIColor redColor];
        naviButton.tag = 100 + i;
        [naviButton addTarget:self action:@selector(handleNaviButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.btnsView addSubview:naviButton];
    }
}

- (void)inithCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.nCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 119) collectionViewLayout:layout];
    self.nCollection.backgroundColor = [UIColor greenColor];
    self.nCollection.delegate = self;
    self.nCollection.dataSource = self;
    self.nCollection.tag = 111;
    [self.nCollection registerNib:[UINib nibWithNibName:@"MainCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBarHidden = YES;
    [self.baseScrollView addSubview:self.nCollection];
    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//    //    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    [manager GET:@"http://share.mina.com.cn/getShareGoodsJson.php?action=cate&id=2" parameters:nil success:^(AFHTTPRequestOperation *operation, NSMutableArray *responseObject) {
//        for (NSDictionary *dict in responseObject) {
//            MainModle *model = [[MainModle alloc] initWithDictionary:dict];
//            [self.datasource1 addObject:model];
//            [self.hCollection reloadData];
//        }
//        //        NSLog(@"%@", self.datasource);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"--------------------------------------------Error: %@", error);
//    }];
}

- (void)initnCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.hCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(WIDTH + 1, 0, WIDTH, HEIGHT - 119) collectionViewLayout:layout];
    self.hCollection.backgroundColor = [UIColor blueColor];
    self.hCollection.delegate = self;
    self.hCollection.dataSource = self;
    self.hCollection.tag = 222;
    [self.hCollection registerNib:[UINib nibWithNibName:@"MainCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBarHidden = YES;
    [self.baseScrollView addSubview:self.hCollection];
    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//    //    manager.responseSerializer = [AFJSONResponseSerializer serializer];
//    [manager GET:@"http://share.mina.com.cn/getShareGoodsJson.php?action=cate&id=2" parameters:nil success:^(AFHTTPRequestOperation *operation, NSMutableArray *responseObject) {
//        for (NSDictionary *dict in responseObject) {
//            MainModle *model = [[MainModle alloc] initWithDictionary:dict];
//            [self.datasource addObject:model];
////            NSLog(@"%@", self.datasource);
//            [self.nCollection reloadData];
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"--------------------------------------------Error: %@", error);
//    }];
}

#pragma mark - collectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.datasource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    MainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
//    MainModle *model = [self.datasource objectAtIndex:indexPath.row];
//    cell.backgroundColor = [UIColor whiteColor];
//    cell.tName.text = model.imageName;
//    [cell.tImage sd_setImageWithURL:[NSURL URLWithString:model.imageURL]];
//    cell.collectLabel.text = model.collectNumber;
//    [cell.collectButton addTarget:self action:@selector(handleCollectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//    [cell.shareButton addTarget:self action:@selector(handleShareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
//    return cell;
    
    if (collectionView.tag == 111) {
        MainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
        MainModle *model = [self.datasource objectAtIndex:indexPath.row];
        cell.backgroundColor = [UIColor whiteColor];
        cell.tName.text = model.imageName;
        [cell.tImage sd_setImageWithURL:[NSURL URLWithString:model.imageURL]];
        cell.collectLabel.text = model.collectNumber;
        [cell.collectButton addTarget:self action:@selector(handleCollectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.shareButton addTarget:self action:@selector(handleShareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    if (collectionView.tag == 222) {
            MainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
            MainModle *model = [self.datasource objectAtIndex:indexPath.row];
            cell.backgroundColor = [UIColor whiteColor];
            cell.tName.text = model.imageName;
            [cell.tImage sd_setImageWithURL:[NSURL URLWithString:model.imageURL]];
            cell.collectLabel.text = model.collectNumber;
            [cell.collectButton addTarget:self action:@selector(handleCollectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.shareButton addTarget:self action:@selector(handleShareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
    }
    return nil;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView.tag == 111) {
        CGFloat height = WIDTH / 2 - 15;
        CGFloat width = 250;
        return CGSizeMake(height, width);
    }
    if (collectionView.tag == 222) {
        CGFloat height = WIDTH / 2 - 15;
        CGFloat width = 250;
        return CGSizeMake(height, width);
    }
    CGFloat height = WIDTH / 2 - 15;
    CGFloat width = 250;
    return CGSizeMake(height, width);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (collectionView.tag == 111) {
        return UIEdgeInsetsMake(8, 10, 10, 10);
        
    }
    if (collectionView.tag == 222) {
        return UIEdgeInsetsMake(8, 10, 10, 10);
    }
    return UIEdgeInsetsMake(8, 10, 10, 10);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView.tag == 111) {
        MainModle *model = [self.datasource objectAtIndex:indexPath.row];
        TaoKeWebViewController *taokeVC = [[TaoKeWebViewController alloc] init];
        taokeVC.comeURL = model.buyURL;
        [self.navigationController pushViewController:taokeVC animated:YES];
    }
    if (collectionView.tag == 222) {
        MainModle *model = [self.datasource objectAtIndex:indexPath.row];
        TaoKeWebViewController *taokeVC = [[TaoKeWebViewController alloc] init];
        taokeVC.comeURL = model.buyURL;
        [self.navigationController pushViewController:taokeVC animated:YES];
    }
}

- (void)handleCollectButtonAction:(UIButton *)sender {
    NSLog(@"收藏人数+1");
}

- (void)handleShareButtonAction:(UIButton *)sender {
    NSLog(@"分享");
}


#pragma mark - 选项Button下划线
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    float x = scrollView.contentOffset.x;
    if (scrollView.tag == 555) {
        CGFloat offset_x = scrollView.contentOffset.x / WIDTH;
//        NSLog(@"%f",offset_x);
        self.lineLab.frame = CGRectMake(53 + ((WIDTH - 45) / self.btnsArr.count * offset_x), self.lineLab.frame.origin.y, self.lineLab.bounds.size.width, self.lineLab.bounds.size.height);
    }
    if (x > WIDTH - 1) {
        NSLog(@"%f", x);
        [self initnCollectionView];
        [self setupRefresh];
    }
}
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    if (scrollView.tag == 555) {
//        int a = scrollView.contentOffset.x / 320;
//        UIButton *button = (UIButton *)[self.lineLab viewWithTag:a + 100];
//        [self changeButton:button];
//        for (int i = 0; i < self.lineLab.subviews.count; i++) {
//            if ([self.lineLab.subviews[i] isKindOfClass:[UIButton class]]) {
//                UIButton *button = (UIButton *)self.lineLab.subviews[i];
//                if (button.tag != a + 100) {
//                    [self reductionButton:button];
//                }
//            }
//        }
//    }
//}

- (void)handleNaviButtonAction:(UIButton *)sender {
//    NSLog(@"%ld", sender.tag);
    
//    [self changeButton:sender];
    [UIView animateWithDuration:0.3 animations:^{
        UIScrollView *scrollView = (UIScrollView *)[self.view viewWithTag:555];
        scrollView.contentOffset = CGPointMake((sender.tag - 100) * self.view.bounds.size.width, 0);
    }];
    for (int i = 0; i < self.lineLab.subviews.count; i++) {
        if ([self.lineLab.subviews[i] isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)self.lineLab.subviews[i];
            if (button.tag != sender.tag) {
//                [self reductionButton:button];
            }
        }
    }
}

//改变button的颜色和大小
- (void)changeButton:(UIButton *)sender {
    [sender setTitleColor:[UIColor magentaColor] forState:UIControlStateNormal];
    sender.titleLabel.font = [UIFont systemFontOfSize:15];
}
//还原button的颜色和大小
- (void)reductionButton:(UIButton *)sender {
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sender.titleLabel.font = [UIFont systemFontOfSize:13];
}


#pragma marl - MJ
- (void)setupRefresh
{
    if (self.nCollection.tag == 111) {
        // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
        [self.nCollection addHeaderWithTarget:self action:@selector(headerRereshing)];
        [self.nCollection headerBeginRefreshing];
        
        // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
        [self.nCollection addFooterWithTarget:self action:@selector(footerRereshing)];
        
        // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
        self.nCollection.headerPullToRefreshText = @"✨下拉可以刷新了✨";
        self.nCollection.headerReleaseToRefreshText = @"✨松开马上刷新了✨";
        self.nCollection.headerRefreshingText = @"✨正在帮你刷新中✨";
        
        self.nCollection.footerPullToRefreshText = @"✨上拉可以加载更多数据了✨";
        self.nCollection.footerReleaseToRefreshText = @"✨松开马上加载更多数据了✨";
        self.nCollection.footerRefreshingText = @"✨正在帮你加载中✨";
    }
    if (self.hCollection.tag == 222) {
        // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
        [self.hCollection addHeaderWithTarget:self action:@selector(headerRereshing)];
        [self.nCollection headerBeginRefreshing];
        
        // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
        [self.hCollection addFooterWithTarget:self action:@selector(footerRereshing)];
        
        // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
        self.hCollection.headerPullToRefreshText = @"✨下拉可以刷新了✨";
        self.hCollection.headerReleaseToRefreshText = @"✨松开马上刷新了✨";
        self.hCollection.headerRefreshingText = @"✨正在帮你刷新中✨";
        
        self.hCollection.footerPullToRefreshText = @"✨上拉可以加载更多数据了✨";
        self.hCollection.footerReleaseToRefreshText = @"✨松开马上加载更多数据了✨";
        self.hCollection.footerRefreshingText = @"✨正在帮你加载中✨";
        
    }
}

//合适时机刷新数据
- (void)headerRereshing
{
    if (self.nCollection) {
        // 1.添加数据
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        //    manager.responseSerializer = [AFJSONResponseSerializer serializer];
        [manager GET:@"http://share.mina.com.cn/getShareGoodsJson.php?action=cate&id=2" parameters:nil success:^(AFHTTPRequestOperation *operation, NSMutableArray *responseObject) {
            for (NSDictionary *dict in responseObject) {
                MainModle *model = [[MainModle alloc] initWithDictionary:dict];
                [self.datasource addObject:model];
                //            NSLog(@"%@", self.datasource);
                [self.nCollection reloadData];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"--------------------------------------------Error: %@", error);
        }];
        
        // 2.2秒后刷新表格UI(此处直接用,不用修改)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 刷新表格
            [self.nCollection reloadData];
            
            // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
            [self.nCollection headerEndRefreshing];
        });
    }
    if (self.hCollection) {
        // 1.添加数据
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        //    manager.responseSerializer = [AFJSONResponseSerializer serializer];
        [manager GET:@"http://share.mina.com.cn/getShareGoodsJson.php?action=cate&id=2" parameters:nil success:^(AFHTTPRequestOperation *operation, NSMutableArray *responseObject) {
            for (NSDictionary *dict in responseObject) {
                MainModle *model = [[MainModle alloc] initWithDictionary:dict];
                [self.datasource addObject:model];
                //            NSLog(@"%@", self.datasource);
                [self.hCollection reloadData];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"--------------------------------------------Error: %@", error);
        }];
        
        // 2.2秒后刷新表格UI(此处直接用,不用修改)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 刷新表格
            [self.hCollection reloadData];
            
            // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
            [self.hCollection headerEndRefreshing];
        });    }
}

- (void)footerRereshing
{
    if (self.nCollection) {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        //    manager.responseSerializer = [AFJSONResponseSerializer serializer];
        [manager GET:@"http://share.mina.com.cn/getShareGoodsJson.php?action=cate&id=2" parameters:nil success:^(AFHTTPRequestOperation *operation, NSMutableArray *responseObject) {
            for (NSDictionary *dict in responseObject) {
                MainModle *model = [[MainModle alloc] initWithDictionary:dict];
                [self.datasource addObject:model];
                //            NSLog(@"%@", self.datasource);
                [self.nCollection reloadData];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"--------------------------------------------Error: %@", error);
        }];
        
        // 2.2秒后刷新表格UI(此处直接用,不用修改)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 刷新表格
            [self.nCollection reloadData];
            
            // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
            [self.nCollection footerEndRefreshing];
        });
    }
    if (self.hCollection) {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        //    manager.responseSerializer = [AFJSONResponseSerializer serializer];
        [manager GET:@"http://share.mina.com.cn/getShareGoodsJson.php?action=cate&id=2" parameters:nil success:^(AFHTTPRequestOperation *operation, NSMutableArray *responseObject) {
            for (NSDictionary *dict in responseObject) {
                MainModle *model = [[MainModle alloc] initWithDictionary:dict];
                [self.datasource addObject:model];
                //            NSLog(@"%@", self.datasource);
                [self.hCollection reloadData];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"--------------------------------------------Error: %@", error);
        }];
        
        // 2.2秒后刷新表格UI(此处直接用,不用修改)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 刷新表格
            [self.hCollection reloadData];
            
            // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
            [self.hCollection footerEndRefreshing];
        });
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

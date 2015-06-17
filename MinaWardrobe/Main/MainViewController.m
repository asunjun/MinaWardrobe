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

static int aa;//数据分段
static int bb;//同上

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString:@"http://sq.mina.cn/index.php/account/ajax/login_process/"];
    //ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request setPostValue:@"admin" forKey:@"user_name"];
    [request setPostValue:@"admin"   forKey:@"password"];
    [request setUseCookiePersistence:YES];
    [request setDelegate:self];
    [request startAsynchronous];

    
    
    
    // Do any additional setup after loading the view from its nib.
    
    [self initArray];
    [self initView];
    [self initScrollView];
    [self inithCollectionView];
}
-(void)requestFinished:(ASIHTTPRequest *)request{
    NSString *st1=[request responseString];
    NSData *data = [st1 dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    if ([[dict objectForKey:@"errno"] intValue] == 1) {
        NSLog(@"登陆成功");
        [self testButtonAction];
    } else {
        NSLog(@"失败");
    }
    
    
    NSLog(@"*******%@", st1);
}
- (void)testButtonAction {
    NSURL *url = [NSURL URLWithString:@"http://sq.mina.cn/?/api/"];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];
}

- (void)viewDidAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES];
}

#pragma mark - 各种alloc init
- (void)initArray {
    self.hData = [[NSMutableArray alloc] init];
    self.nData = [[NSMutableArray alloc] init];
    self.btnsArr = [[NSArray alloc] initWithObjects:@"热门", @"最新", nil];
}

- (void)initScrollView {
    self.baseScrollView.delegate = self;
    self.baseScrollView.contentSize = CGSizeMake(WIDTH * self.btnsArr.count, HEIGHT - 119);
    self.baseScrollView.pagingEnabled = YES;
    self.baseScrollView.backgroundColor = [UIColor whiteColor];
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
    self.hCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 119) collectionViewLayout:layout];
    //    self.nCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 119)];
    self.hCollection.backgroundColor = [UIColor clearColor];
    self.hCollection.delegate = self;
    self.hCollection.dataSource = self;
    self.hCollection.tag = 111;
    [self.hCollection registerNib:[UINib nibWithNibName:@"MainCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBarHidden = YES;
    [self.baseScrollView addSubview:self.hCollection];
    
    [self setupRefresh];
}

- (void)initnCollectionView {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.nCollection = [[UICollectionView alloc] initWithFrame:CGRectMake(WIDTH + 1, 0, WIDTH, HEIGHT - 119) collectionViewLayout:layout];
    self.nCollection.backgroundColor = [UIColor clearColor];
    self.nCollection.delegate = self;
    self.nCollection.dataSource = self;
    self.nCollection.tag = 222;
    [self.nCollection registerNib:[UINib nibWithNibName:@"MainCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBarHidden = YES;
    [self.baseScrollView addSubview:self.nCollection];
    
    //    [self nCollectionRequest];
}

#pragma mark - 网络请求
- (void)hCollectionRequest {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager GET:@"http://share.mina.com.cn/getShareGoodsJson.php?action=cate&id=2" parameters:nil success:^(AFHTTPRequestOperation *operation, NSMutableArray *responseObject) {
        //        for (NSDictionary *dict in responseObject) {
        //            MainModle *model = [[MainModle alloc] initWithDictionary:dict];
        //            [self.hData addObject:model];
        //            [self.hCollection reloadData];
        //            [self.hCollection headerEndRefreshing];
        //            NSLog(@"%@", dict);
        //        }
        self.hbData = [[NSMutableArray alloc] initWithArray:responseObject];
        aa = 10;
        for (int i = 0; i < aa; i++) {
            NSDictionary *dict = [responseObject objectAtIndex:i];
            MainModle *model = [[MainModle alloc] initWithDictionary:dict];
            [self.hData addObject:model];
        }
        [self.hCollection reloadData];
        [self.hCollection headerEndRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"--------------------------------------------Error: %@", error);
    }];
}

- (void)nCollectionRequest {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager GET:@"http://share.mina.com.cn/getShareGoodsJson.php?action=cate&id=2" parameters:nil success:^(AFHTTPRequestOperation *operation, NSMutableArray *responseObject) {
        //        for (NSDictionary *dict in responseObject) {
        //            MainModle *model = [[MainModle alloc] initWithDictionary:dict];
        //            [self.nData addObject:model];
        //            [self.nCollection reloadData];
        //            [self.nCollection headerEndRefreshing];
        //        }
        
        self.nbData = [[NSMutableArray alloc] initWithArray:responseObject];
        bb = 10;
        for (int i = 0; i < bb; i++) {
            NSDictionary *dict = [responseObject objectAtIndex:i];
            MainModle *model = [[MainModle alloc] initWithDictionary:dict];
            [self.nData addObject:model];
        }
        [self.nCollection reloadData];
        [self.nCollection headerEndRefreshing];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"--------------------------------------------Error: %@", error);
    }];
}


#pragma mark - collectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView.tag == 111) {
        return self.hData.count;
    }
    if (collectionView.tag == 222) {
        return self.nData.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView.tag == 111) {
        MainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
        MainModle *model = [self.hData objectAtIndex:indexPath.row];
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
        MainModle *model = [self.nData objectAtIndex:indexPath.row];
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
        MainModle *model = [self.hData objectAtIndex:indexPath.row];
        TaoKeWebViewController *taokeVC = [[TaoKeWebViewController alloc] init];
        taokeVC.comeURL = model.buyURL;
        taokeVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:taokeVC animated:YES];
    }
    if (collectionView.tag == 222) {
        MainModle *model = [self.nData objectAtIndex:indexPath.row];
        TaoKeWebViewController *taokeVC = [[TaoKeWebViewController alloc] init];
        taokeVC.comeURL = model.buyURL;
        taokeVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:taokeVC animated:YES];
    }
}

#pragma mark - ButtonAction
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
        if (!_nCollection) {
            [self initnCollectionView];
            [self setupRefresh];
        }
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
        [self changeButton:sender];
    NSLog(@"%ld", sender.tag);
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


#pragma mark - MJ
- (void)setupRefresh
{
    if (self.hCollection.tag == 111) {
        // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
        [self.hCollection addHeaderWithTarget:self action:@selector(headerRereshing)];
        [self.hCollection headerBeginRefreshing];
        
        // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
        [self.hCollection addFooterWithTarget:self action:@selector(footerRereshing)];
        
        // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
        self.hCollection.headerPullToRefreshText = @"✨下拉刷新✨";
        self.hCollection.headerReleaseToRefreshText = @"✨放手刷新✨";
        self.hCollection.headerRefreshingText = @"✨正在刷新✨";
        
        self.hCollection.footerPullToRefreshText = @"✨上拉加载更多数据✨";
        self.hCollection.footerReleaseToRefreshText = @"✨放手加载更多数据✨";
        self.hCollection.footerRefreshingText = @"✨正在加载中✨";
    }
    if (self.nCollection.tag == 222) {
        // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
        [self.nCollection addHeaderWithTarget:self action:@selector(headerRereshing)];
        [self.nCollection headerBeginRefreshing];
        
        // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
        [self.nCollection addFooterWithTarget:self action:@selector(footerRereshing)];
        
        // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
        self.nCollection.headerPullToRefreshText = @"✨下拉刷新✨";
        self.nCollection.headerReleaseToRefreshText = @"✨放手刷新✨";
        self.nCollection.headerRefreshingText = @"✨正在刷新✨";
        
        self.nCollection.footerPullToRefreshText = @"✨上拉加载更多数据✨";
        self.nCollection.footerReleaseToRefreshText = @"✨手加载更多数据✨";
        self.nCollection.footerRefreshingText = @"✨正在加载中✨";
    }
}

//合适时机刷新数据
- (void)headerRereshing
{
    if (self.hCollection.tag == 111) {
        //添加数据
        [self hCollectionRequest];
        //2秒后刷新表格UI(此处直接用,不用修改)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 刷新表格
            [self.hCollection reloadData];
            
            // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
            
        });
    }
    if (self.nCollection.tag == 222) {
        //添加数据
        [self nCollectionRequest];
        //2秒后刷新表格UI(此处直接用,不用修改)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 刷新表格
            [self.nCollection reloadData];
            
            // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
        });    }
}

- (void)footerRereshing
{
    if (self.hCollection.tag == 111) {
        aa += 10;
        for (int i = aa-10; i < aa; i++) {
            NSDictionary *dict = [self.hbData objectAtIndex:i];
            MainModle *model = [[MainModle alloc] initWithDictionary:dict];
            [self.hData addObject:model];
        }
        [self.hCollection reloadData];
        
        
        // 2.2秒后刷新表格UI(此处直接用,不用修改)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 刷新表格
            [self.hCollection reloadData];
            
            // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
            [self.hCollection footerEndRefreshing];
        });
    }
    if (self.nCollection.tag == 222) {
        bb += 10;
        for (int i = bb-10; i < bb; i++) {
            NSDictionary *dict = [self.nbData objectAtIndex:i];
            MainModle *model = [[MainModle alloc] initWithDictionary:dict];
            [self.nData addObject:model];
        }
        [self.nCollection reloadData];
        
        // 2.2秒后刷新表格UI(此处直接用,不用修改)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 刷新表格
            [self.nCollection reloadData];
            
            // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
            [self.nCollection footerEndRefreshing];
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

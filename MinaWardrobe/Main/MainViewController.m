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
    [self initnCollectionView];
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
    self.lineLab = [[UILabel alloc] initWithFrame:CGRectMake(50, 44, WIDTH / self.btnsArr.count - 36, 1)];
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
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager GET:@"http://share.mina.com.cn/getShareGoodsJson.php?action=cate&id=2" parameters:nil success:^(AFHTTPRequestOperation *operation, NSMutableArray *responseObject) {
        for (NSDictionary *dict in responseObject) {
            MainModle *model = [[MainModle alloc] initWithDictionary:dict];
            [self.datasource1 addObject:model];
            [self.hCollection reloadData];
        }
        //        NSLog(@"%@", self.datasource);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"--------------------------------------------Error: %@", error);
    }];
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
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [manager GET:@"http://share.mina.com.cn/getShareGoodsJson.php?action=cate&id=2" parameters:nil success:^(AFHTTPRequestOperation *operation, NSMutableArray *responseObject) {
        for (NSDictionary *dict in responseObject) {
            MainModle *model = [[MainModle alloc] initWithDictionary:dict];
            [self.datasource addObject:model];
            [self.nCollection reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"--------------------------------------------Error: %@", error);
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.datasource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    MainModle *model = [self.datasource objectAtIndex:indexPath.row];
    cell.backgroundColor = [UIColor whiteColor];
    cell.tName.text = model.imageName;
    [cell.tImage sd_setImageWithURL:[NSURL URLWithString:model.imageURL]];
    cell.collectLabel.text = model.collectNumber;
    [cell.collectButton addTarget:self action:@selector(handleCollectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = WIDTH / 2 - 15;
    CGFloat width = 250;
    
    return CGSizeMake(height, width);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(8, 10, 10, 8);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)handleCollectButtonAction:(UIButton *)sender {
    NSLog(@"收藏人数+1");
}



//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if (scrollView.tag == 555) {
//        CGFloat offset_x = scrollView.contentOffset.x / self.btnsArr.count;
//        self.lineLab.frame = CGRectMake(55 + offset_x, self.lineLab.frame.origin.y, self.lineLab.bounds.size.width, self.lineLab.bounds.size.height);
//    }
//}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.tag == 555) {
        CGFloat offset_x = scrollView.contentOffset.x / WIDTH;
        NSLog(@"%f",offset_x);
        self.lineLab.frame = CGRectMake(50 + ((WIDTH - 45) / self.btnsArr.count * offset_x), self.lineLab.frame.origin.y, self.lineLab.bounds.size.width, self.lineLab.bounds.size.height);
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.tag == 555) {
        int a = scrollView.contentOffset.x / 320;
        UIButton *button = (UIButton *)[self.lineLab viewWithTag:a + 100];
        [self changeButton:button];
        for (int i = 0; i < self.lineLab.subviews.count; i++) {
            if ([self.lineLab.subviews[i] isKindOfClass:[UIButton class]]) {
                UIButton *button = (UIButton *)self.lineLab.subviews[i];
                if (button.tag != a + 100) {
                    [self reductionButton:button];
                }
            }
        }
    }
}

- (void)handleNaviButtonAction:(UIButton *)sender {
    NSLog(@"%ld", sender.tag);
    
    [self changeButton:sender];
    [UIView animateWithDuration:0.3 animations:^{
        UIScrollView *scrollView = (UIScrollView *)[self.view viewWithTag:555];
        scrollView.contentOffset = CGPointMake((sender.tag - 100) * self.view.bounds.size.width, 0);
    }];
    for (int i = 0; i < self.lineLab.subviews.count; i++) {
        if ([self.lineLab.subviews[i] isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)self.lineLab.subviews[i];
            if (button.tag != sender.tag) {
                [self reductionButton:button];
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

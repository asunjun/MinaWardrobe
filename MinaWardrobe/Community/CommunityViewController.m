//
//  CommunityViewController.m
//  MinaWardrobe
//
//  Created by apple on 15/5/14.
//  Copyright (c) 2015年 wenxing. All rights reserved.
//

#import "CommunityViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "SVProgressHUD.h"
#import "CommunityTableViewCell.h"
#import "SQmainlist.h"
#import "UIScrollView+MJRefresh.h"
#import "ComNRViewController.h"
#import "UIImageView+WebCache.h"

@interface CommunityViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *_dataSource;
    SQmainlist *list;
    NSInteger _beginNo;
    
}
@end

@implementation CommunityViewController


- (void)viewDidAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];     // Do any additional setup after loading the view from its nib.
    [self.tableview setFrame:CGRectMake(0, 50, WIDTH, HEIGHT-94)];
    
    [self.tableview registerNib:[UINib nibWithNibName:@"CommunityTableViewCell" bundle:nil] forCellReuseIdentifier:@"CommunityTableViewCell"];
    
    _dataSource=[[NSMutableArray alloc]init];
    
    //添加刷新和下拉加载
     _beginNo = 1;
    [self setupRefresh];

    
    
    
}
- (void)setupRefresh
{
   
        // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
        [self.tableview addHeaderWithTarget:self action:@selector(headerRereshing)];
        [self.tableview headerBeginRefreshing];
        
        // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
        [self.tableview addFooterWithTarget:self action:@selector(footerRereshing)];
        
        // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
        self.tableview.headerPullToRefreshText = @"✨下拉刷新✨";
        self.tableview.headerReleaseToRefreshText = @"✨放手刷新✨";
        self.tableview.headerRefreshingText = @"✨正在刷新✨";
        
        self.tableview.footerPullToRefreshText = @"✨上拉加载更多数据✨";
        self.tableview.footerReleaseToRefreshText = @"✨放手加载更多数据✨";
        self.tableview.footerRefreshingText = @"✨正在加载中✨";
    }




- (void)headerRereshing
{
    _beginNo = 1;
   
     [_dataSource removeAllObjects];
        //添加数据
        [self requstdata];
     [self.tableview reloadData];
        //2秒后刷新表格UI(此处直接用,不用修改)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 刷新表格
            
            [self.tableview reloadData];
            
            // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
            
        });
    }

- (void)footerRereshing
{
   _beginNo = _beginNo + 1;
        [self requstdata];
    
        [self.tableview reloadData];
        
        
        // 2.2秒后刷新表格UI(此处直接用,不用修改)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 刷新表格
            [self.tableview reloadData];
            
            // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
            [self.tableview footerEndRefreshing];
        });
    }


//请求
-(void)requstdata{
    [SVProgressHUD show];
    
    NSString *asiurl=[NSString stringWithFormat:@"http://sq.mina.cn/?/sort_type-new__day-0__is_recommend-0__page-%ld",_beginNo];
    
    
      NSURL *url = [NSURL URLWithString:asiurl];
  
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request setUserAgent:@"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML,                                                                                                                                                                                                                                                                                                                                                           Gecko) Chrome/41.0.2272.101 Safari/537.36"];
    
    [request setDelegate:self];
    [request startAsynchronous];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    //return 10;
    
    return _dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   static NSString *CellIdentifier = @"CommunityTableViewCell";
    CommunityTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  //   CommunityTableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    
    if (cell==nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"CommunityTableViewCell" owner:self options:nil] lastObject];
    }
     
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
//    cell.img1=nil;
//    cell.img2=nil;
//    cell.img3=nil;
        SQmainlist *trade = _dataSource[indexPath.row];
        for (int i=0; i<trade.imageurl.count; i++) {
        NSString *imageurls=[trade.imageurl objectAtIndex:i];
        
        switch (i) {
            case 0:
              
               
                [cell.img1 sd_setImageWithURL:[NSURL URLWithString:imageurls]];
                break;
            case 1:
               
                [cell.img2 sd_setImageWithURL:[NSURL URLWithString:imageurls]];
                
                
                break;
            case 2:
                [cell.img3 sd_setImageWithURL:[NSURL URLWithString:imageurls]];
                
                break;
                
            default:
                
                break;
        }
        
        
    }

    
    [cell configCellByTradeModel:_dataSource[indexPath.row]];
    
    return cell;
    
    
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SQmainlist *trade = _dataSource[indexPath.row];
    ComNRViewController *NR=[[ComNRViewController alloc]initWith:trade.idzhi and:trade.imageurl and:trade.category];
    
    
    NR.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:NR animated:YES];
    
    
}


-(NSArray *)con:(SQmainlist *)ma{
    
    
    return ma.imageurl;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
//    
//    CGSize size = [tt sizeWithFont:[UIFont systemFontOfSize:16.0f] constrainedToSize:CGSizeMake(290, 20000)];
//    CGFloat height = size.height;
     CGFloat height = [list.fabuname boundingRectWithSize:CGSizeMake(145, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:35]} context:nil].size.height;
    
    if (height<30) //评论年内容的高度
    {
        height = 30;
    }else{
        height =60;
    }
    
  
    NSArray *a1=[self con:_dataSource[indexPath.row]];
    
 
    if (a1==nil) {
        // height+=20;
    }else{
       height+=80;
        
    }
    
    height+=35;
    
    //加上“评论人”和“时间”Label的高度；
    
    return height;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//正确网址
-(void)requestFinished:(ASIHTTPRequest *)request{
    
     [SVProgressHUD dismiss];
    
    
    
    
    NSString *st1=[request responseString];
    
   
    
    
    
//    
    NSArray *arrayWord = [st1 componentsSeparatedByString:@"â"];
   
    
    NSMutableArray *a1=[[NSMutableArray alloc]initWithObjects:[arrayWord objectAtIndex:0], nil];
  
    NSString *a2=[a1 objectAtIndex:0];
    if ([a2 isEqualToString:@"false"]) {
        return;
        
    }
    
       NSArray *arr = [NSJSONSerialization JSONObjectWithData:[a2 dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"%@",arr);
    

    for (int i=0; i<arr.count; i++) {
        NSDictionary *dic=[arr objectAtIndex:i];
        
        list=[[SQmainlist alloc]initWithDic:dic];
        [_dataSource addObject:list];
       
    }
    
    [self.tableview reloadData];
    [self.tableview headerEndRefreshing];
    
    
    
}
//错误网址
- (void)requestFailed:(ASIHTTPRequest *)request

{
    
    NSError *error = [request error];
    [SVProgressHUD showErrorWithStatus:error.localizedDescription];
    
}



@end

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
#import "PostingViewController.h"

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
    
    UIButton *bt2=[[UIButton alloc]initWithFrame:CGRectMake(WIDTH-50, 20, 40, 30)];
    
    [bt2 addTarget:self action:@selector(dian) forControlEvents:UIControlEventTouchUpInside];
    [bt2 setTitle:@"发帖" forState:UIControlStateNormal];
    [bt2 setBackgroundColor:[UIColor redColor]];
    
    
    [self.footview addSubview:bt2];
    
    [self.footview setFrame:CGRectMake(0, 0, WIDTH, 50)];
    
    [self.tableview setFrame:CGRectMake(0, 50, WIDTH, HEIGHT-94)];
    
    [self.tableview registerNib:[UINib nibWithNibName:@"CommunityTableViewCell" bundle:nil] forCellReuseIdentifier:@"CommunityTableViewCell"];
    
    _dataSource=[[NSMutableArray alloc]init];
    
    //添加刷新和下拉加载
     _beginNo = 1;
    [self setupRefresh];

    
    
    
}

-(void)dian{
    PostingViewController *po=[[PostingViewController alloc]init];
    [self.navigationController pushViewController:po animated:YES];
    
    
    
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
    NSString *localPath = [NSHomeDirectory()stringByAppendingPathComponent:@"Documents"] ;
    NSLog(@"%@",localPath);
    [SVProgressHUD show];
    
    NSString *asiurl=[NSString stringWithFormat:@"http://sq.mina.cn/?/api/getPostList/sort_type-new__day-0__is_recommend-0__page-%ld",_beginNo];
    
    
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
  
    
    if (cell==nil) {
        cell=[[[NSBundle mainBundle]loadNibNamed:@"CommunityTableViewCell" owner:self options:nil] lastObject];
    }
     
    cell.selectionStyle=UITableViewCellSelectionStyleNone;

        SQmainlist *trade = _dataSource[indexPath.row];
    
  //  NSLog(@"%d",trade.imageurl.count);
    cell.img1.image=nil;
    cell.img2.image=nil;
    cell.img3.image=nil;
    
        for (int i=0; i<trade.imageurl.count; i++) {
        NSString *imageurls=[trade.imageurl objectAtIndex:i];
      NSString *st1=[self images:imageurls];
            
        switch (i) {
            case 0:
              
               
                [cell.img1 sd_setImageWithURL:[NSURL URLWithString:st1]];
                break;
            case 1:
               
                [cell.img2 sd_setImageWithURL:[NSURL URLWithString:st1]];
                
                
                break;
            case 2:
                [cell.img3 sd_setImageWithURL:[NSURL URLWithString:st1]];
                
                break;
                
            default:
                
                break;
        }
        
        
    }

    
    [cell configCellByTradeModel:_dataSource[indexPath.row]];
    
    return cell;
    
    
    
    
}

-(NSString *)images:(NSString *)imageurl{
    
    NSString *st1=imageurl;
    
    if([st1 rangeOfString:@"images/"].location !=NSNotFound)//_roaldSearchText
    {
        NSArray *a1=[st1 componentsSeparatedByString:@"images/"];
        NSString *st2=[NSString stringWithFormat:@"%@images/thumb/%@",[a1 objectAtIndex:0],[a1 objectAtIndex:1]];
        NSLog(@"%@",st2);
        
        
        return st2;
        
        NSLog(@"%d",a1.count);
        
        
        NSLog(@"yes");
    }
    else
    {
        NSLog(@"no");
    }

    
    return st1;
    
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
    
    SQmainlist *trade = _dataSource[indexPath.row];
//    
//    CGSize size = [tt sizeWithFont:[UIFont systemFontOfSize:16.0f] constrainedToSize:CGSizeMake(290, 20000)];
//    CGFloat height = size.height;
     CGFloat height = [trade.fabutitle boundingRectWithSize:CGSizeMake(WIDTH-28, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16]} context:nil].size.height;
    NSLog(@"%@",trade.fabutitle);
    
    NSLog(@"%f",height);
    
    CGFloat height1 = [trade.message boundingRectWithSize:CGSizeMake(WIDTH-28, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12]} context:nil].size.height;

       NSLog(@"%f",height1);
    NSArray *a1=[self con:_dataSource[indexPath.row]];
    if (height>20) {
        height=42;
        
    }else{
        height=20;
        
    }
    if (height1>20) {
        height=30+height;
    }else{
        height=height+height1;
        
    }
 
    if (a1.count==0) {
        // height+=20;
    }else{
       height+=80;
        
    }
    
    height+=60;
    
    //加上“评论人”和“时间”Label的高度；
      NSLog(@"%f",height);
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
    NSLog(@"%@",st1);

    if ([st1 isEqualToString:@"false"]) {
        return;
        
    }
    
       NSArray *arr = [NSJSONSerialization JSONObjectWithData:[st1 dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
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

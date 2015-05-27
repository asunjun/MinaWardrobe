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
@interface CommunityViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *_dataSource;
    SQmainlist *list;
    
}
@end

@implementation CommunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];     // Do any additional setup after loading the view from its nib.
    
    [self.tableview registerNib:[UINib nibWithNibName:@"CommunityTableViewCell" bundle:nil] forCellReuseIdentifier:@"CommunityTableViewCell"];
    
    _dataSource=[[NSMutableArray alloc]init];
    
    
    
//    [self.tableview addHeaderWithCallback:^{
//        [self requstdata];
//        
//        
//        
//    } dateKey:@""];
//    
    
//    [self.tableview addLegendHeaderWithRefreshingBlock:^{
//        _beginNo = 1;
//        [self requestData];
//    }];
//    //上拉加载更多
//    [_tableView addLegendFooterWithRefreshingBlock:^{
//        _beginNo = _beginNo + 10;
//        [self requestData];
//    }];
  
    [self requstdata];
    
    
    
}
//请求
-(void)requstdata{
    [SVProgressHUD show];
      NSURL *url = [NSURL URLWithString:@"http://sq.mina.cn/"];
  
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
    
    [cell configCellByTradeModel:_dataSource[indexPath.row]];
//    if(indexPath.row==0||indexPath.row==1){
//        cell.img1.image=[UIImage imageNamed:@"商城.png"];
//         cell.img2.image=[UIImage imageNamed:@"商城.png"];
//         cell.img3.image=[UIImage imageNamed:@"商城.png"];
//    }
//    cell.title.text=@"cdwcvcfvfdudscjkaslchdiwcudwhbcviuodwhcojwowijcdioscoidsjchoiduhcvuifehbgiuewhcjiowjcopwjdilckhudiouchbdiubhcuihceo";
//    cell.img4.image=[UIImage imageNamed:@"商城.png"];
    
    return cell;
    
    
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SQmainlist *trade = _dataSource[indexPath.row];
    ComNRViewController *NR=[[ComNRViewController alloc]initWith:trade.idzhi];
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
    
    NSLog(@"%@",st1);
    
    
    
//    
    NSArray *arrayWord = [st1 componentsSeparatedByString:@"â"];
   
    
    NSMutableArray *a1=[[NSMutableArray alloc]initWithObjects:[arrayWord objectAtIndex:0], nil];
  
    NSString *a2=[a1 objectAtIndex:0];
       NSArray *arr = [NSJSONSerialization JSONObjectWithData:[a2 dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"%@",arr);
    

    for (int i=0; i<arr.count; i++) {
        NSDictionary *dic=[arr objectAtIndex:i];
          NSLog(@"%@",dic);
        list=[[SQmainlist alloc]initWithDic:dic];
        [_dataSource addObject:list];
       
    }
    
    [self.tableview reloadData];
    
    
    
}
//错误网址
- (void)requestFailed:(ASIHTTPRequest *)request

{
    
    NSError *error = [request error];
    [SVProgressHUD showErrorWithStatus:error.localizedDescription];
    
}



@end

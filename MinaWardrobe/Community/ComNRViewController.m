//
//  ComNRViewController.m
//  MinaWardrobe
//
//  Created by 米娜 上海文星广告传媒有限公司 on 15/5/25.
//  Copyright (c) 2015年 wenxing. All rights reserved.
//

#import "ComNRViewController.h"
#import "ASIHTTPRequest.h"
#import "SVProgressHUD.h"
#import "ComNRTableViewCell.h"
#import "ComNRModel.h"
#import "ASIFormDataRequest.h"
#import "ComTwoNRTableViewCell.h"
@interface ComNRViewController ()<UITableViewDataSource,UITableViewDelegate>{
  
    ComNRModel *shuju;
    NSMutableArray *_datasoure;
    
      NSString *_tradeid;
    
}

@end

@implementation ComNRViewController



-(id)initWith:(NSString *)idzhi{

    
    self=[super init];
    
   
    if (self) {
        _tradeid = idzhi;
    }
    return self;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
        [self.table registerNib:[UINib nibWithNibName:@"ComNRTableViewCell" bundle:nil] forCellReuseIdentifier:@"ComNRTableViewCell"];
      [self.table registerNib:[UINib nibWithNibName:@"ComTwoNRTableViewCell" bundle:nil] forCellReuseIdentifier:@"ComTwoNRTableViewCell"];
    _datasoure=[[NSMutableArray alloc]init];
    
    self.navigationController.navigationBar.translucent = NO;
    
    
    
    
     [self requstdata];

    // Do any additional setup after loading the view from its nib.
}
-(void)requstdata{
    [SVProgressHUD show];
    NSString *URLNR=[NSString stringWithFormat:@"http://sq.mina.cn/index.php/article/%@",_tradeid];
    
    
    NSURL *url = [NSURL URLWithString:URLNR];
    
    
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request setUserAgent:@"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML,                                                                                                                                                                                                                                                                                                                                                           Gecko) Chrome/41.0.2272.101 Safari/537.36"];
    
    [request setDelegate:self];
    [request startAsynchronous];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section==0) {
        return 1;
    }
    if (section==1) {
        return 1;
    }
    
    
    return 10;
    
   // return _datasoure.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section==0) {
        static NSString *CellIdentifier = @"ComNRTableViewCell";
        ComNRTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell==nil) {
            
        }
        
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        [cell configCellByTradeModel:nil];
        return cell;

        
    }
    if (indexPath.section==1) {
        static NSString *CellIdentifier = @"ComTwoNRTableViewCell";
        ComTwoNRTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell==nil) {
            
        }
              return cell;
        
    }
    if (indexPath.section==2) {
        static NSString *CellIdentifier = @"ComTwoNRTableViewCell";
        ComTwoNRTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell==nil) {
            
        }
              return cell;
        
    }
    
  
    
    // cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
 //   [cell configCellByTradeModel:_datasoure[indexPath.row]];
    
    return nil;
    
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        
        NSString *st1=@"标题：啊锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕锕";
      
        NSString *st3=@"底的策略飞机饿哦喷雾剂佛锕陪我减肥我发觉锕我非常呢无法内侧为 i 哦腐女次额外付出哪哦我能否次饿哦无法内侧晚饭吃呢哦我吃饭呢哦我 i 吃饭呢哦 win 服从额外 i 付出";
         CGFloat height1 = [st1 boundingRectWithSize:CGSizeMake(145, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} context:nil].size.height;
        
        CGFloat height2=[st3 boundingRectWithSize:CGSizeMake(145, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} context:nil].size.height;
          NSLog(@"%f",height1);
          NSLog(@"%f",height2);
        
        
        CGFloat height=height1+height2+30;
        NSLog(@"%f",height);
        
        return height;
        
        
    }
    
    return 200;
    
}
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
    
    
//    for (int i=0; i<arr.count; i++) {
//        NSDictionary *dic=[arr objectAtIndex:i];
//        NSLog(@"%@",dic);
//        shuju=[[ComNRModel alloc]initWithDic:dic];
//        [_datasoure addObject:shuju];
//        
//    }
//    
//    [self.table reloadData];
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.5;
    
}

//错误网址
- (void)requestFailed:(ASIHTTPRequest *)request

{
    
    NSError *error = [request error];
    [SVProgressHUD showErrorWithStatus:error.localizedDescription];
    
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

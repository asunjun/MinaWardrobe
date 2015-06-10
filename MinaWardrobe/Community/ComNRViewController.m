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
#import "ComtrueTableViewCell.h"
#import "YFInputBar.h"
#import "ComQuestionNRModel.h"
#import "Comcommodel.h"
#import "UIImageView+WebCache.h"
@interface ComNRViewController ()<UITableViewDataSource,UITableViewDelegate,YFInputBarDelegate>{
  
    ComNRModel *shuju;
    ComQuestionNRModel *questionshuju;
    Comcommodel *quescom;
    
    NSString *_title;
    NSString *_message;
    
    NSMutableArray *_datasoure;
    NSArray *_imageurls;
    
      NSString *_tradeid;
    NSString *_catgrop;
    
    
    
}

@end

@implementation ComNRViewController



-(id)initWith:(NSString *)idzhi and:(NSArray *)images and:(NSString *)catgroup{

    
    self=[super init];
    
   
    if (self) {
        _tradeid = idzhi;
        _imageurls=images;
        _catgrop=catgroup;
        
    }
    return self;
    
}
- (void)viewDidLoad {
    NSLog(@"%@",_imageurls);
  //  self.view.userInteractionEnabled=NO;
    
    [self.navigationController setNavigationBarHidden:NO];
    [super viewDidLoad];
    self.table.frame=CGRectMake(0, 0, WIDTH, HEIGHT);
    
        [self.table registerNib:[UINib nibWithNibName:@"ComNRTableViewCell" bundle:nil] forCellReuseIdentifier:@"ComNRTableViewCell"];
      [self.table registerNib:[UINib nibWithNibName:@"ComTwoNRTableViewCell" bundle:nil] forCellReuseIdentifier:@"ComTwoNRTableViewCell"];
    [self.table registerNib:[UINib nibWithNibName:@"ComtrueTableViewCell" bundle:nil] forCellReuseIdentifier:@"ComtrueTableViewCell"];
    _datasoure=[[NSMutableArray alloc]init];
    
    self.navigationController.navigationBar.translucent = NO;
    
    YFInputBar *inputBar = [[YFInputBar alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY([UIScreen mainScreen].bounds)-108, 320, 44)];
    
    inputBar.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
    
    
    inputBar.delegate = self;
    inputBar.clearInputWhenSend = YES;
    inputBar.resignFirstResponderWhenSend = YES;
   
    [self.view addSubview:inputBar];
    
    
     [self requstdata];

    // Do any additional setup after loading the view from its nib.
}

-(void)inputBar:(YFInputBar *)inputBar sendBtnPress:(UIButton *)sendBtn withInputString:(NSString *)str
{
    NSLog(@"%@",str);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [((UIView*)obj) resignFirstResponder];
    }];
}

-(void)requstdata{
    [SVProgressHUD show];
    
    if ([_catgrop isEqual:@"article"]) {
        NSString *URLNR=[NSString stringWithFormat:@"http://sq.mina.cn/?/article/%@",_tradeid];
        NSURL *url = [NSURL URLWithString:URLNR];
        
        NSLog(@"%@",url);
        
        ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
        [request setUserAgent:@"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.101 Safari/537.36"];
        
        [request setDelegate:self];
        [request startAsynchronous];

    }else{
        NSString *URLNR=[NSString stringWithFormat:@"http://sq.mina.cn/?/question/%@",_tradeid];
        NSURL *url = [NSURL URLWithString:URLNR];
        
        NSLog(@"%@",url);
        
        ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
        [request setUserAgent:@"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.101 Safari/537.36"];
        
        [request setDelegate:self];
        [request startAsynchronous];

    }
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_imageurls!=nil) {
        return 3;
    }else{
        return 2;
        
    }
    
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    
    if (_imageurls!=nil) {
        if (section==0) {
            return 1;
        }
        if (section==1) {
            return 1;
        }
        if (section==2) {
            if (_datasoure.count==0) {
                return 1;
            }
            return _datasoure.count;
            
        }

    }else{
        if (section==0) {
            return 1;
        }
        if (section==1) {
            if (_datasoure.count==0) {
                return 1;
            }
            return _datasoure.count;;
        }
        
    }
    
    
    
    return 10;
    
   // return _datasoure.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_imageurls!=nil) {
        if (indexPath.section==0) {
            static NSString *CellIdentifier = @"ComNRTableViewCell";
            ComNRTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (cell==nil) {
                
            }
            
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
               [cell configCellByTradeModel:_title and:_message];
            return cell;
            
            
        }
        if (indexPath.section==1) {
            static NSString *CellIdentifier = @"ComTwoNRTableViewCell";
            ComTwoNRTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (cell==nil) {
                
            }
            
            [cell configCellByTradeModel:nil];
            for (int i=0; i<_imageurls.count; i++) {
                switch (i) {
                    case 0:
                        
                        
                        [cell.img1 sd_setImageWithURL:[NSURL URLWithString:[_imageurls objectAtIndex:i]]];
                        break;
                    case 1:
                        
                        [cell.img2 sd_setImageWithURL:[NSURL URLWithString:[_imageurls objectAtIndex:i]]];
                        
                        
                        break;
                    case 2:
                        [cell.img3 sd_setImageWithURL:[NSURL URLWithString:[_imageurls objectAtIndex:i]]];
                        
                        break;
                        
                    default:
                        
                        break;
                }
                

            }
            
            return cell;
            
        }
        if (indexPath.section==2) {
            static NSString *CellIdentifier = @"ComtrueTableViewCell";
            ComtrueTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (cell==nil) {
                
            }
            if (_datasoure.count==0) {
                UILabel *lab100=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 200)];
                lab100.text=@"暂无消息回复";
                [cell addSubview:lab100];
                return cell;
                
            }
             Comcommodel *trade = _datasoure[indexPath.row];
              [cell configCellByTradeModel:trade.name and:indexPath.row and:nil and:nil and:trade.huifu];
            
            
            
            return cell;
        }
    
    }else{
        if (indexPath.section==0) {
            static NSString *CellIdentifier = @"ComNRTableViewCell";
            ComNRTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (cell==nil) {
                
            }
            
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            [cell configCellByTradeModel:_title and:_message];
            return cell;
            
            
        }

        
        if (indexPath.section==1) {
            static NSString *CellIdentifier = @"ComtrueTableViewCell";
            ComtrueTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (cell==nil) {
                
            }
            NSLog(@"%ld",_datasoure.count);
            if (_datasoure.count==0) {
                UILabel *lab100=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 200)];
                lab100.text=@"暂无消息回复";
                lab100.textAlignment = NSTextAlignmentCenter;
                [cell addSubview:lab100];
                return cell;
                
            }else{
            Comcommodel *trade = _datasoure[indexPath.row];
            [cell configCellByTradeModel:trade.name and:indexPath.row and:nil and:nil and:trade.huifu];
            return cell;

            }
    }
       
   
        
        
    }
    
  
    
    // cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
 //   [cell configCellByTradeModel:_datasoure[indexPath.row]];
    
    return nil;
    
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        
   
         CGFloat height1 = [_title boundingRectWithSize:CGSizeMake(WIDTH, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} context:nil].size.height;
        
        CGFloat height2=[_message boundingRectWithSize:CGSizeMake(WIDTH, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} context:nil].size.height;
          NSLog(@"%f",height1);
          NSLog(@"%f",height2);
        
        
        CGFloat height=height1+height2+50;
        NSLog(@"%f",height);
        
        return height;
        
        
    }
    
    if (_imageurls!=nil) {
        
        if (indexPath.section==1) {
            
            if (_imageurls.count<4) {
                  CGFloat height=_imageurls.count*450;
                 return height;
            }else{
                return 1350;
                
            }
          
           
            
        }
    }else{
        if (indexPath.section==1) {
            
            return 200;
            
        }
        
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
  //   NSLog(@"%@",a1);
    NSString *a2=[a1 objectAtIndex:0];
    NSDictionary *arr = [NSJSONSerialization JSONObjectWithData:[a2 dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"%@",arr);
    
    if ([_catgrop isEqualToString:@"question"]) {
        questionshuju=[[ComQuestionNRModel alloc]initWithDic:arr];
        
        _title=questionshuju.title;
        _message=questionshuju.message;
        for (int i=1; i<questionshuju.dic2.count+1; i++) {
            
            NSDictionary *dic=[questionshuju.dic2 objectForKey:[NSString stringWithFormat:@"%d",i]];
            
            
            quescom=[[Comcommodel alloc]initWithDic:dic];
            [_datasoure addObject:quescom];
            
            
        }
        
        NSLog(@"%@",quescom.name);
       
        
        
        [self.table reloadData];
        
        
        
        
        
        
    }else{
         shuju=[[ComNRModel alloc]initWithDic:arr];
        _title=shuju.title;
        _message=shuju.message;

        
        NSLog(@"%@",_title);
        NSLog(@"%@",_message);

        
        
        NSLog(@"%@",shuju.message);
        [self.table reloadData];
        
    }
    
    
   
    

    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.5;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 4;
}

//错误网址
- (void)requestFailed:(ASIHTTPRequest *)request

{
    
    NSError *error = [request error];
    [SVProgressHUD showErrorWithStatus:error.localizedDescription];
    
}

@end

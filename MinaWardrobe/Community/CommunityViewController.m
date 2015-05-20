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
@interface CommunityViewController ()
@end

@implementation CommunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];     // Do any additional setup after loading the view from its nib.
    

  
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//正确网址
-(void)requestFinished:(ASIHTTPRequest *)request{
    
     [SVProgressHUD dismiss];
    NSString *st1=[request responseString];
    
  //  NSLog(@"%@",st1);
    
    
    
//    
    NSArray *arrayWord = [st1 componentsSeparatedByString:@"â"];
    NSLog(@"%@",[arrayWord objectAtIndex:0]);
    
    
    
    
    
}
//错误网址
- (void)requestFailed:(ASIHTTPRequest *)request

{
    
    NSError *error = [request error];
    [SVProgressHUD showErrorWithStatus:error.localizedDescription];
    
}



@end

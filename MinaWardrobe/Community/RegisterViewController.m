//
//  RegisterViewController.m
//  MinaWardrobe
//
//  Created by apple on 15/5/25.
//  Copyright (c) 2015年 wenxing. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController setNavigationBarHidden:NO];
    self.navigationItem.title = @"注册";
}

- (IBAction)registerButtonAction:(id)sender {
    [self sendRegister];
}

- (void)sendRegister {
    NSURL *url = [NSURL URLWithString:RegisterURL];
    //ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request setPostValue:self.userNameText.text forKey:@"user_name"];
    [request setPostValue:self.passwdText.text   forKey:@"password"];
    [request setPostValue:self.emailText.text  forKey:@"email"];
//    [request setPostValue:@""  forKey:@"job_id"];
//    [request setPostValue:@""  forKey:@"province"];
//    [request setPostValue:@""  forKey:@"signature"];
    [request setPostValue:@"agree"  forKey:@"agreement_chk"];
    [request setPostValue:@"ajax"  forKey:@"_post_type"];
    [request setUseCookiePersistence:YES];
    [request setDelegate:self];
    [request startAsynchronous];
    //    NSLog(@"%@", request);
}

-(void)requestFinished:(ASIHTTPRequest *)request{
    NSString *st1=[request responseString];
//    NSLog(@"%@", st1);
    NSData *data = [st1 dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//    NSLog(@"%@", dict[@"err"]);

    
    if ([[dict objectForKey:@"errno"] intValue] == 1) {
        NSLog(@"注册成功");
    } else {
        NSLog(@"%@", dict[@"err"]);
        [SVProgressHUD showErrorWithStatus:dict[@"err"]];
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

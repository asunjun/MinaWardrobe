//
//  DLViewController.m
//  MinaWardrobe
//
//  Created by 米娜 上海文星广告传媒有限公司 on 15/5/19.
//  Copyright (c) 2015年 wenxing. All rights reserved.
//

#import "DLViewController.h"

@interface DLViewController ()

@end

@implementation DLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden = YES;
    self.userNameText.delegate = self;
    self.passwdText.delegate = self;
    
    UITapGestureRecognizer *deleteKeyboard = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteKeyBoardClick:)];
    deleteKeyboard.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:deleteKeyboard];
    
    //    [self initSth];
    //    [self initFrame];
}

- (void)viewDidAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)initSth {
    self.baseScrollView = [[UIScrollView alloc] init];
    self.baseScrollView.backgroundColor = [UIColor colorWithRed:223 / 255.0 green:159 / 255.0 blue:197 / 255.0 alpha:1];
    self.baseScrollView.contentSize = CGSizeMake(WIDTH, HEIGHT);
    self.baseScrollView.bounces = NO;
    [self.view addSubview:self.baseScrollView];
    self.baseImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BaseImage"]];
    self.baseImageView.backgroundColor = [UIColor greenColor];
    self.baseImageView.userInteractionEnabled = YES;
    [self.baseScrollView addSubview:self.baseImageView];
    
    self.logoImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LoginLOGO"]];
    self.logoImage.backgroundColor = [UIColor blackColor];
    self.logoImage.layer.cornerRadius = 5;
    [self.baseImageView addSubview:self.logoImage];
    
    self.loginView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"UserPass"]];
    self.loginView.backgroundColor = [UIColor whiteColor];
    self.loginView.userInteractionEnabled = YES;
    [self.baseImageView addSubview:self.loginView];
    self.userNameText = [[UITextField alloc] init];
    self.userNameText.placeholder = @"请输入账号";
    self.userNameText.borderStyle = UITextBorderStyleNone;
    [self.loginView addSubview:self.userNameText];
    self.passwdText = [[UITextField alloc] init];
    self.passwdText.placeholder = @"请输入密码";
    self.passwdText.borderStyle = UITextBorderStyleNone;
    [self.loginView addSubview:self.passwdText];
    
    self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginButton.backgroundColor = [UIColor redColor];
    [self.loginButton setBackgroundImage:[UIImage imageNamed:@"LoginButton"] forState:UIControlStateNormal];
    //    [self.loginButton addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.baseImageView addSubview:self.loginButton];
    self.forgetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.forgetButton.backgroundColor = [UIColor redColor];
    [self.forgetButton setTitle:@"忘记密码？" forState:UIControlStateNormal];
    //    [self.forgetButton addTarget:self action:@selector(forgetPasswdAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.baseImageView addSubview:self.forgetButton];
    self.registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.registerButton.backgroundColor = [UIColor redColor];
    [self.registerButton setTitle:@"没有账号？点击快速注册" forState:UIControlStateNormal];
    //    [self.registerButton addTarget:self action:@selector(registerUserNameAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.baseImageView addSubview:self.registerButton];
    
    
    
    self.testButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.testButton.backgroundColor = [UIColor blueColor];
    self.testButton.frame = CGRectMake(20, 20, 50, 50);
    //    [self.testButton addTarget:self action:@selector(testButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.baseImageView addSubview:self.testButton];
}



- (void)initFrame {
    self.baseScrollView.frame = CGRectMake(0, -20, WIDTH, HEIGHT);
    self.baseImageView.frame = CGRectMake(0, 0, self.baseScrollView.contentSize.width, self.baseScrollView.contentSize.height + 20);
    
    self.logoImage.frame = CGRectMake(WIDTH / 2 - 44, HEIGHT / 7, 88, 88);
    
    self.loginView.frame = CGRectMake(50, HEIGHT / 7 + 120, WIDTH - 100, 100);
    self.userNameText.frame = CGRectMake(8, 10, self.loginView.bounds.size.width - 16, 30);
    self.passwdText.frame = CGRectMake(8, 60, self.loginView.bounds.size.width - 16, 30);
    
    self.loginButton.frame = CGRectMake(50, HEIGHT / 7 + 240, WIDTH - 100, 30);
    self.forgetButton.frame = CGRectMake(50, HEIGHT / 7 + 300, WIDTH - 100, 30);
    self.registerButton.frame = CGRectMake(50, HEIGHT / 7 + 340, WIDTH - 100, 30);
}

#pragma mark - 按钮们
//- (void)loginButtonAction:(UIButton *)sender {
//    [self sendLogin];
//}
- (IBAction)LoginButtonClick:(id)sender {
    [self sendLogin];
    NSLog(@"登陆");
}


//- (void)forgetPasswdAction:(UIButton *)sender {
//
//}
- (IBAction)forgetPasswdButtonClick:(id)sender {
    NSLog(@"忘记密码");
}


//- (void)registerUserNameAction:(UIButton *)sender {
//    RegisterViewController *regVC = [[RegisterViewController alloc] init];
//    [self.navigationController pushViewController:regVC animated:YES];
//}
- (IBAction)registerButtonClick:(id)sender {
    RegisterViewController *regVC = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:regVC animated:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.userNameText resignFirstResponder];
    [self.passwdText resignFirstResponder];
    return YES;
}

- (void)deleteKeyBoardClick:(UIGestureRecognizer *)sender {
    [self.userNameText resignFirstResponder];
    [self.passwdText resignFirstResponder];
}

#pragma mark - 网络请求
- (void)sendLogin {
    NSURL *url = [NSURL URLWithString:@"http://sq.mina.cn/index.php/account/ajax/login_process/"];
    //ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request setPostValue:self.userNameText.text forKey:@"user_name"];
    [request setPostValue:self.passwdText.text   forKey:@"password"];
    [request setUseCookiePersistence:YES];
    [request setDelegate:self];
    [request startAsynchronous];
    
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    for (NSHTTPCookie *cookie in cookies) {
        NSLog(@"cookie: %@", cookie);
    }
}

- (void)testButtonAction {
    NSURL *url = [NSURL URLWithString:@"http://sq.mina.cn/?/api/"];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];
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

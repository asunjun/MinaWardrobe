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
    
    [self initSth];
    [self initFrame];
}

- (void)initSth {
    self.baseScrollView = [[UIScrollView alloc] init];
    self.baseScrollView.backgroundColor = [UIColor yellowColor];
    self.baseScrollView.contentSize = CGSizeMake(WIDTH, HEIGHT + 200);
    [self.view addSubview:self.baseScrollView];
    self.baseImageView = [[UIImageView alloc] init];
    self.baseImageView.backgroundColor = [UIColor greenColor];
    [self.baseScrollView addSubview:self.baseImageView];
    
    self.logoImage = [[UIImageView alloc] init];
    self.logoImage.backgroundColor = [UIColor blackColor];
    self.logoImage.layer.cornerRadius = 5;
    [self.baseImageView addSubview:self.logoImage];
    
    self.loginView = [[UIView alloc] init];
    self.loginView.backgroundColor = [UIColor whiteColor];
    [self.baseImageView addSubview:self.loginView];
    self.userNameText = [[UITextField alloc] init];
    self.userNameText.placeholder = @"111";
    self.userNameText.borderStyle = UITextBorderStyleBezel;
    [self.loginView addSubview:self.userNameText];
    self.passwdText = [[UITextField alloc] init];
    self.passwdText.placeholder = @"222";
    self.passwdText.borderStyle = UITextBorderStyleBezel;
    [self.loginView addSubview:self.passwdText];
    self.lineImage = [[UIImageView alloc] init];
    self.lineImage.backgroundColor = [UIColor blackColor];
    [self.loginView addSubview:self.lineImage];
    
    self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginButton.backgroundColor = [UIColor redColor];
    [self.loginButton setTitle:@"登陆" forState:UIControlStateNormal];
    [self.baseImageView addSubview:self.loginButton];
    self.forgetButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.forgetButton.backgroundColor = [UIColor redColor];
    [self.forgetButton setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [self.baseImageView addSubview:self.forgetButton];
    self.registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.registerButton.backgroundColor = [UIColor redColor];
    [self.registerButton setTitle:@"没有账号？点击快速注册" forState:UIControlStateNormal];
    [self.baseImageView addSubview:self.registerButton];
}

- (void)initFrame {
    self.baseScrollView.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    self.baseImageView.frame = CGRectMake(0, 0, self.baseScrollView.contentSize.width, self.baseScrollView.contentSize.height);
    
    self.logoImage.frame = CGRectMake(WIDTH / 2 - 44, HEIGHT / 7, 88, 88);
    
    self.loginView.frame = CGRectMake(50, HEIGHT / 7 + 120, WIDTH - 100, 100);
    self.userNameText.frame = CGRectMake(8, 10, self.loginView.bounds.size.width - 16, 30);
    self.passwdText.frame = CGRectMake(8, 60, self.loginView.bounds.size.width - 16, 30);
    self.lineImage.frame = CGRectMake(0, 50, self.loginView.bounds.size.width, 1);
    
    self.loginButton.frame = CGRectMake(50, HEIGHT / 7 + 240, WIDTH - 100, 30);
    self.forgetButton.frame = CGRectMake(50, HEIGHT / 7 + 300, WIDTH - 100, 30);
    self.registerButton.frame = CGRectMake(50, HEIGHT / 7 + 340, WIDTH - 100, 30);
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

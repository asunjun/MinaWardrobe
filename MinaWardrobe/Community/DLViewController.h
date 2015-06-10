//
//  DLViewController.h
//  MinaWardrobe
//
//  Created by 米娜 上海文星广告传媒有限公司 on 15/5/19.
//  Copyright (c) 2015年 wenxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisterViewController.h"

@interface DLViewController : UIViewController<ASIHTTPRequestDelegate, UITextFieldDelegate>

/*
//底层
@property (strong, nonatomic) IBOutlet UIScrollView *baseScrollView;
@property (strong, nonatomic) IBOutlet UIImageView *baseImageView;

@property (strong, nonatomic) IBOutlet UIImageView *logoImage;
//登陆框
@property (strong, nonatomic) IBOutlet UIView *loginView;
@property (strong, nonatomic) IBOutlet UITextField *userNameText;
@property (strong, nonatomic) IBOutlet UITextField *passwdText;
@property (strong, nonatomic) IBOutlet UIImageView *lineImage;
//其他
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UIButton *forgetButton;
@property (strong, nonatomic) IBOutlet UIButton *registeredButton;
*/

@property (nonatomic, strong) UIScrollView *baseScrollView;
@property (nonatomic, strong) UIImageView *baseImageView;

@property (nonatomic, strong) UIImageView *logoImage;

@property (nonatomic, strong) UIImageView *loginView;
//@property (nonatomic, strong) UITextField *userNameText;
//@property (nonatomic, strong) UITextField *passwdText;
@property (strong, nonatomic) IBOutlet UITextField *userNameText;
@property (strong, nonatomic) IBOutlet UITextField *passwdText;

@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *forgetButton;
@property (nonatomic, strong) UIButton *registerButton;

@property (nonatomic, strong) UIButton *testButton;





@end

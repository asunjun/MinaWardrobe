//
//  DLViewController.h
//  MinaWardrobe
//
//  Created by 米娜 上海文星广告传媒有限公司 on 15/5/19.
//  Copyright (c) 2015年 wenxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DLViewController : UIViewController

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

@property (nonatomic, strong) UIView *loginView;
@property (nonatomic, strong) UITextField *userNameText;
@property (nonatomic, strong) UITextField *passwdText;
@property (nonatomic, strong) UIImageView *lineImage;

@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *forgetButton;
@property (nonatomic, strong) UIButton *registerButton;





@end

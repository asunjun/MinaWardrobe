//
//  MySeetingViewController.m
//  MinaWardrobe
//
//  Created by apple on 15/5/14.
//  Copyright (c) 2015年 wenxing. All rights reserved.
//

#import "MySeetingViewController.h"

#import "DLViewController.h"
#import "PostingViewController.h"

@interface MySeetingViewController ()

@end

@implementation MySeetingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(200, 200, 100, 40)];
    lab.text = @"我的";
    lab.backgroundColor=globalColor;
    
    [self.view addSubview:lab];
}
- (IBAction)loginButton:(id)sender {
    DLViewController *loginVC = [[DLViewController alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
}
- (IBAction)postingButton:(id)sender {
    PostingViewController *postVC = [[PostingViewController alloc] init];
    [self.navigationController pushViewController:postVC animated:YES];
//    [self.navigationController presentViewController:postVC animated:YES completion:^{
//        
//    }];
//    [self presentViewController:postVC animated:YES completion:^{
//        postVC.modalPresentationStyle = UIModalPresentationPopover;
//    }];
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

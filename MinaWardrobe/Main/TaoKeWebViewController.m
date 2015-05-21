//
//  TaoKeWebViewController.m
//  MinaWardrobe
//
//  Created by apple on 15/5/21.
//  Copyright (c) 2015年 wenxing. All rights reserved.
//

#import "TaoKeWebViewController.h"

@interface TaoKeWebViewController ()

@end

@implementation TaoKeWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.translucent = NO;
    self.taokeWeb.delegate = self;
    [self.taokeWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.comeURL]]];
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

//
//  PostingViewController.m
//  MinaWardrobe
//
//  Created by apple on 15/5/28.
//  Copyright (c) 2015年 wenxing. All rights reserved.
//

#import "PostingViewController.h"

@interface PostingViewController ()

@end

@implementation PostingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.naviView.backgroundColor = [UIColor greenColor];
    [self.tView registerNib:[UINib nibWithNibName:@"PostingTextTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"Cell"];
    [self.tView registerNib:[UINib nibWithNibName:@"PostingMapTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"MapCell"];
    [self.tView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"OCell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    };
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *imageCell = @"Cell";
    static NSString *mapCell = @"MapCell";
    static NSString *otherCell = @"OCell";
    if (indexPath.section == 0 && indexPath.row == 0) {
        PostingTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:imageCell forIndexPath:indexPath];
        return cell;
    } else if (indexPath.section == 0 && indexPath.row == 1) {
        PostingMapTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mapCell forIndexPath:indexPath];
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:otherCell forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:otherCell];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 150;
    }
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1;
}

- (IBAction)cancelButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (IBAction)sendButtonAction:(id)sender {
    
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

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
    [self.tView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"TCell"];
    
    self.imaArray = [[NSMutableArray alloc] init];
    
    self.addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.addButton addTarget:self action:@selector(addImageButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.addButton.backgroundColor = [UIColor redColor];
}

#pragma mark - TableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 2;
    if ([tableView isEqual:self.tView]) {
        return 2;
    } else if ([tableView isEqual:self.listView]) {
        return 1;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if (section == 0) {
//        return 3;
//    };
//    return 1;
    if ([tableView isEqual:self.tView]) {
        if (section == 0) {
            return 3;
        }
        return 1;
    } else if ([tableView isEqual:self.listView]) {
        return 6;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView isEqual:self.tView]) {
    
    
    static NSString *imageCell = @"Cell";
    static NSString *mapCell = @"MapCell";
    static NSString *titleCell = @"TCell";
    static NSString *otherCell = @"OCell";
    if (indexPath.section == 0 && indexPath.row == 1) {
        PostingTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:imageCell forIndexPath:indexPath];
        
        self.textView = [[UITextView alloc] initWithFrame:CGRectMake(5, 5, WIDTH - 10, 80)];
        self.textView.backgroundColor = [UIColor blueColor];
        self.textView.delegate = self;
        
        self.listButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.listButton.frame = CGRectMake(WIDTH - 130, 90, 120, 30);
        self.listButton.backgroundColor = [UIColor redColor];
        [self.listButton addTarget:self action:@selector(listButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        self.listView = [[UITableView alloc] initWithFrame:CGRectMake(WIDTH - 130, 120, 120, 200) style:UITableViewStylePlain];
        self.listView.backgroundColor = [UIColor purpleColor];
        self.listView.hidden = YES;
        self.listView.userInteractionEnabled = NO;
        
        [cell addSubview:self.listButton];
        [cell addSubview:self.textView];
        [cell addSubview:self.addButton];
        [cell addSubview:self.listView];
        
        if (self.imaArray.count < 4) {
            for (int i = 0; i < self.imaArray.count; i++) {
                UIImageView *imaView = [[UIImageView alloc] init];
                imaView.frame = CGRectMake(5 + ((50 * self.imaArray.count + self.imaArray.count + 6) / self.imaArray.count * i), 90, 50, 50);
//                NSLog(@"X : %f, Y : %f", imaView.frame.origin.x, imaView.frame.origin.y);
                imaView.backgroundColor = [UIColor blueColor];
                imaView.image = self.imaArray[i];
                [cell.contentView addSubview:imaView];
            }
        } else {
            NSLog(@"滚");
        }
        if (self.imaArray.count == 0) {
            self.addButton.frame = CGRectMake(5, 90, 50, 50);
        } else if (self.imaArray.count == 1) {
            self.addButton.frame = CGRectMake(58, 90, 50, 50);
        } else if (self.imaArray.count == 2) {
            self.addButton.frame = CGRectMake(111, 90, 50, 50);
        } else {
            self.addButton.frame = CGRectMake(164, 90, 50, 50);
            self.addButton.hidden = YES;
        }
        return cell;
    } else if (indexPath.section == 0 && indexPath.row == 2) {
        PostingMapTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mapCell forIndexPath:indexPath];
        return cell;
    } else if (indexPath.section == 0 && indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:titleCell forIndexPath:indexPath];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:titleCell];
        }
        self.titleTextField = [[UITextField alloc] initWithFrame:CGRectMake(5, 0, WIDTH - 5, 44)];
        self.titleTextField.backgroundColor = [UIColor redColor];
        self.titleTextField.delegate = self;
        [cell addSubview:self.titleTextField];
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:otherCell forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:otherCell];
    }
    self.testView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 300)];
    self.testView.backgroundColor = [UIColor yellowColor];
    [cell addSubview:self.testView];
    return cell;
    } else if ([tableView isEqual:self.listView]) {
        static NSString *listCell = @"listCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:listCell forIndexPath:indexPath];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:listCell];
        }
        cell.textLabel.text = [NSString stringWithFormat:@"123"];
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([tableView isEqual:self.tView]) {
        if (indexPath.section == 0 && indexPath.row == 1) {
            return 150;
        } else if (indexPath.section == 1 && indexPath.row == 0) {
            return 300;
        }
        return 30;
        
    } else if ([tableView isEqual:self.listView]) {
        return 10;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1;
}









#pragma marl - ButtonAction

- (IBAction)cancelButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (IBAction)sendButtonAction:(id)sender {
    NSLog(@"发送");
    NSLog(@"%ld", self.imaArray.count);
    
    NSURL *url = [NSURL URLWithString:@"http://sq.mina.cn/?/api/sendPost/"];
    //ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request setPostValue:self.titleTextField.text forKey:@"question_content"];
    [request setPostValue:self.textView.text   forKey:@"question_detail"];
    [request setUserAgent:@"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML,                                                                                                                                                                                                                                                                                                                                                           Gecko) Chrome/41.0.2272.101 Safari/537.36"];
   
    [request setDelegate:self];
    [request startAsynchronous];
}


-(void)requestFinished:(ASIHTTPRequest *)request{
    self.testStr =[request responseString];
//    NSData *data = [st1 dataUsingEncoding:NSUTF8StringEncoding];
//    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//    if ([[dict objectForKey:@"errno"] intValue] == 1) {
//        NSLog(@"登陆成功");
//    } else {
//        NSLog(@"失败");
//    }
    NSLog(@"*******%@", self.testStr);
    self.testView.text = self.testStr;
}

- (void)addImageButtonAction:(UIButton *)sender {
    NSLog(@"添加照片");
    ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initImagePicker];
    elcPicker.maximumImagesCount = 3; //选择图像的最大数量设置为9
    elcPicker.returnsOriginalImage = YES; //只返回fullScreenImage,不是fullResolutionImage
    elcPicker.returnsImage = YES; //如果是的 返回UIimage。如果没有,只返回资产位置信息
    elcPicker.onOrder = YES; //对多个图像选择、显示和返回的顺序选择图像
    elcPicker.mediaTypes = @[(NSString *)kUTTypeImage]; //支持图片和电影类型
    elcPicker.imagePickerDelegate = self;
    [self presentViewController:elcPicker animated:YES completion:nil];
}

- (void)listButtonClick:(UIButton *)sender {
    NSLog(@"分类列表");
//    self.listView.hidden = NO;
//    self.listView.userInteractionEnabled = YES;
//    if (self.listView.hidden == NO) {
//        self.listView.hidden = YES;
//        self.listView.userInteractionEnabled = NO;
//    }
}


#pragma mark - 选择照片
//相册
- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"%@", info);
    for (NSDictionary *dict in info) {
        if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypePhoto){
            if ([dict objectForKey:UIImagePickerControllerOriginalImage]){
                //把图片取出来放到数组里面
                UIImage* image=[dict objectForKey:UIImagePickerControllerOriginalImage];
                if (self.imaArray.count < 4) {
                    [self.imaArray addObject:image];
                } else {
                    NSLog(@"111111111111");
                }
            }
        }else {
            // NSLog(@"UIImagePickerControllerReferenceURL = %@", dict);
        }
    }
    [self.tView reloadData];
}




#pragma mark - Text限制字数
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@""])
    {
        return YES;
    }
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (self.titleTextField)
    {
        if ([toBeString length] > 20) {
            self.titleTextField.text = [toBeString substringToIndex:6];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"超过最大字数不能输入了" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
            return NO;
        }
    }
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@""]) {
        return YES;
    }
    if (range.location >= 500 || [text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"超过最大字数不能输入了" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    } else {
        return YES;
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    //该判断用于联想输入
    if (textView.text.length >= 500)
    {
        textView.text = [textView.text substringToIndex:10];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"超过最大字数不能输入了" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.titleTextField resignFirstResponder];
    [self.textView resignFirstResponder];
    return YES;
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

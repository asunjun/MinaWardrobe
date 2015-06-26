//
//  PostingViewController.m
//  MinaWardrobe
//
//  Created by apple on 15/5/28.
//  Copyright (c) 2015年 wenxing. All rights reserved.
//

#import "PostingViewController.h"

@interface PostingViewController ()<UIScrollViewDelegate>

//@property (nonatomic, strong) UIImageView *scrollImageView;
//@property (nonatomic, strong) UIScrollView *imageScrollView;

@end

@implementation PostingViewController
static int i=0;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self requstdata];
    [self initTview];
    [self initNavi];
    [self initOther];
    [self initArr];
    [self initIma];
    
//    [self registerForKeyboardNotifications];
    
    self.arrrr = [[NSMutableArray alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

#pragma mark - init
- (void)initTview {
    [self.tView registerNib:[UINib nibWithNibName:@"PostingTextTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"Cell"];
    [self.tView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"OCell"];
    [self.tView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"TCell"];
}

- (void)initNavi {
    self.navigationController.navigationBar.translucent = NO;
    UIBarButtonItem *sendButton = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(sendButtonClick:)];
    self.navigationItem.rightBarButtonItem = sendButton;
}

- (void)initOther {
    self.addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.addButton addTarget:self action:@selector(addImageButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.addButton.backgroundColor = [UIColor blueColor];
//    self.addButton.frame = CGRectMake(5, 5, 50, 50);
    
    self.classButtonView = [[UIView alloc] init];
    self.classButtonView.frame = CGRectMake(WIDTH - 125, 170, 120, 150);
    self.classButtonView.backgroundColor = [UIColor lightGrayColor];
    self.classButtonView.hidden = YES;
    _show = NO;

    self.imageArrView = [[UIView alloc] init];
    self.imageArrView.frame = CGRectMake(0, 145, 230, 60);
//    self.imageArrView.backgroundColor = [UIColor yellowColor];
    
    self.listButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.listButton.frame = CGRectMake(WIDTH - 125, 145, 120, 30);
    self.listButton.backgroundColor = [UIColor lightGrayColor];
    [self.listButton addTarget:self action:@selector(listButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(5, 5, WIDTH - 10, 140)];
    self.textView.font = [UIFont systemFontOfSize:20];
    self.textView.delegate = self;
    
    self.titleTextField = [[UITextField alloc] initWithFrame:CGRectMake(5, 0, WIDTH - 5, 44)];
    self.titleTextField.delegate = self;
}

- (void)initArr {
    self.listArray = [[NSMutableArray alloc] init];
    self.valueArray = [[NSMutableArray alloc] init];
    self.imaArray = [[NSMutableArray alloc] init];
}

- (void)initIma {
    self.ima1 = [[UIImageView alloc] init];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bigImageClick:)];
    [self.ima1 addGestureRecognizer:tap1];
    self.ima1.userInteractionEnabled = YES;
    self.ima1.frame = CGRectMake(5, 5, 50, 50);
    self.ima1.backgroundColor = [UIColor greenColor];
    
    self.ima2 = [[UIImageView alloc] init];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bigImage1Click:)];
    [self.ima2 addGestureRecognizer:tap2];
    self.ima2.userInteractionEnabled = YES;
    self.ima2.frame = CGRectMake(65, 5, 50, 50);
    self.ima2.backgroundColor = [UIColor greenColor];
    
    self.ima3 = [[UIImageView alloc] init];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bigImage2Click:)];
    [self.ima3 addGestureRecognizer:tap3];
    self.ima3.userInteractionEnabled = YES;
    self.ima3.frame = CGRectMake(125, 5, 50, 50);
    self.ima3.backgroundColor = [UIColor greenColor];
    
    self.dBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.dBtn1.frame = CGRectMake(50, 0, 10, 10);
    self.dBtn1.backgroundColor = [UIColor purpleColor];
    self.dBtn1.tag = 0;
    [self.dBtn1 addTarget:self action:@selector(deleteImageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.dBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.dBtn2.frame = CGRectMake(110, 0, 10, 10);
    self.dBtn2.backgroundColor = [UIColor purpleColor];
    self.dBtn2.tag = 1;
    [self.dBtn2 addTarget:self action:@selector(deleteImageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.dBtn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.dBtn3.frame = CGRectMake(170, 0, 10, 10);
    self.dBtn3.backgroundColor = [UIColor purpleColor];
    self.dBtn3.tag = 2;
    [self.dBtn3 addTarget:self action:@selector(deleteImageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)bigImageClick:(UITapGestureRecognizer *)sender {
//    [self showScrollView:self.imaArray];
    [self showScrollView:self.imaArray setValue:0];
    NSLog(@"111");
}
- (void)bigImage1Click:(UITapGestureRecognizer *)sender {
//    [self showImage:self.ima2];
    [self showScrollView:self.imaArray setValue:1];
    NSLog(@"111");
}
- (void)bigImage2Click:(UITapGestureRecognizer *)sender {
//    [self showImage:self.ima3];
    [self showScrollView:self.imaArray setValue:2];
    NSLog(@"111");
}

/*
- (void)registerForKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShow:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(keyboardWasHidden:) name:UIKeyboardDidHideNotification object:nil];
}

- (void) keyboardWasShow:(NSNotification *) notif
{
    NSDictionary *info = [notif userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    
    NSLog(@"keyBoard:%f", keyboardSize.height);  //216
    NSLog(@"%ld", self.imaArray.count);
    ///keyboardWasShown = YES;
    
    self.imageArrView.frame = CGRectMake(5, keyboardSize.height, 230, 56);
    
}
- (void) keyboardWasHidden:(NSNotification *) notif
{
    NSDictionary *info = [notif userInfo];
    
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    NSLog(@"keyboardWasHidden keyBoard:%f", keyboardSize.height);
    // keyboardWasShown = NO;
    
    self.imageArrView.frame = CGRectMake(5, 85 + 160, 230, 60);
}
*/


#pragma mark - 图片点击放大
- (void)showScrollView:(NSMutableArray *)bigImage setValue:(NSInteger)value {
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    UIView *backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    //    oldframe=[avatarImageView convertRect:avatarImageView.bounds toView:window];
    backgroundView.backgroundColor=[UIColor blackColor];
    backgroundView.alpha=1;
    
    UILabel *imageNum = [[UILabel alloc] initWithFrame:CGRectMake(0, HEIGHT - 40, WIDTH, 30)];
    imageNum.backgroundColor = [UIColor darkGrayColor];
    imageNum.textColor = [UIColor whiteColor];
    imageNum.text = [NSString stringWithFormat:@"%ld/%ld", value, bigImage.count];
    [backgroundView addSubview:imageNum];
    
    UIScrollView *bigScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    bigScrollView.backgroundColor = [UIColor clearColor];
    bigScrollView.delegate = self;
    bigScrollView.contentSize = CGSizeMake(WIDTH * bigImage.count, HEIGHT);
    bigScrollView.pagingEnabled = YES;
    bigScrollView.contentOffset = CGPointMake(WIDTH * value, 0);
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideScrollView:)];
    [backgroundView addGestureRecognizer:tap];
    [window addSubview:backgroundView];
    
    for (int i = 0; i < bigImage.count; i++) {
        CGRect frame = CGRectMake(WIDTH * i, 0, WIDTH, HEIGHT);
        UIScrollView *smallScrollView = [[UIScrollView alloc] initWithFrame:frame];
        smallScrollView.delegate = self;
        smallScrollView.tag = 200 + i;
        smallScrollView.backgroundColor = [UIColor clearColor];
        
        UIImage *image = [[UIImage alloc] init];
        image = bigImage[i];
        NSLog(@"%@", image);
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.tag = 100 + i;
        imageView.userInteractionEnabled = YES;
        CGFloat height = image.size.height * WIDTH / image.size.width;
        imageView.frame = CGRectMake(0, (HEIGHT - height) / 2, WIDTH, height);
        smallScrollView.minimumZoomScale = 1;
        smallScrollView.maximumZoomScale = 2;
        smallScrollView.zoomScale = 1;
        smallScrollView.bouncesZoom = YES;
        
        [smallScrollView addSubview:imageView];
        [bigScrollView addSubview:smallScrollView];
    }
    [backgroundView addSubview:bigScrollView];
}

-(void)hideScrollView:(UITapGestureRecognizer*)tap{
    UIView *backgroundView=tap.view;
    UIImageView *imageView=(UIImageView*)[tap.view viewWithTag:1];
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=CGRectMake(0, 0, 0, 0);
        backgroundView.alpha=0;
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
    }];
}

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return [scrollView viewWithTag:scrollView.tag - 100];
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
    [scrollView setZoomScale:scale animated:NO];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGPoint offset = scrollView.contentOffset;
    int currentIndex = offset.x / scrollView.bounds.size.width;
    //移动后改回原来大小
    ((UIScrollView *)[scrollView viewWithTag:200 + currentIndex + 1]).zoomScale = 1;
    ((UIScrollView *)[scrollView viewWithTag:200 + currentIndex - 1]).zoomScale = 1;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    CGFloat delta_x = (scrollView.bounds.size.width > scrollView.contentSize.width) ? (scrollView.bounds.size.width - scrollView.contentSize.width) / 2 : 0.0;
    CGFloat delta_y = (scrollView.bounds.size.height > scrollView.contentSize.height) ? (scrollView.bounds.size.height - scrollView.contentSize.height) / 2 : 0.0;
    [scrollView viewWithTag:scrollView.tag - 100].center = CGPointMake(scrollView.contentSize.width / 2 + delta_x, scrollView.contentSize.height / 2 + delta_y);
}


/*

- (void)showScrollView:(UIImageView *)bigImage {
    self.scrollImage = [[UIImage alloc] init];
    self.scrollImageView = [[UIImageView alloc] init];
    
    self.imageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    self.imageScrollView.backgroundColor = [UIColor blackColor];
    self.imageScrollView.delegate = self;
    self.imageScrollView.contentSize = CGSizeMake(WIDTH * self.imaArray.count, HEIGHT);
    self.imageScrollView.pagingEnabled = YES;
    UIImage *imaaaaaaa = [[UIImage alloc] init];
    
    for (int i = 0; i < self.imaArray.count; i++) {
       
        CGFloat height = self.scrollImage.size.height * WIDTH / self.scrollImage.size.width;
        self.scrollImageView=[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH * i, 0, WIDTH, HEIGHT)];
         self.scrollImage = self.imaArray[i];
        self.scrollImageView.image=self.scrollImage;
        
        NSLog(@"%@", self.scrollImageView);
        self.scrollImageView.tag=1;
        [self.imageScrollView addSubview:self.scrollImageView];
    }
    
//    UIImage *image=self.scrollImage;
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
//    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH * self.imaArray.count, HEIGHT)];
//    imageView.image=self.scrollImage;
//    NSLog(@"%@", imageView);
//    imageView.tag=1;
    
    
    
    [window addSubview:self.imageScrollView];

    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    [self.imageScrollView addGestureRecognizer: tap];
    
    
    [UIView animateWithDuration:0.3 animations:^{
//        CGFloat height = self.scrollImage.size.height * WIDTH / self.scrollImage.size.width;
//        self.scrollImageView.frame=CGRectMake(WIDTH * self.imaArray.count, 0, WIDTH, height);
        self.imageScrollView.alpha=1;
    } completion:^(BOOL finished) {
    
    }];
}

-(void)hideScrollView:(UITapGestureRecognizer*)tap{
    UIView *backgroundView=tap.view;
    UIImageView *imageView=(UIImageView*)[tap.view viewWithTag:1];
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=CGRectMake(0, 0, 0, 0);
        backgroundView.alpha=0;
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
    }];
}
*/



#pragma mark - 网络请求
-(void)requstdata{
    NSString *asiurl=[NSString stringWithFormat:ClassifyURL];
    NSURL *url = [NSURL URLWithString:asiurl];
    
    ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:url];
    //    [request setUserAgent:@"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML,                                                                                                                                                                                                                                                                                                                                                           Gecko) Chrome/41.0.2272.101 Safari/537.36"];
    [request setDelegate:self];
    [request startAsynchronous];
}

- (void)sendTitleText {
    NSURL *url = [NSURL URLWithString:SendTextURL];
    //ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    [request setPostValue:self.titleTextField.text forKey:@"question_content"];
    
     NSString *sendStr =[NSString stringWithFormat:@"%@%@",self.textView.text,self.imageStr];
    
    
    [request setPostValue:sendStr   forKey:@"question_detail"];
    [request setName:@"Title"];
    NSLog(@"%@", sendStr);
//    [request setPostValue:self.imageStr forKey:@"question_detail"];
    [request setPostValue:self.valueStr forKey:@"category_id"];
    [request setUserAgent:@"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML,                                                                                                                                                                                                                                                                                                                                                           Gecko) Chrome/41.0.2272.101 Safari/537.36"];
//    NSLog(@"%@", self.textView.text);
//    NSLog(@"%@", self.valueStr);
        //    [request setUseCookiePersistence:YES];
    [request setDelegate:self];
    [request startAsynchronous];
}

- (void)sendImage {
    for (int i = 0; i < self.imaArray.count; i++) {
        UIImage *ima = [self.imaArray objectAtIndex:i];
        UIImage *newImage = [self imageCompressForWidth:ima targetWidth:320];
        NSURL *url = [NSURL URLWithString:SendImageURL];
        //ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
        ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
//        NSLog(@"%@", ima);
        [request setData:UIImagePNGRepresentation(newImage) forKey:@"file"];
        [request setName:@"Ima"];
        [request setDelegate:self];
        [request startAsynchronous];
//        NSLog(@"=======%f,%f=========", newImage.size.width, newImage.size.height);
    }
    //    [request setUseCookiePersistence:YES];
}

-(void)requestFinished:(ASIHTTPRequest *)request{
    self.xmlStr = [[NSString alloc]initWithData:[request responseData] encoding:NSUTF8StringEncoding];
    [self start];
    
    if ([request.name isEqualToString:@"Ima"]) {
        NSString *str =[request responseString];
        NSString *st1=[NSString stringWithFormat:@"[img]%@[/img]",str];
        NSMutableArray *arr = [NSMutableArray arrayWithObject:st1];
        [self.arrrr addObjectsFromArray:arr];
        i+=1;
    }
    self.imageStr = [self.arrrr componentsJoinedByString:@""];
    if (self.imaArray.count != 0) {
        if (i==self.imaArray.count) {
            [self sendTitleText];
            i=0;
            NSString *str =[request responseString];
            NSLog(@"%@", str);
        }
    }
    if ([request.name isEqualToString:@"Title"]) {
        NSString *str =[request responseString];
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@", dict);
        if ([[dict objectForKey:@"errno"] intValue] == -1) {
            NSLog(@"登陆成功");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"发送成功" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [alert show];
        } else {
            NSLog(@"失败");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"发送失败" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    NSString *str = [request responseString];
    NSLog(@"%@", str);
}

#pragma mark - TableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *imageCell = @"Cell";
    static NSString *titleCell = @"TCell";
    if (indexPath.section == 0 && indexPath.row == 1) {
        PostingTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:imageCell forIndexPath:indexPath];
        
        UITapGestureRecognizer *deleteKeyboard = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteKeyBoardClick:)];
        deleteKeyboard.numberOfTapsRequired = 1;
        [cell addGestureRecognizer:deleteKeyboard];
        
        [cell addSubview:self.listButton];
        [cell addSubview:self.textView];
        
        [cell addSubview:self.imageArrView];
        [self.imageArrView addSubview:self.addButton];
        
        [self.imageArrView addSubview:self.ima1];
        [self.imageArrView addSubview:self.ima2];
        [self.imageArrView addSubview:self.ima3];
        
        [self.imageArrView addSubview:self.dBtn1];
        [self.imageArrView addSubview:self.dBtn2];
        [self.imageArrView addSubview:self.dBtn3];
        
        self.ima1.image = nil;
        self.ima2.image = nil;
        self.ima3.image = nil;
        self.dBtn1.hidden = YES;
        self.dBtn2.hidden = YES;
        self.dBtn3.hidden = YES;
        self.ima1.hidden = YES;
        self.ima2.hidden = YES;
        self.ima3.hidden = YES;
        
        for (int i=0; i<self.imaArray.count; i++) {
            switch (i) {
                case 0:
                    self.ima1.image=[self.imaArray objectAtIndex:i];
                    self.ima1.hidden = NO;
                    [self.dBtn1 addTarget:self action:@selector(deleteImageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                    self.dBtn1.tag=0;
                    self.dBtn1.hidden=NO;
                    
                    break;
                case 1:
                    self.ima2.image=[self.imaArray objectAtIndex:i];
                    self.ima2.hidden = NO;
                    [self.dBtn2 addTarget:self action:@selector(deleteImageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                    self.dBtn2.tag=1;
                    self.dBtn2.hidden=NO;
                    break;
                case 2:
                    self.ima3.image=[self.imaArray objectAtIndex:i];
                    self.ima3.hidden = NO;
                    [self.dBtn3 addTarget:self action:@selector(deleteImageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                    self.dBtn3.tag=2;
                    self.dBtn3.hidden=NO;
                    break;
                    
                default:
                    break;
            }
        }
        
        for (int i = 0; i < self.listArray.count; i++) {
            self.classButton = [UIButton buttonWithType:UIButtonTypeCustom];
            self.classButton.frame = CGRectMake(0, ((30 * self.listArray.count + self.listArray.count) / self.listArray.count * i), 120, 30);
            self.classButton.backgroundColor = [UIColor whiteColor];
            [self.classButton setTitle:[NSString stringWithFormat:@"%@", [self.listArray objectAtIndex:i]] forState:UIControlStateNormal];
            [self.classButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.classButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
            self.classButton.tag = i;
            [self.classButton addTarget:self action:@selector(classButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:self.classButtonView];
            [self.classButtonView addSubview:self.classButton];
        }
        
        /*
        if (self.imaArray.count < 4) {
            
            for (int i = 0; i < self.imaArray.count; i++) {
                
                self.imaView = [[UIImageView alloc] init];
                self.imaView.frame = CGRectMake(5 + ((55 * self.imaArray.count + self.imaArray.count + 6) / self.imaArray.count * i), 5, 50, 50);
                self.imaView.backgroundColor = [UIColor blueColor];
                self.imaView.image = self.imaArray[i];
                self.imaView.tag = 100 + i;
                self.imaView.userInteractionEnabled = YES;
                [self.imageArrView addSubview:self.imaView];
                
                
                self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                self.deleteBtn.frame = CGRectMake(50 + ((55 * self.imaArray.count + self.imaArray.count + 6) / self.imaArray.count * i), 0, 10, 10);
                self.deleteBtn.backgroundColor = [UIColor purpleColor];
                self.deleteBtn.tag = 100 + i;
                [self.deleteBtn addTarget:self action:@selector(deleteImageButtonClick:) forControlEvents:UIControlEventTouchUpInside];
                [self.imageArrView addSubview:self.deleteBtn];
            }
        } else {
            NSLog(@"滚");
        }
        */
        if (self.imaArray.count == 0) {
            [UIView animateWithDuration:0.3 animations:^{
                self.addButton.frame = CGRectMake(5, 5, 50, 50);
            }];
            self.deleteBtn.hidden = NO;
        } else if (self.imaArray.count == 1) {
            [UIView animateWithDuration:0.3 animations:^{
                self.addButton.frame = CGRectMake(65, 5, 50, 50);
            }];
        } else if (self.imaArray.count == 2) {
            [UIView animateWithDuration:0.3 animations:^{
                self.addButton.frame = CGRectMake(125, 5, 50, 50);
            }];
            self.addButton.hidden = NO;
        } else {
            [UIView animateWithDuration:0.3 animations:^{
                self.addButton.frame = CGRectMake(125, 5, 50, 50);
            }];
            self.addButton.hidden = YES;
        }
        return cell;
    } else if (indexPath.section == 0 && indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:titleCell forIndexPath:indexPath];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:titleCell];
        }
        
        [cell addSubview:self.titleTextField];
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 1) {
        return HEIGHT - 44 - 64 - 50;
    }
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 1;
}


#pragma marl - ButtonAction
- (void)sendButtonClick:(UIBarButtonItem *)sender {
    NSLog(@"发送");
    if ([self.titleTextField.text isEqualToString:@""]) {
        UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入主题" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [aler show];
        return;
    }
    if (self.valueStr == nil) {
        UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择分类" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [aler show];
        return;
    }
    
//    [self sendTitleText];
    
    if (self.imaArray.count == 0) {
        [self sendTitleText];
    }
    [self sendImage];
}

#pragma mark - Button方法
//添加照片
- (void)addImageButtonAction:(UIButton *)sender {
    ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initImagePicker];
    elcPicker.maximumImagesCount = 3; //选择图像的最大数量设置为9
    elcPicker.returnsOriginalImage = YES; //只返回fullScreenImage,不是fullResolutionImage
    elcPicker.returnsImage = YES; //如果是的 返回UIimage。如果没有,只返回资产位置信息
    elcPicker.onOrder = YES; //对多个图像选择、显示和返回的顺序选择图像
    elcPicker.mediaTypes = @[(NSString *)kUTTypeImage]; //支持图片和电影类型
    elcPicker.imagePickerDelegate = self;
    [self presentViewController:elcPicker animated:YES completion:nil];
    _classButtonView.hidden=YES;
}

//显示列表
- (void)listButtonClick:(UIButton *)sender {
    
    if (_show==YES) {
        [self.titleTextField resignFirstResponder];
        [self.textView resignFirstResponder];
        CATransition *animation = [CATransition animation];
        animation.subtype=kCATransitionFromTop;//指定预定义的过渡方向
        animation.type = kCATransitionPush;//指定预定义的过渡效果
        animation.duration = 0.3;
        [_classButtonView.layer addAnimation:animation forKey:nil];
        _classButtonView.hidden=YES;
        _show=NO;
    }else{
        [self.titleTextField resignFirstResponder];
        [self.textView resignFirstResponder];
        CATransition *animation = [CATransition animation];
        //  animation.startProgress = 0.8;
        animation.subtype=kCATransitionFromBottom;//指定预定义的过渡方向
        animation.type = kCATransitionMoveIn;//指定预定义的过渡效果
        animation.duration = 0.3;
        [_classButtonView.layer addAnimation:animation forKey:nil];
        _classButtonView.hidden=NO;
        _show=YES;
    }
}

//列表内容
- (void)classButtonClick:(UIButton *)sender {
    NSString *title=[self.listArray objectAtIndex:sender.tag];
    self.valueStr =[self.valueArray objectAtIndex:sender.tag];
    [self.listButton setTitle:title forState:UIControlStateNormal];
    CATransition *animation = [CATransition animation];
    animation.subtype=kCATransitionFromTop;//指定预定义的过渡方向
    animation.type = kCATransitionPush;//指定预定义的过渡效果
    animation.duration = 0.3;
    [_classButtonView.layer addAnimation:animation forKey:nil];
    _classButtonView.hidden=YES;
    _show=NO;
}

//撤销键盘
- (void)deleteKeyBoardClick:(UIGestureRecognizer *)sender {
    [self.titleTextField resignFirstResponder];
    [self.textView resignFirstResponder];
    CATransition *animation = [CATransition animation];
    animation.subtype=kCATransitionFromTop;//指定预定义的过渡方向
    animation.type = kCATransitionPush;//指定预定义的过渡效果
    animation.duration = 0.3;
    [_classButtonView.layer addAnimation:animation forKey:nil];
    _classButtonView.hidden=YES;
    _show=NO;
}

//图片删除按钮
- (void)deleteImageButtonClick:(UIButton *)sender {
    [self.imaArray removeObjectAtIndex:sender.tag];
    [self.tView reloadData];
}


#pragma mark - 选择照片
//相册
- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    //    NSLog(@"**********************%@***********************", info);
    for (NSDictionary *dict in info) {
        if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypePhoto){
            if ([dict objectForKey:UIImagePickerControllerOriginalImage]){
                //把图片取出来放到数组里面
                UIImage* image=[dict objectForKey:UIImagePickerControllerOriginalImage];
                if (self.imaArray.count < 4) {
                    [self.imaArray addObject:image];
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
        if ([toBeString length] > 200) {
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

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    CATransition *animation = [CATransition animation];
    animation.subtype=kCATransitionFromTop;//指定预定义的过渡方向
    animation.type = kCATransitionPush;//指定预定义的过渡效果
    animation.duration = 0.3;
    [_classButtonView.layer addAnimation:animation forKey:nil];
    _classButtonView.hidden=YES;
    _show=NO;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    CATransition *animation = [CATransition animation];
    animation.subtype=kCATransitionFromTop;//指定预定义的过渡方向
    animation.type = kCATransitionPush;//指定预定义的过渡效果
    animation.duration = 0.3;
    [_classButtonView.layer addAnimation:animation forKey:nil];
    _classButtonView.hidden=YES;
    _show=NO;
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 图片压缩
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0,0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    //返回新的改变大小后的图片
    return scaledImage;
}

-(UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth
{
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = (targetWidth / width) * height;
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [sourceImage drawInRect:CGRectMake(0,0,targetWidth,  targetHeight)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark - XML解析
-(void)start{
    //    NSString *asiurl=[NSString stringWithFormat:self.xmlStr];
    //    NSURL *url = [NSURL URLWithString:asiurl];
    NSData *data = [self.xmlStr dataUsingEncoding:NSUTF8StringEncoding];
    //开始解析 xml
    NSXMLParser * parser = [[NSXMLParser alloc] initWithData:data];
    parser.delegate = self ;
    
    [parser parse];
}

//文档开始时触发 ,开始解析时 只触发一次
-(void)parserDidStartDocument:(NSXMLParser *)parser{
    _notes = [[NSMutableArray alloc] init];
}

//遇到一个开始标签触发
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    //把elementName 赋值给 成员变量 currentTagName
    _currentTagName  = elementName ;
    //如果名字 是Note就取出 id
    if ([_currentTagName isEqualToString:@"option"]) {
        NSString * _id = [attributeDict objectForKey:@"value"];
        // 实例化一个可变的字典对象,用于存放
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];;
        //把id 放入字典中
        [dict setObject:_id forKey:@"value"];
        // 把可变字典 放入到 可变数组集合_notes 变量中
        [_notes addObject:dict];
    }
}

// 文档出错时触发
-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    //    NSLog(@"*************%@*************",parseError);
}

#pragma mark 该方法主要是解析元素文本的主要场所，由于换行符和回车符等特殊字符也会触发该方法，因此要判断并剔除换行符和回车符
// 遇到字符串时 触发
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    //替换回车符 和空格,其中 stringByTrimmingCharactersInSet 是剔除字符的方法,[NSCharacterSet whitespaceAndNewlineCharacterSet]指定字符集为换行符和回车符;
    string  = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSMutableDictionary * dict = [_notes lastObject];
    if ([_currentTagName isEqualToString:@"option"] && dict) {
        [dict setObject:string forKey:@"option"];
    }
}

//遇到结束标签触发
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    self.currentTagName = nil ;
    //该方法主要是用来 清理刚刚解析完成的元素产生的影响，以便于不影响接下来解析
}

// 遇到文档结束时触发
-(void)parserDidEndDocument:(NSXMLParser *)parser{
    //进入该方法就意味着解析完成，需要清理一些成员变量，同时要将数据返回给表示层（表示图控制器） 通过广播机制将数据通过广播通知投送到 表示层
    //    NSLog(@"------%@--------", self.notes);
    for (int i=0; i<self.notes.count; i++) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        dict=[self.notes objectAtIndex:i];
        NSString *option=[dict objectForKey:@"option"];
        NSString *value = [dict objectForKey:@"value"];
        [self.listArray addObject:option];
        [self.valueArray addObject:value];
    }
//        NSLog(@"********%@******", self.listArray);
//        NSLog(@"00000000000%@00000000", self.valueArray);
    [self.tView reloadData];
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

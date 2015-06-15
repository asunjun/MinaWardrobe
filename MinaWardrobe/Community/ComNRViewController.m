//
//  ComNRViewController.m
//  MinaWardrobe
//
//  Created by 米娜 上海文星广告传媒有限公司 on 15/5/25.
//  Copyright (c) 2015年 wenxing. All rights reserved.
//

#import "ComNRViewController.h"
#import "ASIHTTPRequest.h"
#import "SVProgressHUD.h"
#import "ComNRTableViewCell.h"
#import "ComNRModel.h"
#import "ASIFormDataRequest.h"
#import "ComTwoNRTableViewCell.h"
#import "ComtrueTableViewCell.h"
#import "YFInputBar.h"
#import "ComQuestionNRModel.h"
#import "Comcommodel.h"
#import "UIImageView+WebCache.h"
#import "ELCImagePickerController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
@interface ComNRViewController ()<UITableViewDataSource,UITableViewDelegate,YFInputBarDelegate,UIActionSheetDelegate,ELCImagePickerControllerDelegate,ASIHTTPRequestDelegate>{
  
    ComNRModel *shuju;
    ComQuestionNRModel *questionshuju;
    Comcommodel *quescom;
    
    NSString *_title;
    NSString *_message;
    
    NSMutableArray *_datasoure;
    NSArray *_imageurls;
    
      NSString *_tradeid;
    NSString *_catgrop;
    YFInputBar *inputBar;
    
    
    
    
}

@end

@implementation ComNRViewController



-(id)initWith:(NSString *)idzhi and:(NSArray *)images and:(NSString *)catgroup{

    
    self=[super init];
    
   
    if (self) {
        _tradeid = idzhi;
        _imageurls=images;
        _catgrop=catgroup;
        
    }
    return self;
    
}
- (void)viewDidLoad {
    NSLog(@"%@",_imageurls);
  //  self.view.userInteractionEnabled=NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi) name:@"tongzhi" object:nil];
    [self.navigationController setNavigationBarHidden:NO];
    [super viewDidLoad];
    self.table.frame=CGRectMake(0, 0, WIDTH, HEIGHT);
    
        [self.table registerNib:[UINib nibWithNibName:@"ComNRTableViewCell" bundle:nil] forCellReuseIdentifier:@"ComNRTableViewCell"];
      [self.table registerNib:[UINib nibWithNibName:@"ComTwoNRTableViewCell" bundle:nil] forCellReuseIdentifier:@"ComTwoNRTableViewCell"];
    [self.table registerNib:[UINib nibWithNibName:@"ComtrueTableViewCell" bundle:nil] forCellReuseIdentifier:@"ComtrueTableViewCell"];
    _datasoure=[[NSMutableArray alloc]init];
    
    self.navigationController.navigationBar.translucent = NO;
    
    inputBar = [[YFInputBar alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY([UIScreen mainScreen].bounds)-108, 320, 44)];
    
    inputBar.backgroundColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
    
    
    inputBar.delegate = self;
    inputBar.clearInputWhenSend = YES;
    inputBar.resignFirstResponderWhenSend = YES;
   
    [self.view addSubview:inputBar];
    
    
     [self requstdata];

    // Do any additional setup after loading the view from its nib.
}
-(void)tongzhi{
    
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选择" ,nil];
    [action showInView:self.view];
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            NSLog(@"第一个");
            break;
        case 1:
            NSLog(@"第二个");
            [self addzhaopian];
            
            break;
        
        default:
            break;
    }
}
-(void)addzhaopian{
    ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initImagePicker];
    elcPicker.maximumImagesCount = 1; //选择图像的最大数量设置为9
    elcPicker.returnsOriginalImage = YES; //只返回fullScreenImage,不是fullResolutionImage
    elcPicker.returnsImage = YES; //如果是的 返回UIimage。如果没有,只返回资产位置信息
    elcPicker.onOrder = YES; //对多个图像选择、显示和返回的顺序选择图像
    elcPicker.mediaTypes = @[(NSString *)kUTTypeImage]; //支持图片和电影类型
    elcPicker.imagePickerDelegate = self;
    [self presentViewController:elcPicker animated:YES completion:nil];
}
- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    //    NSLog(@"**********************%@***********************", info);
    for (NSDictionary *dict in info) {
        if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypePhoto){
            if ([dict objectForKey:UIImagePickerControllerOriginalImage]){
                //把图片取出来放到数组里面
                UIImage* image=[dict objectForKey:UIImagePickerControllerOriginalImage];
           //     NSData *fData = UIImageJPEGRepresentation(image, 0.3);
                
                inputBar.imagename=image;
                [inputBar chuangjian];
                
                
                
            }
        }else {
            // NSLog(@"UIImagePickerControllerReferenceURL = %@", dict);
        }
    }
   // [self.tView reloadData];
}
-(void)inputBar:(YFInputBar *)inputBar sendBtnPress:(UIButton *)sendBtn withInputString:(NSString *)str
{
    NSLog(@"%@",str);
    
    NSURL *URL = [NSURL URLWithString:@"http://sq.mina.cn/?/api/upload/"];
    ASIFormDataRequest *Request = [ASIFormDataRequest requestWithURL:URL];
    [Request setRequestMethod:@"POST"];
    [Request setUserAgent:@"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML,                                                                                                                                                                                                                                                                                                                                                           Gecko) Chrome/41.0.2272.101 Safari/537.36"];
   // [Request addRequestHeader:@"Content-Type"value:@"application/json"];
    [Request setTimeOutSeconds:60];
    
    //[Request setPostValue:auth forKey:@"auth"];
    UIImage *img =[UIImage imageNamed:@"789.jpg"];
    [Request setData:UIImagePNGRepresentation(img)forKey:@"file"];
    
    [Request setDelegate:self];
    [Request setCompletionBlock:^{
        NSString *responseString = [Request responseString];
        
        NSLog(@"%@",responseString);
        
        //NSLog(@"Response: %@", responseString);
//        NSDictionary *info = [responseString JSONValue];
//        NSNumber *status = [info objectForKey:@"status"];
//        if([status intValue]==1){
//            HJManagedImageV* mi = (HJManagedImageV *)[self.viewviewWithTag:777];
//            //set the URL that we want the managed image view to load
//            [mi clear];
//            mi.url = [NSURLURLWithString:[info objectForKey:@"filePath"]];
//            [mi showLoadingWheel];
//            mi.tag = 777 ;
//            IBMEventAppDelegate *appDelegate = (IBMEventAppDelegate *)[[UIApplicationsharedApplication] delegate];
//            //[mi setCallbackOnImageTap:self method:@selector(uploadPortrait:)];
//            [appDelegate.objMan manage:mi];
//            [appDelegate loadLoginInfoData];
//            UIAlertView *av=[[[UIAlertViewalloc] initWithTitle:nilmessage:@"图片上传成功!" delegate:nilcancelButtonTitle:@"OK"otherButtonTitles:nil]autorelease];
//            [av show];
//            
//        }else if([statusintValue]==-1){
//            UIAlertView *av=[[[UIAlertViewalloc] initWithTitle:nilmessage:[info objectForKey:@"msg"]delegate:nilcancelButtonTitle:@"OK"otherButtonTitles:nil]autorelease];
//            [av show];
//        }else{
//            UIAlertView *av=[[[UIAlertViewalloc] initWithTitle:nilmessage:[info objectForKey:@"msg"]delegate:nilcancelButtonTitle:@"OK"otherButtonTitles:nil]autorelease];
//            [av show];
//        }
//        [MBProgressHUDhideHUDForView:self.navigationController.viewanimated:YES];
    }];
    [Request setFailedBlock:^{
        NSError *error = [Request error];
        NSLog(@"Error: %@,%@", error.localizedDescription,Request.url);
    }];
    [Request startSynchronous];
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    NSURL *url=[NSURL URLWithString:@"http://sq.mina.cn/?/api/sendComment/"];
//    
//    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
//    [request setPostValue:@"3eddferfrc" forKey:@"answer"];
//    [request setPostValue:@"45" forKey:@"question_id"];
//    [request setName:@"post"];
//  
//    [request setUserAgent:@"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML,                                                                                                                                                                                                                                                                                                                                                           Gecko) Chrome/41.0.2272.101 Safari/537.36"];
//    
//    [request setDelegate:self];
//    [request startAsynchronous];
//
    
   // http://sq.mina.cn/?/api/sendComment/
    
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [((UIView*)obj) resignFirstResponder];
    }];
}

-(void)requstdata{
    [SVProgressHUD show];
    
    if ([_catgrop isEqual:@"article"]) {
        NSString *URLNR=[NSString stringWithFormat:@"http://sq.mina.cn/?/article/%@",_tradeid];
        NSURL *url = [NSURL URLWithString:URLNR];
        
        NSLog(@"%@",url);
        
        ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
        [request setUserAgent:@"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.101 Safari/537.36"];
        
        [request setDelegate:self];
        [request startAsynchronous];

    }else{
        NSString *URLNR=[NSString stringWithFormat:@"http://sq.mina.cn/?/question/%@",_tradeid];
        NSURL *url = [NSURL URLWithString:URLNR];
        
        NSLog(@"%@",url);
        
        ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
        [request setUserAgent:@"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.101 Safari/537.36"];
        
        [request setDelegate:self];
        [request startAsynchronous];

    }
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_imageurls!=nil) {
        return 3;
    }else{
        return 2;
        
    }
    
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    
    if (_imageurls!=nil) {
        if (section==0) {
            return 1;
        }
        if (section==1) {
            return 1;
        }
        if (section==2) {
            if (_datasoure.count==0) {
                return 1;
            }
            return _datasoure.count;
            
        }

    }else{
        if (section==0) {
            return 1;
        }
        if (section==1) {
            if (_datasoure.count==0) {
                return 1;
            }
            return _datasoure.count;;
        }
        
    }
    
    
    
    return 10;
    
   // return _datasoure.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_imageurls!=nil) {
        if (indexPath.section==0) {
            static NSString *CellIdentifier = @"ComNRTableViewCell";
            ComNRTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (cell==nil) {
                
            }
            
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
               [cell configCellByTradeModel:_title and:_message];
            return cell;
            
            
        }
        if (indexPath.section==1) {
            static NSString *CellIdentifier = @"ComTwoNRTableViewCell";
            ComTwoNRTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (cell==nil) {
                
            }
            
            [cell configCellByTradeModel:nil];
            for (int i=0; i<_imageurls.count; i++) {
                switch (i) {
                    case 0:
                        
                        
                        [cell.img1 sd_setImageWithURL:[NSURL URLWithString:[_imageurls objectAtIndex:i]]];
                        break;
                    case 1:
                        
                        [cell.img2 sd_setImageWithURL:[NSURL URLWithString:[_imageurls objectAtIndex:i]]];
                        
                        
                        break;
                    case 2:
                        [cell.img3 sd_setImageWithURL:[NSURL URLWithString:[_imageurls objectAtIndex:i]]];
                        
                        break;
                        
                    default:
                        
                        break;
                }
                

            }
            
            return cell;
            
        }
        if (indexPath.section==2) {
            static NSString *CellIdentifier = @"ComtrueTableViewCell";
            ComtrueTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (cell==nil) {
                
            }
            if (_datasoure.count==0) {
                cell.lab5.frame=CGRectMake(0, 0, WIDTH, 200);
                cell.lab5.text=@"暂无消息回复";
                cell.lab5.textAlignment = NSTextAlignmentCenter;
                
                return cell;
                
            }
             Comcommodel *trade = _datasoure[indexPath.row];
              [cell configCellByTradeModel:trade.name and:indexPath.row and:nil and:nil and:trade.huifu];
            
            
            
            return cell;
        }
    
    }else{
        if (indexPath.section==0) {
            static NSString *CellIdentifier = @"ComNRTableViewCell";
            ComNRTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (cell==nil) {
                
            }
            
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            [cell configCellByTradeModel:_title and:_message];
            return cell;
            
            
        }

        
        if (indexPath.section==1) {
            static NSString *CellIdentifier = @"ComtrueTableViewCell";
            ComtrueTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (cell==nil) {
                
            }
            NSLog(@"%ld",_datasoure.count);
            if (_datasoure.count==0) {
               cell.lab5.frame=CGRectMake(0, 0, WIDTH, 200);
                cell.lab5.text=@"暂无消息回复";
                cell.lab5.textAlignment = NSTextAlignmentCenter;
               
                return cell;
                
            }else{
                cell.lab5.text=nil;
                
            Comcommodel *trade = _datasoure[indexPath.row];
            [cell configCellByTradeModel:trade.name and:indexPath.row and:trade.images and:nil and:trade.huifu];
                NSLog(@"%@",trade.images);
                
             [cell.img1 sd_setImageWithURL:[NSURL URLWithString:trade.images]];
            return cell;

            }
    }
       
   
        
        
    }
    
  
    
    // cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
 //   [cell configCellByTradeModel:_datasoure[indexPath.row]];
    
    return nil;
    
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        
   
         CGFloat height1 = [_title boundingRectWithSize:CGSizeMake(WIDTH, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} context:nil].size.height;
        
        CGFloat height2=[_message boundingRectWithSize:CGSizeMake(WIDTH, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} context:nil].size.height;
          NSLog(@"%f",height1);
          NSLog(@"%f",height2);
        
        
        CGFloat height=height1+height2+50;
        NSLog(@"%f",height);
        
        return height;
        
        
    }
    
    if (_imageurls!=nil) {
        
        if (indexPath.section==1) {
            
            if (_imageurls.count<4) {
                  CGFloat height=_imageurls.count*450;
                 return height;
            }else{
                return 1350;
                
            }
          
           
            
        }
    }else{
        if (indexPath.section==1) {
            
            return 200;
            
        }
        
    }
    
    
    return 200;
    
}
-(void)requestFinished:(ASIHTTPRequest *)request{
    
    [SVProgressHUD dismiss];
    
    
    if ([request.name isEqualToString:@"post"]) {
        NSString *st1=[request responseString];
        
        NSLog(@"%@",st1);
        
        
        
        
        
        
    }else{
    
    NSString *st1=[request responseString];
    
    NSLog(@"%@",st1);
    
    
    
    //
    NSArray *arrayWord = [st1 componentsSeparatedByString:@"â"];
    
    
    NSMutableArray *a1=[[NSMutableArray alloc]initWithObjects:[arrayWord objectAtIndex:0], nil];
  //   NSLog(@"%@",a1);
    NSString *a2=[a1 objectAtIndex:0];
    NSDictionary *arr = [NSJSONSerialization JSONObjectWithData:[a2 dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"%@",arr);
    
    if ([_catgrop isEqualToString:@"question"]) {
        questionshuju=[[ComQuestionNRModel alloc]initWithDic:arr];
        
        _title=questionshuju.title;
        _message=questionshuju.message;
        for (int i=0; i<questionshuju.dic2.count; i++) {
            
            NSDictionary *dic=[questionshuju.dic2 objectAtIndex:i];
            
            
            quescom=[[Comcommodel alloc]initWithDic:dic];
            [_datasoure addObject:quescom];
            
            
        }
        
        NSLog(@"%@",quescom.name);
        
        
        NSLog(@"%@",quescom.huifu);
       
        
        
        [self.table reloadData];
        
        
        
        
        
        
    }else{
         shuju=[[ComNRModel alloc]initWithDic:arr];
        _title=shuju.title;
        _message=shuju.message;

        
        NSLog(@"%@",_title);
        NSLog(@"%@",_message);

        
        
        NSLog(@"%@",shuju.message);
        [self.table reloadData];
        
    }
    
    
   
    }

    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.5;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 4;
}

//错误网址
- (void)requestFailed:(ASIHTTPRequest *)request

{
    
    NSError *error = [request error];
    [SVProgressHUD showErrorWithStatus:error.localizedDescription];
    
}

@end

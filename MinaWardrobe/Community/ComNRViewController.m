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
#import "MCProgressBarView.h"
@interface ComNRViewController ()<UITableViewDataSource,UITableViewDelegate,YFInputBarDelegate,UIActionSheetDelegate,ELCImagePickerControllerDelegate,ASIHTTPRequestDelegate,UIImagePickerControllerDelegate>{
  
    ComNRModel *shuju;
    ComQuestionNRModel *questionshuju;
    Comcommodel *quescom;
    
    NSString *_title;
    NSString *_message;
    
    NSMutableArray *_datasoure;
    NSMutableArray *_imageurls;
    
      NSString *_tradeid;
    NSString *_catgrop;
    YFInputBar *inputBar;
    
    NSMutableArray *heights;
    // NSMutableArray *huifuimages;
    NSMutableArray *huifuheights;
    NSString *imagsurl;
    NSString *fasongstring;
    NSMutableArray *neirong;
    
    
   // MCProgressBarView *_progressBarView;
    
    
}

@end

@implementation ComNRViewController



-(id)initWith:(NSString *)idzhi and:(NSMutableArray *)images and:(NSString *)catgroup{

    
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
    [Mag shard].imageArrrr=_imageurls;
    heights=[[NSMutableArray alloc]init];
    huifuheights=[[NSMutableArray alloc]init];
    _hufuimages=[[NSMutableArray alloc]init];
    neirong=[[NSMutableArray alloc]init];
     //  self.view.userInteractionEnabled=NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tongzhi) name:@"tongzhi" object:nil];
    [self.navigationController setNavigationBarHidden:NO];
    [super viewDidLoad];
    self.table.frame=CGRectMake(0, 0, WIDTH, HEIGHT-104);
    
        [self.table registerNib:[UINib nibWithNibName:@"ComNRTableViewCell" bundle:nil] forCellReuseIdentifier:@"ComNRTableViewCell"];
      [self.table registerNib:[UINib nibWithNibName:@"ComTwoNRTableViewCell" bundle:nil] forCellReuseIdentifier:@"ComTwoNRTableViewCell"];
    [self.table registerNib:[UINib nibWithNibName:@"ComtrueTableViewCell" bundle:nil] forCellReuseIdentifier:@"ComtrueTableViewCell"];
    _datasoure=[[NSMutableArray alloc]init];
    
    self.navigationController.navigationBar.translucent = NO;
    
    inputBar = [[YFInputBar alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY([UIScreen mainScreen].bounds)-108, 320, 44)];
    
    inputBar.backgroundColor =kUIColorFromRGB(0xe9e9e9);
    
    
    
    inputBar.delegate = self;
    inputBar.clearInputWhenSend = YES;
    inputBar.resignFirstResponderWhenSend = YES;
   
    [self.view addSubview:inputBar];
    
    [self requestdataimage];
    
     [self requstdata];

    // Do any additional setup after loading the view from its nib.
}
-(void)tongzhi{
    
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选择" ,nil];
    [action showInView:self.view];
    
}

-(void)requestdataimage{
    for (int i=0; i<_imageurls.count; i++) {
        
        NSString *st1=[_imageurls objectAtIndex:i];
        
        if([st1 rangeOfString:@"images/"].location !=NSNotFound)//_roaldSearchText
        {
            NSArray *a1=[st1 componentsSeparatedByString:@"images/"];
            NSString *URLNR=[NSString stringWithFormat:@"http://sq.mina.cn/?/api/getImageInfo/?file=%@",[a1 objectAtIndex:1]];
            
            NSLog(@"%@",URLNR);
            
            //  NSString *URLNR=@"http://sq.mina.cn/?/api/getImageInfo/?file=ffd9ae7666226c9be863069eaf7cf4c5.jpg";
            NSURL *url = [NSURL URLWithString:URLNR];
            
            NSLog(@"%@",url);
            
            ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
            [request setUserAgent:@"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.101 Safari/537.36"];
            [request setName:@"imageheight"];
            [request setDelegate:self];
            [request startSynchronous];
            NSLog(@"yes");
        }
        else
        {
            NSLog(@"no");
        }
    }

}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            NSLog(@"相机调用");
            [self addxiangji];
            
            break;
        case 1:
            NSLog(@"照片选择");
            [self addzhaopian];
            
            break;
        
        default:
            break;
    }
}

-(void)addxiangji{
    UIImagePickerControllerSourceType sourcType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.sourceType = sourcType;
        [self presentViewController:picker animated:YES completion:^{
            
        }];
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"无法调取相机，请检查" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        return;
    }
    
    
    
}
#pragma mark - 照片选择代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // 1. 获取编辑后的照片
    UIImage *image;
    switch (picker.sourceType) {
        case UIImagePickerControllerSourceTypeCamera:
            image = info[@"UIImagePickerControllerOriginalImage"];
            //将图片保存到相册
            [self saveImageToPhotos:image];
            break;
        case UIImagePickerControllerSourceTypePhotoLibrary:
            image = info[@"UIImagePickerControllerEditedImage"];
            break;
        default:
            break;
    }
    // 2. 设置按钮的图像
    
    
    // 3. 关闭照片选择控制器
    [self dismissViewControllerAnimated:YES completion:nil];
}

//将图片保存到相册
- (void)saveImageToPhotos:(UIImage*)savedImage

{
    UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

// 指定回调方法
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
        
        inputBar.imagename=image;
        [inputBar chuangjian];
        

        
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存图片结果提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
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
    
    fasongstring=str;
    if (inputBar.imagename==nil) {
        
            NSURL *url=[NSURL URLWithString:@"http://sq.mina.cn/?/api/sendComment/"];
        
            ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
            [request setPostValue:fasongstring forKey:@"answer"];
            [request setPostValue:_tradeid forKey:@"question_id"];
            [request setName:@"post"];
        
            [request setUserAgent:@"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML,                                                                                                                                                                                                                                                                                                                                                           Gecko) Chrome/41.0.2272.101 Safari/537.36"];
        
            [request setDelegate:self];
            [request startAsynchronous];

        
        
        
    }else{
        
        
        
        NSURL *URL = [NSURL URLWithString:@"http://sq.mina.cn/?/api/upload/"];
        ASIFormDataRequest *Request = [ASIFormDataRequest requestWithURL:URL];
        [Request setRequestMethod:@"POST"];
        [Request setUserAgent:@"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML,                                                                                                                                                                                                                                                                                                                                                           Gecko) Chrome/41.0.2272.101 Safari/537.36"];
              [Request setTimeOutSeconds:60];
        
       
        UIImage *img1=[self imageCompressForWidth:inputBar.imagename targetWidth:320];
        
        
        [Request setData:UIImagePNGRepresentation(img1)forKey:@"file"];
        
        [Request setDelegate:self];
        [Request setCompletionBlock:^{
            NSString *responseString = [Request responseString];
            
         
            
            
            
            NSLog(@"%@",responseString);
            NSURL *url=[NSURL URLWithString:@"http://sq.mina.cn/?/api/sendComment/"];
            
            ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
        
            NSString *st1=[NSString stringWithFormat:@"%@[img]%@[/img]",fasongstring,responseString];
            [request setPostValue:st1 forKey:@"answer"];
            [request setPostValue:_tradeid forKey:@"question_id"];
            [request setName:@"post"];
            
            [request setUserAgent:@"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML,                                                                                                                                                                                                                                                                                                                                                           Gecko) Chrome/41.0.2272.101 Safari/537.36"];
            
            [request setDelegate:self];
            [request startAsynchronous];
            
            
            
            
            
        }];
        [Request setFailedBlock:^{
            NSError *error = [Request error];
            
            
            
            NSLog(@"Error: %@,%@", error.localizedDescription,Request.url);
            
        }];
        [Request startSynchronous];
        
    }
    
    
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
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [((UIView*)obj) resignFirstResponder];
    }];
}

-(void)requstdata{
    [SVProgressHUD show];
    
    if ([_catgrop isEqual:@"article"]) {
        NSString *URLNR=[NSString stringWithFormat:@"http://sq.mina.cn/?/api/getPost/?type=article&id=%@",_tradeid];
        NSURL *url = [NSURL URLWithString:URLNR];
        
        NSLog(@"%@",url);
        
        ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
        [request setUserAgent:@"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.101 Safari/537.36"];
        [request setName:@"mess"];
        [request setDelegate:self];
        [request startAsynchronous];

    }else{
      NSLog(@"%@",_tradeid);
        NSString *URLNR=[NSString stringWithFormat:@"http://sq.mina.cn/?/api/getPost/?type=question&id=%@",_tradeid];
        NSURL *url = [NSURL URLWithString:URLNR];
        
        NSLog(@"%@",url);
        
        ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
        [request setUserAgent:@"Mozilla/5.0 (Windows NT 6.3; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.101 Safari/537.36"];
         [request setName:@"mess"];
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
    if (_imageurls.count!=0) {
        return 3;
    }else{
        return 2;
        
    }
    
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    
    if (_imageurls.count!=0) {
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
    if (_imageurls.count!=0) {
        
        NSLog(@"%@",_imageurls);
        
        if (indexPath.section==0) {
            static NSString *CellIdentifier = @"ComNRTableViewCell";
            ComNRTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (cell==nil) {
                
            }
          
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
               [cell configCellByTradeModel:questionshuju];
            return cell;
            
            
        }
        if (indexPath.section==1) {
            static NSString *CellIdentifier = @"ComTwoNRTableViewCell";
            ComTwoNRTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (cell==nil) {
                
            }
            
            [cell configCellByTradeModel:heights];
            for (int i=0; i<_imageurls.count; i++) {
                
                if (i==0) {
                   UIActivityIndicatorView * activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((WIDTH-16)/2-30, cell.img1.frame.size.height/2-30, 60, 60)];
                    
                    [cell.img1 addSubview:activityIndicator];
                    
                    activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
                    
                    [activityIndicator startAnimating];
                    
                  //  [cell.img1 addSubview:_progressBarView];
                    cell.lab1.frame=CGRectMake(0,cell.img1.frame.size.height+15, WIDTH, 6);
                    
                    [cell.img1 sd_setImageWithURL:[NSURL URLWithString:[_imageurls objectAtIndex:i]] placeholderImage:nil options:SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                        
                        
                                                } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                                    [activityIndicator removeFromSuperview];
                                                    
                                                    
                                                }];
                }
                if (i==1) {
                    UIActivityIndicatorView * activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((WIDTH-16)/2-30, cell.img2.frame.size.height/2-30, 60, 60)];
                    cell.lab1.frame=CGRectMake(0,cell.img1.frame.size.height+30+cell.img2.frame.size.height, WIDTH, 6);
                    [cell.img2 addSubview:activityIndicator];
                    
                    activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
                    
                    [activityIndicator startAnimating];
                    
                    [cell.img2 sd_setImageWithURL:[NSURL URLWithString:[_imageurls objectAtIndex:i]] placeholderImage:nil options:SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                        
                        
                    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        [activityIndicator removeFromSuperview];
                        
                        
                    }];
                }
                if (i==2) {
                     cell.lab1.frame=CGRectMake(0,cell.img1.frame.size.height+45+cell.img2.frame.size.height+cell.img3.frame.size.height, WIDTH, 6);
                    UIActivityIndicatorView * activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((WIDTH-16)/2-30, cell.img3.frame.size.height/2-30, 60, 60)];
                    
                    [cell.img3 addSubview:activityIndicator];
                    
                    activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
                    
                    [activityIndicator startAnimating];
                    
                    [cell.img3 sd_setImageWithURL:[NSURL URLWithString:[_imageurls objectAtIndex:i]] placeholderImage:nil options:SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                      
                        
                    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                        [activityIndicator removeFromSuperview];
                        
                        
                    }];
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
                
            }else{
                cell.lab5.text=nil;

             Comcommodel *trade = _datasoure[indexPath.row];
              [cell configCellByTradeModel:trade.name and:indexPath.row and:nil and:trade.time and:trade.huifu and:trade.imagesheight];
                UIActivityIndicatorView * activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((WIDTH-16)/2-30, cell.img1.frame.size.height/2-30, 60, 60)];
                
                [cell.img1 addSubview:activityIndicator];

                
                // [cell.img1 sd_setImageWithURL:[NSURL URLWithString:trade.images]];
                [cell.touxiang sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://sq.mina.cn/uploads/avatar/%@",trade.touxiang]]];
                [cell.img1 sd_setImageWithURL:[NSURL URLWithString:trade.images] placeholderImage:nil options:SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                    
                    
                } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    [activityIndicator removeFromSuperview];
                    
                    
                }];

            
            return cell;
            }
        }
    
    }else{
        if (indexPath.section==0) {
            static NSString *CellIdentifier = @"ComNRTableViewCell";
            ComNRTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            
            if (cell==nil) {
                
            }
            
          
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            [cell configCellByTradeModel:questionshuju];

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
             [cell configCellByTradeModel:trade.name and:indexPath.row and:nil and:trade.time and:trade.huifu and:trade.imagesheight];
                NSLog(@"%@",trade.images);
                UIActivityIndicatorView * activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((WIDTH-16)/2-30, cell.img1.frame.size.height/2-30, 60, 60)];
                
                [cell.img1 addSubview:activityIndicator];

                [cell.img1 sd_setImageWithURL:[NSURL URLWithString:trade.images] placeholderImage:nil options:SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                    
                    
                } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    [activityIndicator removeFromSuperview];
                    
                    
                }];

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
        
   
         CGFloat height1 = [questionshuju.title boundingRectWithSize:CGSizeMake(WIDTH, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} context:nil].size.height;
        
        CGFloat height2=[questionshuju.message boundingRectWithSize:CGSizeMake(WIDTH, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} context:nil].size.height;
        
        CGFloat height=height1+height2+50;
        
        return height;
        
        
    }
    
    if (_imageurls!=nil) {
        
        if (indexPath.section==1) {
            CGFloat imagheight = 0.0;
            
            
            for (int i=0; i<heights.count; i++) {
                CGFloat imgheig=[[heights objectAtIndex:i] integerValue]+10;
                      imagheight=imagheight+imgheig;
     
            }
          
            
            
            
          
            return imagheight+10;
            
            
        }
        
        if (indexPath.section==2) {
            
            if (_datasoure.count==0) {
                return 200;
                
            }else{
            
            CGFloat zhongde = 0.0;
            Comcommodel *trade = _datasoure[indexPath.row];
            
            CGFloat height1 = [trade.huifu boundingRectWithSize:CGSizeMake(WIDTH, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} context:nil].size.height;
            
                
                NSLog(@"%f",height1);
                
            zhongde=height1+62+[trade.imagesheight intValue];
            
            
            return zhongde;
            }
        }
        
    }else{
        if (indexPath.section==1) {
            if (_datasoure.count==0) {
                return 200;
                
            }else{
                
                CGFloat zhongde = 0.0;
                Comcommodel *trade = _datasoure[indexPath.row];
                
                CGFloat height1 = [trade.huifu boundingRectWithSize:CGSizeMake(WIDTH, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15]} context:nil].size.height;
                
                zhongde=height1+62+[trade.imagesheight intValue];
                
                
                return zhongde;
            }
        }
        
    }
    
    
    return 200;
    
}
-(void)requestFinished:(ASIHTTPRequest *)request{
    
    [SVProgressHUD dismiss];
    
    
    if ([request.name isEqualToString:@"post"]) {
        NSString *st1=[request responseString];
        NSLog(@"%@",st1);
        if ([st1 isEqualToString:@"1"]) {
           // [SVProgressHUD showErrorWithStatus:@"发送成功"];
            inputBar.imagename=nil;
            [inputBar chuangjian];
          [self requstdata];
            fasongstring=nil;
            

        }else{
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"发送失败" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
            
            
        }
      //  [self.table reloadData];
        
        
        
    }
    if ([request.name isEqualToString:@"mess"]) {
    
    NSString *st1=[request responseString];
    
       
    
    
       NSDictionary *arr = [NSJSONSerialization JSONObjectWithData:[st1 dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"%@",arr);
    
        [_datasoure removeAllObjects];
        
    if ([_catgrop isEqualToString:@"question"]) {
        questionshuju=[[ComQuestionNRModel alloc]initWithDic:arr];
        [neirong addObject:questionshuju];
        
        for (int i=0; i<questionshuju.dic2.count; i++) {
            
            NSDictionary *dic=[questionshuju.dic2 objectAtIndex:i];
            
            
            quescom=[[Comcommodel alloc]initWithDic:dic];
            [_datasoure addObject:quescom];
            
            NSLog(@"%ld",_datasoure.count);
            
            
        }
        
        
        
        
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
    
    
    
    
    if ([request.name isEqual:@"imageheight"]) {
        NSString *st2=[request responseString];
        NSLog(@"%@",st2);
        
         NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:[st2 dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        
        NSString *st3=[dic objectForKey:@"1"];
       
        [heights addObject:st3];
        
        [self.table reloadData];
        [Mag shard].imageHeightArrrrr = heights;
    }
    if ([request.name isEqual:@"huifuimageheight"]) {
         NSString *st2=[request responseString];
        
        NSLog(@"%@",st2);
        
        
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

//错误网址
- (void)requestFailed:(ASIHTTPRequest *)request

{
    
    NSError *error = [request error];
    [SVProgressHUD showErrorWithStatus:error.localizedDescription];
    
}

@end

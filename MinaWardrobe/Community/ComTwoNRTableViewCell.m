//
//  ComTwoNRTableViewCell.m
//  MinaWardrobe
//
//  Created by 米娜 上海文星广告传媒有限公司 on 15/5/26.
//  Copyright (c) 2015年 wenxing. All rights reserved.
//

#import "ComTwoNRTableViewCell.h"

@implementation ComTwoNRTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)configCellByTradeModel:(NSArray *)trade{
#warning 添加
    self.img1 = [[UIImageView alloc] init];
    self.img1.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bigImageClick1:)];
    [self.img1 addGestureRecognizer:tap1];
    self.img2 = [[UIImageView alloc] init];
    self.img2.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bigImageClick2:)];
    [self.img2 addGestureRecognizer:tap2];
    self.img3 = [[UIImageView alloc] init];
    self.img3.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bigImageClick3:)];
    [self.img3 addGestureRecognizer:tap3];
    
    for (int i=0; i<trade.count; i++) {
        switch (i) {
            case 0:
                 self.img1.frame=CGRectMake(10, 10, WIDTH-20, [[trade objectAtIndex:i] intValue]);
                
                break;
            case 1:
                self.img2.frame=CGRectMake(10, [[trade objectAtIndex:0] intValue]+20, WIDTH-20, [[trade objectAtIndex:i] intValue]);
                
                break;
            case 2:
                self.img3.frame=CGRectMake(10, [[trade objectAtIndex:0] intValue]+[[trade objectAtIndex:1] intValue]+30, WIDTH-20, [[trade objectAtIndex:i] intValue]);
                break;
                
            default:
                break;
        }
        
        
    }
    
    
    
    
   
//     self.img2=[[UIImageView alloc]initWithFrame:CGRectMake(10, 420, 300, 400)];
//     self.img3=[[UIImageView alloc]initWithFrame:CGRectMake(10, 830, 300, 400)];
    [self addSubview:self.img1];
    [self addSubview:self.img2];
    [self addSubview:self.img3];
    
    self.imageArr = [NSMutableArray arrayWithObjects:self.img1, self.img2, self.img3, nil];
    
}

- (void)bigImageClick1:(UITapGestureRecognizer *)sender {
    [self showScrollView:self.imageArr setValue:0];
}
- (void)bigImageClick2:(UITapGestureRecognizer *)sender {
    [self showScrollView:self.imageArr setValue:0];
}
- (void)bigImageClick3:(UITapGestureRecognizer *)sender {
    [self showScrollView:self.imageArr setValue:0];
}

#pragma mark - 图片点击放大
- (void)showScrollView:(NSMutableArray *)bigImage setValue:(NSInteger)value {
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    UIView *backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    backgroundView.backgroundColor=[UIColor blackColor];
    backgroundView.alpha=1;
    
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
        
//        UIImage *image = [[UIImage alloc] init];
//        image = bigImage[i];
//        NSLog(@"%@", image);
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView = bigImage[i];
        NSLog(@"%@", imageView);
        imageView.tag = 100 + i;
        imageView.userInteractionEnabled = NO;
        CGFloat height = imageView.image.size.height * WIDTH / imageView.image.size.width;
        imageView.frame = CGRectMake(0, (HEIGHT - height) / 2, WIDTH, height);
        
        UILongPressGestureRecognizer *longTap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressClick:)];
        [imageView addGestureRecognizer:longTap];
//        [imageView addGestureRecognizer:tap];
        
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


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (void)longPressClick:(UILongPressGestureRecognizer *)sender {

    if(sender.state == UIGestureRecognizerStateBegan)
    {
        UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"诶我擦" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"第一个", nil];
        [action showInView:self.contentView];
        //add your code here
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            NSLog(@"第一个");
            
            
            break;
        default:
            break;
    }
}



- (void)saveImageToPhotos:(UIImage*)savedImage
{
    UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}
// 指定回调方法
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存图片结果提示"
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}

@end

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
    
    
    
    
}

- (void)bigImageClick1:(UITapGestureRecognizer *)sender {
    [self showImage:self.img1];
}
- (void)bigImageClick2:(UITapGestureRecognizer *)sender {
    [self showImage:self.img2];
}
- (void)bigImageClick3:(UITapGestureRecognizer *)sender {
    [self showImage:self.img3];
}

#pragma mark - 点击图片放大
-(void)showImage:(UIImageView *)avatarImageView{
    UIImage *image=avatarImageView.image;
    UIWindow *window=[UIApplication sharedApplication].keyWindow;
    UIView *backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    //    oldframe=[avatarImageView convertRect:avatarImageView.bounds toView:window];
    backgroundView.backgroundColor=[UIColor blackColor];
    backgroundView.alpha=0;
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    imageView.image=image;
    imageView.tag=1;
    [backgroundView addSubview:imageView];
    [window addSubview:backgroundView];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    [backgroundView addGestureRecognizer: tap];
    
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=CGRectMake(0,(HEIGHT-image.size.height*WIDTH/image.size.width)/2, WIDTH, image.size.height*WIDTH/image.size.width);
        backgroundView.alpha=1;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)hideImage:(UITapGestureRecognizer*)tap{
    UIView *backgroundView=tap.view;
    UIImageView *imageView=(UIImageView*)[tap.view viewWithTag:1];
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=CGRectMake(0, 0, 0, 0);
        backgroundView.alpha=0;
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  TaoKeWebViewController.h
//  MinaWardrobe
//
//  Created by apple on 15/5/21.
//  Copyright (c) 2015年 wenxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaoKeWebViewController : UIViewController<UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *taokeWeb;

@property (nonatomic, strong) NSString *comeURL;

@end

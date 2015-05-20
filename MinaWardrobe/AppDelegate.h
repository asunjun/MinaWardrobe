//
//  AppDelegate.h
//  MinaWardrobe
//
//  Created by apple on 15/5/14.
//  Copyright (c) 2015年 wenxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "StoreViewController.h"
#import "CommunityViewController.h"
#import "MySeetingViewController.h"

#import "Reachability.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    Reachability  *hostReach;
}

@property (strong, nonatomic) UIWindow *window;


@end


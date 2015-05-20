//
//  AppDelegate.m
//  MinaWardrobe
//
//  Created by apple on 15/5/14.
//  Copyright (c) 2015年 wenxing. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    [self.window makeKeyAndVisible];
    
    [self mainInit];
    [self netNotification];
    
    return YES;
}

#pragma mark - 导航栏和TabBar
- (void)mainInit {
    UITabBarController *tabarController = [[UITabBarController alloc]init];
    self.window.rootViewController = tabarController;
   tabarController.tabBar.selectedImageTintColor = globalColor;
    //四个tab选项，衣橱，商城，社区，我的，
    
    
    
    MainViewController *mainVC = [[MainViewController alloc] init];
    mainVC.tabBarItem.image = [UIImage imageNamed:@"衣柜.png"];
    mainVC.tabBarItem.selectedImage = [UIImage imageNamed:@"衣柜2.png"];
    
    
     StoreViewController *storeVC = [[StoreViewController alloc] init];
    storeVC.tabBarItem.image = [UIImage imageNamed:@"商城.png"];
    storeVC.tabBarItem.selectedImage = [UIImage imageNamed:@"商城2.png"];
   
    
     CommunityViewController *commVC = [[CommunityViewController alloc] init];
    commVC.tabBarItem.image = [UIImage imageNamed:@"社区.png"];
    commVC.tabBarItem.selectedImage = [UIImage imageNamed:@"社区2.png"];
  
    
    MySeetingViewController *myVC = [[MySeetingViewController alloc] init];
    myVC.tabBarItem.image = [UIImage imageNamed:@"我的.png"];
    myVC.tabBarItem.selectedImage = [UIImage imageNamed:@"我的2.png"];
   
    
    tabarController.viewControllers = @[[[UINavigationController alloc]initWithRootViewController:mainVC],[[UINavigationController alloc]initWithRootViewController:storeVC],[[UINavigationController alloc]initWithRootViewController:commVC],[[UINavigationController alloc]initWithRootViewController:myVC]];
    
    
    
    

}

#pragma mark - 检测网络状态
- (void)netNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    self->hostReach = [Reachability reachabilityWithHostName:@"www.baidu.com"] ;
    [self->hostReach startNotifier]; //开始监听，会启动一个run loop
}

-(BOOL)isNetWorkUsable
{
    BOOL isExistenceNetwork;
    Reachability *r = [Reachability reachabilityWithHostName:@"wap.baidu.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork=NO;
            NSLog(@"没有网络");
            break;
        case ReachableViaWWAN:
            NSLog(@"正在使用3G网络");
            isExistenceNetwork=YES;
            break;
        case ReachableViaWiFi:
            isExistenceNetwork=YES;
            NSLog(@"正在使用wifi网络");
            break;
        default:
            break;
    }
    return isExistenceNetwork;
}
//实时监听网络状态

- (void)reachabilityChanged:(NSNotification *)note {
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    NetworkStatus status = [curReach currentReachabilityStatus];
    
    if (status == NotReachable) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示"
                                                        message:@"没有网络，请检查网络"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

#pragma mark - 原有
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

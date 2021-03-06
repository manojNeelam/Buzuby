//
//  AppDelegate.m
//  Buzuby
//
//  Created by Syntel-Amargoal1 on 5/9/16.
//  Copyright © 2016 com.demo. All rights reserved.
//

#import "AppDelegate.h"
#import "SWRevealViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize selectedData;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];


    if([[NSUserDefaults standardUserDefaults] objectForKey:@"userId"]!=nil)
    [self showHomeVC];
    
    
    return YES;
}

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

-(void)showHomeVC
{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [storyBoard instantiateViewControllerWithIdentifier:@"SWRevealViewController_SB_ID"];
    [self.window setRootViewController:vc];
}

-(void)showLoginVC
{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [storyBoard instantiateViewControllerWithIdentifier:@"LoginVC_SB_ID"];
    UINavigationController *navLogim = [[UINavigationController alloc] initWithRootViewController:vc];
    
    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    if ([[ver objectAtIndex:0] intValue] >= 7) {
        // iOS 7.0 or later
        navLogim.navigationBar.barTintColor = [UIColor colorWithRed:68.0f/255.0f green:78.0f/255.0f blue:85.0f/255.0f alpha:1.0f];
        navLogim.navigationBar.translucent = NO;
    }else {
        // iOS 6.1 or earlier
        navLogim.navigationBar.tintColor = [UIColor colorWithRed:68.0f/255.0f green:78.0f/255.0f blue:85.0f/255.0f alpha:1.0f];;
    }
    [navLogim.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];


    [self.window setRootViewController:navLogim];
}


@end

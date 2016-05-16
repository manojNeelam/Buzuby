//
//  AppDelegate.h
//  Buzuby
//
//  Created by Syntel-Amargoal1 on 5/9/16.
//  Copyright © 2016 com.demo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeData.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property HomeData *selectedData;

-(void)showHomeVC;

-(void)showLoginVC;
@end


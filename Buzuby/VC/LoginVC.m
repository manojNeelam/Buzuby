//
//  LoginVC.m
//  Buzuby
//
//  Created by Pai, Ankeet on 11/05/16.
//  Copyright © 2016 com.demo. All rights reserved.
//

#import "LoginVC.h"
#import "AppDelegate.h"
#import "ForgotPasswordVC.h"
#import "ConnectionsManager.h"


@interface LoginVC ()<ServerResponseDelegate>

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onClickLoginButton:(id)sender
{
    
    NSMutableDictionary* paramDict =
    [NSMutableDictionary dictionaryWithCapacity:1];
    [paramDict setObject:@"test1" forKey:@"userName"];
    //[paramDict setObject:[self.password.text sha1] forKey:@"password"];
    [paramDict setObject:@"test1" forKey:@"password"];
    [paramDict setObject:@"Login" forKey:@"action"];
    
    //  AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    // [delegate showHomeVC];
    
    [[ConnectionsManager sharedManager] loginUser:paramDict withdelegate:self];
    
}

-(void)openHomeVC  //tmp
{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [delegate showHomeVC];
    
}
- (IBAction)onClickRegisterButton:(id)sender
{
    UIViewController *registerVC = [self.storyboard instantiateViewControllerWithIdentifier:RegisterSBID];
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (IBAction)onClickForgotPasswordButton:(id)sender
{
    UIViewController *forgotPassworvc = [self.storyboard instantiateViewControllerWithIdentifier:@"ForgotPasswordVC_SB_ID"];
    [self.navigationController pushViewController:forgotPassworvc animated:YES];
}

-(void)success:(id)response
{
    NSLog(@"success at login");
    
    
    
    NSDictionary *params;
    
    if([response isKindOfClass:[NSString class]])
    {
        NSData *data = [response dataUsingEncoding:NSUTF8StringEncoding];
        params = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    }
    else if ([response isKindOfClass:[NSDictionary class]])
    {
        params = response;
    }
    
    id statusStr_ = [params objectForKey:@"status"];
    NSString *statusStr;
    
    if([statusStr_ isKindOfClass:[NSNumber class]])
    {
        statusStr = [statusStr_ stringValue];
    }
    else
        statusStr = statusStr_;
    
    
    
    NSLog(@"params=%@",params);
    
    if([statusStr isEqualToString:@"200"])
    {
        NSLog(@"Yes i Got");
        NSDictionary *dct=[[params objectForKey:@"data"] objectAtIndex:0];
        [[NSUserDefaults standardUserDefaults] setObject:[dct objectForKey:@"surname"] forKey:@"userName"];
        [[NSUserDefaults standardUserDefaults] setObject:[dct objectForKey:@"userId"] forKey:@"userId"];
        [[NSUserDefaults standardUserDefaults] setObject:[dct objectForKey:@"token"] forKey:@"token"];
        
        
        NSLog(@"dct=%@",dct);
        [self openHomeVC];
    }
    
    
    /* if (isForgotPassword) {
     
     NSString *messageStr = [params objectForKey:@"message"];
     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:[NSString stringWithFormat:@"%@", messageStr] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
     [alert show];
     
     isForgotPassword = NO;
     return;
     }
     */
    /*if([statusStr isEqualToString:@"1"])
     {
     
     dispatch_async(dispatch_get_main_queue(), ^{
     
     NSDictionary *responseDict = (NSDictionary *)response
     ;
     if ([responseDict[@"status"] boolValue]) {
     
     //            children
     NSArray *childrenList = responseDict[@"data"][@"children"];
     if(childrenList.count)
     {
     NSMutableArray *temp = [NSMutableArray array];
     
     for(NSDictionary *dict in childrenList)
     {
     ChildDetailsData *child = [[ChildDetailsData alloc] initwithDictionary:dict];
     [temp addObject:child];
     }
     
     NSArray *childHolder = temp;
     
     AppDelegate *appdelegate = [UIApplication sharedApplication].delegate;
     [appdelegate setListOfChildrens:childHolder];
     
     [NSUserDefaults saveBool:NO forKey:IS_CHILD_NOT_AVAILABLE];
     
     
     [self openHomeVC];
     }
     else
     {
     [NSUserDefaults saveBool:YES forKey:IS_FROM_SIGNUP];
     [NSUserDefaults saveBool:YES forKey:IS_CHILD_NOT_AVAILABLE];
     [self openHomeVC];
     }
     }
     else{
     
     [self.bgImg setHidden:YES];
     
     [Constants showOKAlertWithTitle:@"Error" message:@"Unagle to load your childrans list, Please try again after some time" presentingVC:self];
     }
     });
     
     
     NSString *messageStr = [params objectForKey:@"message"];
     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:[NSString stringWithFormat:@"%@", messageStr] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
     [alert show];
     
     }
     else if([statusStr isEqualToString:@"0"])
     {
     [self.bgImg setHidden:YES];
     
     NSString *messageStr = [params objectForKey:@"message"];
     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:[NSString stringWithFormat:@"%@", messageStr] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
     //[alert show];
     [self openHomeVC];
     
     }
     */
}

-(void)failure:(id)response
{
    
    NSLog(@"fail at login");
}

@end

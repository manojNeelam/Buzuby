//
//  ForgotPasswordVC.m
//  Buzuby
//
//  Created by Pai, Ankeet on 15/05/16.
//  Copyright © 2016 com.demo. All rights reserved.
//

#import "ForgotPasswordVC.h"
#import "ConnectionsManager.h"
#import "NSString+CommonForApp.h"

@interface ForgotPasswordVC ()<ServerResponseDelegate>

@end

@implementation ForgotPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"Forgot Password"];
    
    // Do any additional setup after loading the view.
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backButton"] style:UIBarButtonItemStyleDone target:self action:@selector(onClickBackbutton:)]];
    
    // Do any additional setup after loading the view.
}


-(BOOL)isValidData
{
    
    if([self.txtFldUserName.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter  User Name" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }
    if([self.txtfldEmail.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter  Registerd Mail" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }
    return YES;
}

- (IBAction)onClickNextButton:(id)sender {
    
    if([self isValidData])
    {
        NSMutableDictionary* paramDict =
        [NSMutableDictionary dictionaryWithCapacity:1];
        
        [paramDict setObject:self.txtFldUserName forKey:@"userName"];
        [paramDict setObject:self.txtfldEmail.text forKey:@"email"];
        [paramDict setObject:@"ForgotPassword" forKey:@"action"];
        
        [[ConnectionsManager sharedManager] loginUser:paramDict withdelegate:self];
        
        
        /*userName, email*/
    }
}

-(void)success:(id)response
{
    NSLog(@"success at login");
    
    //userId, token
    
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
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:[params objectForKey:@"status"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
    }
    else
    {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:[params objectForKey:@"status"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)onClickForgotPasswordButton:(id)sender {
    
}
@end

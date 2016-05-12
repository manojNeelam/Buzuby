//
//  LoginVC.m
//  Buzuby
//
//  Created by Pai, Ankeet on 11/05/16.
//  Copyright © 2016 com.demo. All rights reserved.
//

#import "LoginVC.h"
#import "AppDelegate.h"


@interface LoginVC ()

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
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [delegate showHomeVC];
    
    //UIViewController *registerVC = [self.storyboard instantiateViewControllerWithIdentifier:PreferenceSBID];
    //[self.navigationController pushViewController:registerVC animated:YES];
}

- (IBAction)onClickRegisterButton:(id)sender
{
    UIViewController *registerVC = [self.storyboard instantiateViewControllerWithIdentifier:RegisterSBID];
    [self.navigationController pushViewController:registerVC animated:YES];
}

- (IBAction)onClickForgotPasswordButton:(id)sender
{
    
}
@end

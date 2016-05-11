//
//  LoginVC.h
//  Buzuby
//
//  Created by Pai, Ankeet on 11/05/16.
//  Copyright © 2016 com.demo. All rights reserved.
//

#import "BaseViewController.h"

@interface LoginVC : BaseViewController
@property (weak, nonatomic) IBOutlet DefaultTextField *txtFldUserName;
@property (weak, nonatomic) IBOutlet DefaultTextField *txtFldPasword;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;

@property (weak, nonatomic) IBOutlet UIButton *btnRegister;
@property (weak, nonatomic) IBOutlet UIButton *btnForgotPassword;


- (IBAction)onClickLoginButton:(id)sender;
- (IBAction)onClickRegisterButton:(id)sender;
- (IBAction)onClickForgotPasswordButton:(id)sender;
@end

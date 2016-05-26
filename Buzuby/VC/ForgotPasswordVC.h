//
//  ForgotPasswordVC.h
//  Buzuby
//
//  Created by Pai, Ankeet on 15/05/16.
//  Copyright © 2016 com.demo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface ForgotPasswordVC : BaseViewController
@property (weak, nonatomic) IBOutlet DefaultTextField *txtfldEmail;

@property (weak, nonatomic) IBOutlet UIButton *btnForgotPassword;
- (IBAction)onClickForgotPasswordButton:(id)sender;
@property (weak, nonatomic) IBOutlet DefaultTextField *txtFldUserName;

@end

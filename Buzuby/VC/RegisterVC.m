//
//  RegisterVC.m
//  Buzuby
//
//  Created by Pai, Ankeet on 11/05/16.
//  Copyright © 2016 com.demo. All rights reserved.
//

#import "RegisterVC.h"

@interface RegisterVC ()
@property (weak, nonatomic) IBOutlet DefaultTextField *txtFldFirstName;
@property (weak, nonatomic) IBOutlet DefaultTextField *txtFldLastName;
@property (weak, nonatomic) IBOutlet DefaultTextField *txtFldUserName;
@property (weak, nonatomic) IBOutlet DefaultTextField *txtFldPassword;
@property (weak, nonatomic) IBOutlet DefaultTextField *txtFldReenterPassword;
@property (weak, nonatomic) IBOutlet DefaultTextField *txtFldEmail;
@property (weak, nonatomic) IBOutlet DefaultTextField *txtFldCountryCode;
@property (weak, nonatomic) IBOutlet DefaultTextField *txtFldDay;

@property (weak, nonatomic) IBOutlet DefaultTextField *txtFldPhoneNumber;

@property (weak, nonatomic) IBOutlet DefaultTextField *txtFldMonth;
@property (weak, nonatomic) IBOutlet DefaultTextField *txtFldYear;
@property (weak, nonatomic) IBOutlet DefaultTextField *txtFldAddress;
@property (weak, nonatomic) IBOutlet DefaultTextField *txtFldCountry;
@property (weak, nonatomic) IBOutlet DefaultTextField *txtFldCity;
@property (weak, nonatomic) IBOutlet DefaultTextField *txtFldProvience;
@property (weak, nonatomic) IBOutlet DefaultTextField *txtFldSearch;
@property (weak, nonatomic) IBOutlet UIButton *btnGPS;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;
- (IBAction)onClickGPSButton:(id)sender;
- (IBAction)onClickNextButton:(id)sender;



@end

@implementation RegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"Register"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews
{
    [self.scrollview setContentSize:CGSizeMake(self.view.frame.size.width, self.baseSuburbView.frame.size.height + self.baseSuburbView.frame.origin.y + 80)];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onClickGPSButton:(id)sender
{
    
}

- (IBAction)onClickNextButton:(id)sender {
}
@end

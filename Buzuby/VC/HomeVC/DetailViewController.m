//
//  DetailVCViewController.m
//  Buzuby
//
//  Created by Pai, Ankeet on 15/05/16.
//  Copyright © 2016 com.demo. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"BuZuaby"];
    
    [self customScreen];
    
    // Do any additional setup after loading the view.
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backButton"] style:UIBarButtonItemStyleDone target:self action:@selector(onClickBackbutton:)]];
    
    // Do any additional setup after loading the view.
}

-(void)onClickBackbutton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)customScreen
{
    self.baseRatingView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.baseRatingView.layer.borderWidth = 1.0f;
    
    self.baseSpecialityView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.baseSpecialityView.layer.borderWidth = 1.0f;
    
    self.baseAboutUSView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.baseAboutUSView.layer.borderWidth = 1.0f;
    
    self.baseAminitiView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.baseAminitiView.layer.borderWidth = 1.0f;
    
    self.holderStoreTimingsview.layer.borderColor = [UIColor whiteColor].CGColor;
    self.holderStoreTimingsview.layer.borderWidth = 1.0f;
    
    self.baseDaysView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.baseDaysView.layer.borderWidth = 1.0f;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews
{
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.baseStoreTimingsView.frame.origin.y+self.baseStoreTimingsView.frame.size.height + 80)];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

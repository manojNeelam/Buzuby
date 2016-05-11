//
//  SearchViewController.m
//  Buzuby
//
//  Created by Pai, Ankeet on 11/05/16.
//  Copyright © 2016 com.demo. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@property (weak, nonatomic) IBOutlet DefaultTextField *txtFldSearch;
@property (weak, nonatomic) IBOutlet DefaultTextField *txtFldCatOption;
@property (weak, nonatomic) IBOutlet DefaultTextField *txtFldSubCatOption;
@property (weak, nonatomic) IBOutlet DefaultTextField *txtFldSubCatOption2;

@property (weak, nonatomic) IBOutlet UIButton *btnPreference;
@property (weak, nonatomic) IBOutlet UIButton *btnSearch;

- (IBAction)onClickPreferenceButton:(id)sender;
- (IBAction)onClickSearchbutton:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnNext;
- (IBAction)onClickNextButton:(id)sender;


@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)onClickPreferenceButton:(id)sender
{
    UIViewController *searchVC = [self.storyboard instantiateViewControllerWithIdentifier:SearchSBID];
    [self.navigationController pushViewController:searchVC animated:YES];
}

- (IBAction)onClickSearchbutton:(id)sender
{
    
}


- (IBAction)onClickNextButton:(id)sender
{
    
}
@end

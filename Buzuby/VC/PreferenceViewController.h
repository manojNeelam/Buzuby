//
//  PreferenceViewController.h
//  Buzuby
//
//  Created by Pai, Ankeet on 11/05/16.
//  Copyright © 2016 com.demo. All rights reserved.
//

#import "BaseViewController.h"

@interface PreferenceViewController : BaseViewController
@property (weak, nonatomic) IBOutlet DefaultTextField *txtFldCatOption;
@property (weak, nonatomic) IBOutlet DefaultTextField *txtFldRadiusOption;
@property (weak, nonatomic) IBOutlet DefaultTextField *txtFldCategoryOption;
@property (weak, nonatomic) IBOutlet DefaultTextField *txtFldPriceOption;

@property (weak, nonatomic) IBOutlet DefaultTextField *txtFldShowResultOption;
@property (weak, nonatomic) IBOutlet UIButton *btnPreference;
@property (weak, nonatomic) IBOutlet UIButton *btnSearch;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;
- (IBAction)onClickPreferenceButton:(id)sender;
- (IBAction)onClickNextButton:(id)sender;
- (IBAction)onClickSearchButton:(id)sender;
@end

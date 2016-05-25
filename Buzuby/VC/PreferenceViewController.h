//
//  PreferenceViewController.h
//  Buzuby
//
//  Created by Pai, Ankeet on 11/05/16.
//  Copyright © 2016 com.demo. All rights reserved.
//

#import "BaseViewController.h"
#import "NIDropDown.h"
#import <CoreLocation/CoreLocation.h>
@interface PreferenceViewController : BaseViewController<CLLocationManagerDelegate>
{
    NIDropDown *dropDown;
    CLLocationManager *locationManager;
}
@property (nonatomic, assign) BOOL isFromSettings;

@property (weak, nonatomic) IBOutlet DefaultTextField *txtFldCatOption;
@property (weak, nonatomic) IBOutlet DefaultTextField *txtFldRadiusOption;
@property (weak, nonatomic) IBOutlet UIButton *btnCategoryOption;

@property (weak, nonatomic) IBOutlet UIButton *btnNext;
- (IBAction)onClickNextButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *baseCurrencyTypeView;

- (IBAction)onCllickCategoryButton:(id)sender;

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *btnSubcategory;
- (IBAction)onClickSubcategoryButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnSubSubCategory;
- (IBAction)onClickSubSubCategoryButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnPrice;
- (IBAction)onClickPriceButton:(id)sender;


@property (weak, nonatomic) IBOutlet UIView *baseCategoryView;
@property (weak, nonatomic) IBOutlet UIView *baseSubcategoryView;
@property (weak, nonatomic) IBOutlet UIView *baseSubSubCategoryView;

@property (weak, nonatomic) IBOutlet UIView *baseCategoryTitleView;
@property (weak, nonatomic) IBOutlet UIView *baseSubCategoryTitleView;
@property (weak, nonatomic) IBOutlet UIView *baseSubSubCategoryTitleView;
@property (weak, nonatomic) IBOutlet UITextField *txtCurrencyType;
@property (weak, nonatomic) IBOutlet UIButton *btnLocztion;
- (IBAction)onClickLocationButon:(id)sender;

@end

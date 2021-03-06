//
//  PreferenceViewController.m
//  Buzuby
//
//  Created by Pai, Ankeet on 11/05/16.
//  Copyright © 2016 com.demo. All rights reserved.
//

#import "PreferenceViewController.h"
#import "ConnectionsManager.h"
#import "NIDropDown.h"
#import "CategoryData.h"
#import "SubCategoryData.h"
#import "SubSubCategoryData.h"
#import "AppDelegate.h"
#import "NSString+CommonForApp.h"

@interface PreferenceViewController () <NIDropDownDelegate, ServerResponseDelegate,UITableViewDataSource, UITableViewDelegate>
{
    UIButton *selectedButton;
    UITableView *commonTblView;

    NSArray *catList,*subCatList,*subSubCatList;
    CategoryData *selectedCategory;SubCategoryData  *selectedSubCategory; SubSubCategoryData *selectedSubSubCategory;
    int resultForApi;
    float longitudeLabel,latitudeLabel;
    UIActivityIndicatorView *actt;
    
    NSString *selectedStr;
    
    NSArray *commonList, *currencyList, *radiusList;
    
}
@end

@implementation PreferenceViewController
@synthesize isFromSettings;
-(void)viewWillAppear:(BOOL)animated
{
    NSString *str=[[NSUserDefaults standardUserDefaults] objectForKey:@"locationPoint"];
    if(str!=nil)
        _txtFldCatOption.text=str;
    [_txtFldCatOption setUserInteractionEnabled:NO];
    [self.startPrice setKeyboardType:UIKeyboardTypeNumberPad];
    [self.endPrice setKeyboardType:UIKeyboardTypeNumberPad];
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    longitudeLabel=0;
    latitudeLabel=0;
    
    [self.btnPrice setTitle:@"dollar" forState:UIControlStateNormal];
    
    commonList = [[NSArray alloc] initWithObjects:@"All",@"Dining", @"Monitoring", @"Services", @"Stores", nil];
    
    currencyList = [[NSArray alloc] initWithObjects:@"dollar",@"euro", @"rand", nil];
    
    radiusList = [[NSArray alloc] initWithObjects:@"5",@"10",@"15",@"20",@"25",@"30",@"35", @"40", @"45", @"50", @"55", nil];
    
    commonTblView = [[UITableView alloc] init];
    [commonTblView setBackgroundColor:[UIColor colorWithRed:49.0/255.0 green:191.0/255.0 blue:180.0/255.0 alpha:1.0]];
    commonTblView.backgroundView = nil;
    [commonTblView setDataSource:self];
    [commonTblView setDelegate:self];
    [commonTblView setHidden:YES];
    
    [self.scrollView addSubview:commonTblView];
    
    
    locationManager = [[CLLocationManager alloc] init];
    

    
    
    if(self.isFromSettings)
    {
        [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backButton"] style:UIBarButtonItemStyleDone target:self action:@selector(onClickBackbutton:)]];
    }
    
   //   [self getMyLocationPoint];
    
    // Do any additional setup after loading the view.

    resultForApi=1;  //1 for catlist,2 for sub cat list 3 for subsub cat list

    [self performSelector:@selector(makeRequestForgetAllCategory) withObject:nil afterDelay:0.2];

//[self performSelector:@selector(makeRequestgetSubCategoryByCategoryId) withObject:nil afterDelay:1.0];

//[self performSelector:@selector(makeRequestgetSubSubCategoryBySubCategoryId) withObject:nil afterDelay:1.5];

}

-(void)getMyLocationPoint
{
    NSLog(@"getMyLocationPoint");
    actt=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.view addSubview:actt];
    [actt startAnimating];
    actt.center=self.view.center;
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [locationManager requestWhenInUseAuthorization];
    }
    [locationManager startUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [actt stopAnimating];
    [actt removeFromSuperview];
    actt=nil;
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [actt stopAnimating];
    [actt removeFromSuperview];
    actt=nil;
    
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil)
    {
        longitudeLabel=currentLocation.coordinate.longitude;
        latitudeLabel=currentLocation.coordinate.latitude;
        
        NSLog(@"longitudeLabel=%f latitudeLabel=%f",longitudeLabel,latitudeLabel);
        
        _txtFldCatOption.text=[NSString stringWithFormat:@"%f ,%f",longitudeLabel,latitudeLabel];
        [[NSUserDefaults standardUserDefaults] setObject:_txtFldCatOption.text forKey:@"locationPoint"];
    }
}



-(void)makeRequestForgetAllCategory
{
    
    NSMutableDictionary* paramDict =
    [NSMutableDictionary dictionaryWithCapacity:1];
    
    NSString *strToken=[[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    [paramDict setObject:strToken forKey:@"token"];
    
    NSString *strUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    [paramDict setObject:strUserId forKey:@"userId"];
    
    [paramDict setObject:@"getAllCategory" forKey:@"action"];
    
    [[ConnectionsManager sharedManager] getMyFaviroteData:paramDict withdelegate:self];
    
}


-(void)onClickBackbutton:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

/*-(void)viewDidLayoutSubviews
{
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width,500)];
}
*/
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width,500)];
    
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

-(BOOL)isValidData
{
    
    if([self.txtFldCatOption.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please Press Gps Icon to get Location" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }
   
    if([self.startPrice.text isEmpty]||[self.endPrice.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter Price" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }
    
    
    return YES;
}



- (IBAction)onClickNextButton:(id)sender
{
    
    if([self isValidData])
    {
        // resultForApi=4;
        NSMutableDictionary* paramDict =
        [NSMutableDictionary dictionaryWithCapacity:1];
        
        NSString *strToken=[[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
        [paramDict setObject:strToken forKey:@"token"];
        
        NSString *strUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
        [paramDict setObject:strUserId forKey:@"userId"];
        
        
        if([[self.btnCategoryOption titleForState:UIControlStateNormal] isEqualToString:@"All"])
        {
            [paramDict setObject:@"0" forKey:@"categoryId"];
            [paramDict setObject:@"0" forKey:@"subCategoryId"];
            [paramDict setObject:@"0" forKey:@"subSubCategoryId"];
        }
        else
        {
            [paramDict setObject:[self.btnCategoryOption titleForState:UIControlStateNormal] forKey:@"categoryId"];
            
            if([[self.btnSubcategory titleForState:UIControlStateNormal] isEqualToString:@"All"])
                [paramDict setObject:@"0" forKey:@"subCategoryId"];
            else
                [paramDict setObject:[self.btnSubcategory titleForState:UIControlStateNormal] forKey:@"subCategoryId"];
            
            if([[self.btnSubSubCategory titleForState:UIControlStateNormal] isEqualToString:@"All"])
                [paramDict setObject:@"0" forKey:@"subSubCategoryId"];
            else
                [paramDict setObject:[self.btnSubSubCategory titleForState:UIControlStateNormal] forKey:@"subSubCategoryId"];
            
        }
        
        
        
        [paramDict setObject:[[_txtFldCatOption.text componentsSeparatedByString:@","] objectAtIndex:0] forKey:@"latitude"];
        [paramDict setObject:[[_txtFldCatOption.text componentsSeparatedByString:@","] objectAtIndex:1] forKey:@"longitude"];
      //  [paramDict setObject:[self.btnRadius titleForState:UIControlStateNormal] forKey:@"radius"];
        [paramDict setObject:@"0" forKey:@"radius"];

        [paramDict setObject:[self.btnPrice titleForState:UIControlStateNormal] forKey:@"currencySymbol"];
        [paramDict setObject:self.startPrice.text forKey:@"priceFrom"];
        [paramDict setObject:self.endPrice.text forKey:@"priceTo"];
        
        
        [paramDict setObject:@"getDealEventsByPreference" forKey:@"action"];
        
        NSLog(@"onClickNextButton paramDict=%@",paramDict);
        
        [[NSUserDefaults standardUserDefaults] setObject:paramDict forKey:@"prefernceData"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"toPop"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"preferenceSet"];
        
        
        
        //[[ConnectionsManager sharedManager] getMyFaviroteData:paramDict withdelegate:self];
        
        
        UIViewController *dealsvc = [self.storyboard instantiateViewControllerWithIdentifier:@"DealsAndEventsVC_SB_ID"];
        [self.navigationController pushViewController:dealsvc animated:YES];
        
        
        
    }
    //  token, userId, latitude, longitude, radius, categoryId, subCategoryId, subSubCategoryId, currencySymbol, priceFrom, priceTo
    
    
    /*  radius is the area in which you have to lookup while selecting deals and events.
     currecySymbol would be string with possible value of dollar, euro,rand for now
     categoryId, subCategoryId and subSubCategoryId would be 0 if user has selcted All in dropdown.*/
    //  UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchDetailVC_SB_ID"];
    //  [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)onClickSubcategoryButton:(id)sender
{
    selectedStr = nil;
    [self makeRequestgetSubCategoryByCategoryId];
}

- (IBAction)onCllickCategoryButton:(id)sender
{
    selectedStr = nil;
    [self openDropdown:catList withSender:sender withDir:@"down"];
}

- (IBAction)onClickSubSubCategoryButton:(id)sender
{
    selectedStr = nil;
    [self makeRequestgetSubSubCategoryBySubCategoryId];
}

- (IBAction)onClickPriceButton:(id)sender
{
    NSLog(@"onClickPriceButton");
    selectedStr = @"price";
    [self openDropdown:currencyList withSender:self.btnPrice withDir:@"up"];
}

-(void)setFrameCommonTableView:(CGRect)frameView andTextFieldRect:(CGRect)frameTxtFld
{
    [commonTblView setFrame:CGRectMake(frameTxtFld.origin.x, frameView.origin.y+frameView.size.height, frameTxtFld.size.width, 44*4)];
    [commonTblView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    [commonTblView setBackgroundColor:[UIColor lightGrayColor]];//[UIColor colorWithRed:49.0/255.0 green:191.0/255.0 blue:180.0/255.0 alpha:1.0]];
   
   [commonTblView setHidden:NO];
   [commonTblView reloadData];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return commonList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
   if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
        [cell setBackgroundColor:[UIColor lightGrayColor]];//[UIColor colorWithRed:49.0/255.0 green:191.0/255.0 blue:180.0/255.0 alpha:1.0]];
    [cell.textLabel setFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
    [cell.textLabel setText:[commonList objectAtIndex:indexPath.row]];
    [cell.textLabel setNumberOfLines:0];
    [cell.textLabel setTextColor:[UIColor whiteColor]];
   [cell.textLabel sizeToFit];
        return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = [commonList objectAtIndex:indexPath.row];
    [commonTblView setHidden:YES];
   if(selectedButton)
    {
       [selectedButton setTitle:str forState:UIControlStateNormal];
   }
}

- (IBAction)onClickLocationButon:(id)sender {
    
    [self getMyLocationPoint];
}


-(void)rel{
    //    [dropDown release];
    dropDown = nil;
}

-(void)openDropdown:(NSArray*)array withSender:(id)sender withDir:(NSString *)dir
{
    if(dropDown == nil) {
        CGFloat f = 132;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :array :nil :dir];
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
    }
}

- (void) niDropDownDelegateMethod: (NIDropDown *) sender withData:(id)Data_ {
    [self rel];
    
    if([Data_ isKindOfClass:[CategoryData class]])
    {
        CategoryData *cat = Data_;
        selectedCategory = cat;
        
        [self.btnCategoryOption setTitle:cat.itemName forState:UIControlStateNormal];
    }
    else if ([Data_ isKindOfClass:[SubCategoryData class]])
    {
        SubCategoryData *cat = Data_;
        selectedSubCategory = cat;
        
        [self.btnSubcategory setTitle:cat.itemName forState:UIControlStateNormal];
    }
    else if ([Data_ isKindOfClass:[SubSubCategoryData class]])
    {
        SubSubCategoryData *cat = Data_;
        selectedSubSubCategory = cat;
        
        [self.btnSubSubCategory setTitle:cat.itemName forState:UIControlStateNormal];
    }
    else if ([Data_ isKindOfClass:[NSString class]])
    {
        if([selectedStr isEqualToString:@"currency"])
        {
            [self.btnPrice setTitle:Data_ forState:UIControlStateNormal];
        }
        else
        {
            [self.btnRadius setTitle:Data_ forState:UIControlStateNormal];

        }
    }
}

-(void)success:(id)response
{
    NSLog(@"success at Home");
    
    
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
        NSArray *arr=[params objectForKey:@"data"];
        
        if(resultForApi==1)
        {
            /*
             {
             itemId = 2;
             itemName = Dining;
             },
             */
            NSLog(@"Category list recived");
            if(arr.count)
            {
                NSMutableArray *catTemp = [NSMutableArray array];
                for(NSDictionary *dict in arr)
                {
                    CategoryData *catData = [[CategoryData alloc] initwithDictionary:dict];
                    [catTemp addObject:catData];
                }
                
                catList = catTemp;
            }
        }
        else if(resultForApi==2)
        {
            /*
             {
             itemId = 19;
             itemName = Accommodation;
             },
             */
            NSLog(@"subCatList list recived");
            if(arr.count)
            {
                NSMutableArray *catTemp = [NSMutableArray array];
                for(NSDictionary *dict in arr)
                {
                    SubCategoryData *catData = [[SubCategoryData alloc] initwithDictionary:dict];
                    [catTemp addObject:catData];
                }
                
                subCatList = catTemp;
                [self openDropdown:subCatList withSender:self.btnSubcategory withDir:@"up"];
            }
        }
        else if(resultForApi==3)
        {
            
            NSLog(@"subSubCatList list recived");
            if(arr.count)
            {
                NSMutableArray *catTemp = [NSMutableArray array];
                for(NSDictionary *dict in arr)
                {
                    SubSubCategoryData *catData = [[SubSubCategoryData alloc] initwithDictionary:dict];
                    [catTemp addObject:catData];
                }
                
                subSubCatList = catTemp;
                [self openDropdown:subSubCatList withSender:self.btnSubSubCategory withDir:@"up"];
            }
        }
        
        else if(resultForApi==4)
        {
            
            NSLog(@"subSubCatList list recived");
            
            AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
            
            delegate.searchList=arr;
            
            /*if(arr.count)
             {
             NSMutableArray *catTemp = [NSMutableArray array];
             for(NSDictionary *dict in arr)
             {
             SubSubCategoryData *catData = [[SubSubCategoryData alloc] initwithDictionary:dict];
             [catTemp addObject:catData];
             }
             
             subSubCatList = catTemp;
             [self openDropdown:subSubCatList withSender:self.btnSubSubCat withDir:@"up"];
             }*/
        }
    }
}

-(void)failure:(id)response
{
    
    NSLog(@"fail at Search");
}

-(void)makeRequestgetSubCategoryByCategoryId
{
    if(!selectedCategory.itemId || selectedCategory.itemId == nil)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please select category" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    resultForApi=2;  //1 for catlist,2 for sub cat list 3 for subsub cat list
    
    NSMutableDictionary* paramDict =
    [NSMutableDictionary dictionaryWithCapacity:1];
    
    NSString *strToken=[[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    [paramDict setObject:strToken forKey:@"token"];
    
    [paramDict setObject:selectedCategory.itemId forKey:@"itemId"];
    
    [paramDict setObject:@"getSubCategoryByCategoryId" forKey:@"action"];
    
    [[ConnectionsManager sharedManager] getMyFaviroteData:paramDict withdelegate:self];
    
}
//selectedSubCategory
-(void)makeRequestgetSubSubCategoryBySubCategoryId
{
    if(!selectedCategory.itemId || selectedCategory.itemId == nil || !selectedSubCategory.itemId || selectedSubCategory.itemId == nil)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please select sub category" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    resultForApi=3;  //1 for catlist,2 for sub cat list 3 for subsub cat list
    
    NSMutableDictionary* paramDict =
    [NSMutableDictionary dictionaryWithCapacity:1];
    
    NSString *strToken=[[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    [paramDict setObject:strToken forKey:@"token"];
    
    // NSString *strUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    [paramDict setObject:selectedSubCategory.itemId forKey:@"itemId"];
    
    [paramDict setObject:@"getSubSubCategoryBySubCategoryId" forKey:@"action"];
    
    [[ConnectionsManager sharedManager] getMyFaviroteData:paramDict withdelegate:self];
}

- (IBAction)onClickRadiusButton:(id)sender
{
    selectedStr = @"currency";
    [self openDropdown:radiusList withSender:self.btnRadius withDir:@"down"];
}
@end

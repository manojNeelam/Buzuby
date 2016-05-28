//
//  RegisterVC.m
//  Buzuby
//
//  Created by Pai, Ankeet on 11/05/16.
//  Copyright © 2016 com.demo. All rights reserved.
//

#import "RegisterVC.h"
#import "ConnectionsManager.h"
#import "NSString+CommonForApp.h"
#import "AppDelegate.h"



@interface RegisterVC ()<ServerResponseDelegate, NIDropDownDelegate>
{
    NSString *lati,*longi;
    float longitudeLabel,latitudeLabel;
    UIActivityIndicatorView *actt;
    
    NSArray *dayArray, *monthAray, *yearArray;
    
    NSString *SelectedStr;
}
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

- (IBAction)onClickYearButton:(id)sender;
- (IBAction)onClickdayButton:(id)sender;
- (IBAction)onClickMonthButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnDay;
@property (weak, nonatomic) IBOutlet UIButton *btnMonth;
@property (weak, nonatomic) IBOutlet UIButton *btnYear;

@end

@implementation RegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    lati=longi=nil;
    
    dayArray = [self day];
    
    monthAray = [self month];
    
    yearArray = [self year];

    
    
    [self.navigationItem setTitle:@"Register"];
    // Do any additional setup after loading the view.
}

-(NSArray *)day
{
    NSMutableArray *temp = [NSMutableArray array];
    for(int i = 1; i<32; i++)
    {
        [temp addObject:[NSString stringWithFormat:@"%d", i]];
    }
    
    return temp;
}

-(NSArray *)month
{
    NSMutableArray *temp = [NSMutableArray array];
    for(int i = 1; i<13; i++)
    {
        [temp addObject:[NSString stringWithFormat:@"%d", i]];
    }
    
    
    return temp;
}

-(NSArray *)year
{
    NSMutableArray *temp = [NSMutableArray array];
    for(int i = 1990; i<2017; i++)
    {
        [temp addObject:[NSString stringWithFormat:@"%d", i]];
    }
    return temp;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews
{
    [self.scrollview setContentSize:CGSizeMake(self.view.frame.size.width, self.baseSuburbView.frame.size.height + self.baseSuburbView.frame.origin.y + 80)];
}



-(BOOL)isValidData
{
    if(lati==nil||longi==nil)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please Click GPS Button to get location" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }
    if([self.txtFldFirstName.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter  First Name" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }
    if([self.txtFldLastName.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter  Last Name" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }
    
    if([self.txtFldUserName.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter  User Name" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }
    
    if([self.txtFldPassword.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter Password" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        return NO;
    }
    
    if([self.txtFldReenterPassword.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please Re enter Password" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        return NO;
    }
    
    if(![self.txtFldPassword.text isEqualToString:self.txtFldReenterPassword.text])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Re Entered Password not matched" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        return NO;
    }
    
    
    
    
    if([self.txtFldEmail.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter  E-mail" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }
    
    if([self.txtFldCountryCode.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter  Country Code" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }
    
    if([self.txtFldPhoneNumber.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter PhoneNumber" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }
    
    if([self.txtFldDay.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter Date of Birth" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }
    
    if([self.txtFldMonth.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter Month of Birth" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }
    
    if([self.txtFldYear.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter Year of Birth" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }
    
    if([self.txtFldAddress.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter your Address" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }
    
    
    if([self.txtFldCity.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter your City" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }
    
    if([self.txtFldProvience.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter your Provience" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }
    
    if([self.txtFldSearch.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please enter your Suburb" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
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
        [paramDict setObject:self.txtFldFirstName.text forKey:@"firstName"];
        [paramDict setObject:self.txtFldLastName.text forKey:@"lastName"];
        
        [paramDict setObject:self.txtFldUserName.text forKey:@"userName"];
        [paramDict setObject:self.txtFldPassword.text forKey:@"password"];
        [paramDict setObject:self.txtFldEmail.text forKey:@"email"];
        [paramDict setObject:self.txtFldCountryCode.text forKey:@"country"];
        
        [paramDict setObject:self.txtFldPhoneNumber.text forKey:@"mobileNumber"];
        
        [paramDict setObject:[NSString stringWithFormat:@"%@-%@-%@",self.txtFldDay.text,self.txtFldMonth.text,self.txtFldYear.text] forKey:@"dob"];
        
        
        [paramDict setObject:self.txtFldAddress.text forKey:@"address"];
        [paramDict setObject:self.txtFldCity.text forKey:@"city"];
        [paramDict setObject:self.txtFldProvience.text forKey:@"province"];
        
        [paramDict setObject:self.txtFldSearch.text forKey:@"suburb"];
        
        [paramDict setObject:lati forKey:@"latitude"];
        [paramDict setObject:longi forKey:@"longitude"];
        
        
        
        [paramDict setObject:@"Registration" forKey:@"action"];
        
        [[ConnectionsManager sharedManager] loginUser:paramDict withdelegate:self];
        
        /*
         firstName, lastName, userName, password, email, country, mobileNumber, dob, address, city, province, suburb,latitude,longitude
         */
    }
}

- (IBAction)onClickYearButton:(id)sender
{
    SelectedStr = @"year";
    [self openDropdown:yearArray withSender:sender withDir:@"down"];
}

- (IBAction)onClickdayButton:(id)sender
{
    SelectedStr = @"day";
    [self openDropdown:dayArray withSender:sender withDir:@"down"];
}

- (IBAction)onClickMonthButton:(id)sender
{
    SelectedStr = @"month";
    [self openDropdown:monthAray withSender:sender withDir:@"down"];
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
        NSLog(@"Yes i Got");
        NSDictionary *dct=[[params objectForKey:@"data"] objectAtIndex:0];
        [[NSUserDefaults standardUserDefaults] setObject:[dct objectForKey:@"surname"] forKey:@"userName"];
        [[NSUserDefaults standardUserDefaults] setObject:[dct objectForKey:@"userId"] forKey:@"userId"];
        [[NSUserDefaults standardUserDefaults] setObject:[dct objectForKey:@"token"] forKey:@"token"];
        
        
        NSLog(@"dct=%@",dct);
        [self openHomeVC];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert!" message:[params objectForKey:@"message"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
    }
    
}

-(void)openHomeVC  //tmp
{
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [delegate showHomeVC];
    
}
-(void)failure:(id)response
{
    
    NSLog(@"fail at Register");
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
    [self getMyLocationPoint];
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
        NSLog(@"longitudeLabel=%f latitudeLabel=%f",currentLocation.coordinate.longitude,currentLocation.coordinate.latitude);

        NSLog(@"longitudeLabel=%f latitudeLabel=%f",longitudeLabel,latitudeLabel);
        
        lati=[NSString stringWithFormat:@"%f",currentLocation.coordinate.latitude];
        longi=[NSString stringWithFormat:@"%f",currentLocation.coordinate.longitude];
        
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@ ,%@",lati,longi] forKey:@"locationPoint"];
    }
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
    
    if ([Data_ isKindOfClass:[NSString class]])
    {
        if([SelectedStr isEqualToString:@"day"])
        {
            [self.btnDay setTitle:Data_ forState:UIControlStateNormal];
        }
        else if([Data_ isEqualToString:@"month"])
        {
            [self.btnMonth setTitle:Data_ forState:UIControlStateNormal];
        }
        else if([Data_ isEqualToString:@"year"])
        {
            [self.btnYear setTitle:Data_ forState:UIControlStateNormal];
        }
    }
}

@end

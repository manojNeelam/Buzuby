//
//  DetailVCViewController.m
//  Buzuby
//
//  Created by Pai, Ankeet on 15/05/16.
//  Copyright © 2016 com.demo. All rights reserved.
//

#import "DetailViewController.h"
#import "AppDelegate.h"
#import "UIImageView+JMImageCache.h"
#import "ConnectionsManager.h"
#import "DetailViewData.h"
#import "CommonWebView.h"

@interface DetailViewController ()<ServerResponseDelegate>
{
    DetailViewData *dt;
    NSMutableArray *ratingArr;
    NSMutableArray *ratingArr2;
    AppDelegate *appdeligate;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *baseAminitesHeight_Cons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *baseAminitesValueHeight_Cons;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    appdeligate = [[UIApplication sharedApplication] delegate];
    [self.navigationItem setTitle:appdeligate.selectedData.name];
    
    [self customScreen];
    
    // Do any additional setup after loading the view.
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backButton"] style:UIBarButtonItemStyleDone target:self action:@selector(onClickBackbutton:)]];
    
    dt=[[DetailViewData alloc] init];
    ratingArr=[[NSMutableArray alloc] init];
    ratingArr2=[[NSMutableArray alloc] init];
    
    
    // Do any additional setup after loading the view.
    
    
    
    //   [self performSelector:@selector(setDataOnView) withObject:nil afterDelay:0.2];
    
    
    self.consBannerBaseHeight.constant = 128.0f;
    self.consBannerImage.constant = 138.0f;
    
    [self.view layoutIfNeeded];
    
    [self performSelector:@selector(makeRequestForDetail) withObject:nil afterDelay:0.2];
    
}

-(void)makeRequestForDetail
{
    NSMutableDictionary* paramDict =
    [NSMutableDictionary dictionaryWithCapacity:1];
    
    NSString *strToken=[[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    [paramDict setObject:strToken forKey:@"token"];
    
    NSString *strUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    [paramDict setObject:strUserId forKey:@"userId"];
    
    [paramDict setObject:appdeligate.selectedData.busId forKey:@"businessId"];
    
    
    [paramDict setObject:@"getBusinessDetailById" forKey:@"action"];
    
    [[ConnectionsManager sharedManager] getMyFaviroteData:paramDict withdelegate:self];
    
}

-(void)setDataOnView
{
    int n=[dt.rating intValue];
    int i=0;
    for(;i<n;i++)
        [ratingArr addObject:@"1"];
    for(;i<5;i++)
        [ratingArr addObject:@"0"];
    
    
    _lblTitle.text=dt.name;
    NSLog(@"name=%@",dt.name);
    
    [_logoImg setImageWithURL:[NSURL URLWithString:dt.imgCat] placeholder:[UIImage imageNamed:@"left_part.png"]];
    [_bannerImage setImageWithURL:[NSURL URLWithString:dt.bannerUrl] placeholder:nil];
    
    [_bannerImage setContentMode:UIViewContentModeScaleAspectFill];
    [_bannerImage setClipsToBounds:YES];
    
    _lblAdvertise.text=[NSString stringWithFormat:@"%@",dt.specialize_in];
    
    CGSize size = [self stringSize:_lblAvertise forStr:dt.province];
    float heightAboutus = ceilf(size.height);
    if(heightAboutus > 18.0f)
    {
        //aboutUsHeight_Cons 81
        
        float diff = heightAboutus - 18.0f;
        self.aboutUsHeight_Cons.constant = 81 + diff;
    }
    
    _lblAvertise.text =[NSString stringWithFormat:@"%@",dt.province]; //about Us
    
    
    NSArray *aminities = [dt.amenities componentsSeparatedByString:@","];
    
    if(aminities.count)
    {
        //ddd
        self.baseAminitesHeight_Cons.constant = 81+(aminities.count-1)*25;
        
        self.baseAminitesValueHeight_Cons.constant = aminities.count*25;
        
        CGRect frame = CGRectMake(0, 5, 280, 21);
        for(NSString *str in aminities)
        {
            UILabel *lbl = [[UILabel alloc] initWithFrame:frame];
            [lbl setText:[NSString stringWithFormat:@"<< %@", str]];
            [lbl setTextColor:[UIColor whiteColor]];
            [lbl setFont:[UIFont systemFontOfSize:09.0f]];
            [self.baseaminitiesValueView addSubview:lbl];
            
            CGRect frameSub = frame;
            frameSub.origin.y = frameSub.origin.y + frameSub.size.height + 2;
            frame = frameSub;
        }
        
        [self.view layoutIfNeeded];
    }
    
    
    _lblLocation.text=[NSString stringWithFormat:@"%@",dt.address];  //address
    _lblContact.text=[NSString stringWithFormat:@"%@",dt.phone];  //address
    _lblLink.text=[NSString stringWithFormat:@"%@",dt.website_link];  //address
    
    
    
    
    _lblMonStartTime.text=[[dt.operatingTimeArray objectAtIndex:0] objectForKey:@"startTime"];
    _lblMonEndTime.text=[[dt.operatingTimeArray objectAtIndex:0] objectForKey:@"endTime"];
    
    _lblTueTitle.text=[[dt.operatingTimeArray objectAtIndex:1] objectForKey:@"startTime"];
    _lblTueTitle.text=[[dt.operatingTimeArray objectAtIndex:1] objectForKey:@"endTime"];
    
    _lblWedStartTime.text=[[dt.operatingTimeArray objectAtIndex:2] objectForKey:@"startTime"];
    _lblWedEndTime.text=[[dt.operatingTimeArray objectAtIndex:2] objectForKey:@"endTime"];
    
    _lblThurStartTime.text=[[dt.operatingTimeArray objectAtIndex:3] objectForKey:@"startTime"];
    _lblThurEndTime.text=[[dt.operatingTimeArray objectAtIndex:3] objectForKey:@"endTime"];
    
    _lblFriStartTime.text=[[dt.operatingTimeArray objectAtIndex:4] objectForKey:@"startTime"];
    _lblFriEndTime.text=[[dt.operatingTimeArray objectAtIndex:4] objectForKey:@"endTime"];
    
    _lblSatStartTime.text=[[dt.operatingTimeArray objectAtIndex:5] objectForKey:@"startTime"];
    _lblSatEndTime.text=[[dt.operatingTimeArray objectAtIndex:5] objectForKey:@"endTime"];
    
    _lblSunStartTime.text=[[dt.operatingTimeArray objectAtIndex:6] objectForKey:@"startTime"];
    _lblSunEndTime.text=[[dt.operatingTimeArray objectAtIndex:6] objectForKey:@"endTime"];
    
    
    
    
    //  _lblDesc.text=[NSString stringWithFormat:@"Price Range %@-%@ %@",dt.rangeFrom,dt.rangeTo,dt.currencySymbol];
    
    
    [self drawStarOnView];
}

-(CGSize)stringSize:(UILabel *)lbl forStr:(NSString *)aStr
{
    CGSize maximumSize = CGSizeMake(lbl.frame.size.width, 9999);
    UIFont *myFont = lbl.font;//[UIFont fontWithName:@"Helvetica" size:14];
    CGSize myStringSize = [aStr sizeWithFont:myFont
                           constrainedToSize:maximumSize
                               lineBreakMode:lbl.lineBreakMode];
    
    return myStringSize;
}


-(void)drawStarOnView
{
    int i;
    float gap=(self.baseRatingView.frame.size.width-250)/6;
    for(i=0;i<5;i++)
    {
        UIButton *bt=[[UIButton alloc] initWithFrame:CGRectMake((i+1)*gap+i*50, self.baseRatingView.frame.size.height/2-25, 50, 50)];
        if([[ratingArr objectAtIndex:i] isEqualToString:@"0"])
            [ bt setBackgroundImage:[UIImage imageNamed:@"star_normal.png"] forState:UIControlStateNormal];
        else
            [ bt setBackgroundImage:[UIImage imageNamed:@"star_selected.png"] forState:UIControlStateNormal];
        
        [self.baseRatingView addSubview:bt];
        bt.tag=i;
        // [bt addTarget:self action:@selector(onStarClick:) forControlEvents:UIControlEventTouchUpInside];
        [bt addTarget:self action:@selector(drawStarOnPopView) forControlEvents:UIControlEventTouchUpInside];
        
    }
}

-(void)startPopViewRemove:(UIGestureRecognizer*)rec
{
    [[rec view] removeFromSuperview];
    int k=0;
    for(NSString *s in ratingArr2)
    {
        if([s isEqualToString:@"1"])
            k++;
        
    }
    int n=[dt.ratingProvidedByUser intValue];
    if(k!=n)
    {
        NSLog(@"startPopViewRemove Update star view value");
        [self sendAddRemoveRating:[NSString stringWithFormat:@"%d",k]];
    }
}

- (void)sendAddRemoveRating:(NSString*)rating
{
    //token, userId, businessId, rating
    
    NSLog(@"favoriteClicked businessName=%@",dt.name);
    
    NSMutableDictionary* paramDict =
    [NSMutableDictionary dictionaryWithCapacity:1];
    
    NSString *strToken=[[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    [paramDict setObject:strToken forKey:@"token"];
    
    NSString *strUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    [paramDict setObject:strUserId forKey:@"userId"];
    
    
    [paramDict setObject:rating forKey:@"rating"];
    
    [paramDict setObject:dt.busId forKey:@"businessId"];
    
    
    [paramDict setObject:@"AddRatingToBusiness" forKey:@"action"];
    
    
    [[ConnectionsManager sharedManager] getMyFaviroteData:paramDict withdelegate:self];
    
}


-(void)drawStarOnPopView
{
    NSLog(@"drawStarOnPopView");
    UIView *v=[[UIView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:v];
    UITapGestureRecognizer *tp=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startPopViewRemove:)];
    [v addGestureRecognizer:tp];
    
    UIView *v2=[[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-100, self.view.frame.size.height/2-50, 200, 100)];
    [v addSubview:v2];
    [v2 setBackgroundColor:[UIColor colorWithRed:192.0/255.0 green:98.0/255.0 blue:46.0/255.0 alpha:1]];
    [[v2 layer] setBorderColor:[UIColor whiteColor].CGColor];
    [[v2 layer] setBorderWidth:2.0];
    
    int n=[dt.ratingProvidedByUser intValue];
    int i=0;
    for(;i<n;i++)
        [ratingArr2 addObject:@"1"];
    for(;i<5;i++)
        [ratingArr2 addObject:@"0"];
    
    
    float gap=(self.baseRatingView.frame.size.width-250)/6;
    for(i=0;i<5;i++)
    {
        UIButton *bt=[[UIButton alloc] initWithFrame:CGRectMake(i*40, 30, 40, 40)];
        if([[ratingArr2 objectAtIndex:i] isEqualToString:@"0"])
            [ bt setBackgroundImage:[UIImage imageNamed:@"star_normal.png"] forState:UIControlStateNormal];
        else
            [ bt setBackgroundImage:[UIImage imageNamed:@"star_selected.png"] forState:UIControlStateNormal];
        
        [v2 addSubview:bt];
        bt.tag=i+1;
        [bt addTarget:self action:@selector(onStarClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}




-(void)onStarClick:(UIButton*)bt
{
    int n=(int)bt.tag;
    
    if([[bt backgroundImageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"star_selected.png"]])
    {
        for(int i=n-1;i<5;i++)
        {
            UIButton *bt1=(UIButton*)[bt.superview viewWithTag:i+1];
            if([[bt1 backgroundImageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"star_selected.png"]])
            {
                [ bt1 setBackgroundImage:[UIImage imageNamed:@"star_normal.png"] forState:UIControlStateNormal];
                [ratingArr2 replaceObjectAtIndex:i withObject:@"0"];
            }
            
            
        }
        //[ bt setBackgroundImage:[UIImage imageNamed:@"star_normal.png"] forState:UIControlStateNormal];
        // [ratingArr2 replaceObjectAtIndex:n-1 withObject:@"0"];
        
    }
    else
    {
        for(int i=0;i<n;i++)
        {
            UIButton *bt1=(UIButton*)[bt.superview viewWithTag:i+1];
            if([[bt1 backgroundImageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"star_normal.png"]])
            {
                [ bt1 setBackgroundImage:[UIImage imageNamed:@"star_selected.png"] forState:UIControlStateNormal];
                [ratingArr2 replaceObjectAtIndex:i withObject:@"1"];
            }
            /* else if([[bt backgroundImageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"star_selected.png"]])
             {
             [ bt setBackgroundImage:[UIImage imageNamed:@"star_normal.png"] forState:UIControlStateNormal];
             [ratingArr2 replaceObjectAtIndex:n withObject:@"0"];
             
             
             }*/
            
        }
    }
}

/*
 -(void)onStarClick:(UIButton*)bt
 {
 int n=(int)bt.tag;
 if([[bt backgroundImageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"star_normal.png"]])
 {
 [ bt setBackgroundImage:[UIImage imageNamed:@"star_selected.png"] forState:UIControlStateNormal];
 [ratingArr2 replaceObjectAtIndex:n withObject:@"1"];
 
 }
 else if([[bt backgroundImageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"star_selected.png"]])
 {
 [ bt setBackgroundImage:[UIImage imageNamed:@"star_normal.png"] forState:UIControlStateNormal];
 [ratingArr2 replaceObjectAtIndex:n withObject:@"0"];
 
 
 }
 }*/



-(void)onClickBackbutton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


UIButton *btn2;
//-(void)onClickRemovefromFav:(UIButton*)bt
- (IBAction)onClickRemovefromFav:(UIButton*)bt
{
    btn2=bt;
    
    NSLog(@"favoriteClicked businessName=%@",dt.name);
    
    NSMutableDictionary* paramDict =
    [NSMutableDictionary dictionaryWithCapacity:1];
    
    NSString *strToken=[[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    [paramDict setObject:strToken forKey:@"token"];
    
    NSString *strUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    [paramDict setObject:strUserId forKey:@"userId"];
    
    [paramDict setObject:dt.busId forKey:@"businessId"];
    
    
    [paramDict setObject:@"addBusinessToFavorite" forKey:@"action"];
    
    
    [[ConnectionsManager sharedManager] getMyFaviroteData:paramDict withdelegate:self];
    
}




-(void)customScreen
{
    
    
    self.baseRemovefromFavouriteView.backgroundColor=[UIColor clearColor];
    self.baseRemovefromFavouriteView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.baseRemovefromFavouriteView.layer.borderWidth = 1.5f;
    
    
    self.baseRatingView.backgroundColor=[UIColor clearColor];
    self.baseRatingView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.baseRatingView.layer.borderWidth = 1.5f;
    
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
    
    UITapGestureRecognizer *tapRecognizermail = [[UITapGestureRecognizer alloc]
                                                 initWithTarget:self action:@selector(openMail)];
    [tapRecognizermail setNumberOfTouchesRequired:1];
    [self.lblLocation addGestureRecognizer:tapRecognizermail];
    [self.lblLocation setUserInteractionEnabled:YES];
    tapRecognizermail=nil;
    
    UITapGestureRecognizer *tapRecognizerWeb = [[UITapGestureRecognizer alloc]
                                                initWithTarget:self action:@selector(openWeb)];
    [tapRecognizerWeb setNumberOfTouchesRequired:1];
    [self.lblLink addGestureRecognizer:tapRecognizerWeb];
    [self.lblLink setUserInteractionEnabled:YES];
    tapRecognizerWeb=nil;
    
    UITapGestureRecognizer *tapRecognizerPhone = [[UITapGestureRecognizer alloc]
                                                  initWithTarget:self action:@selector(makeCallTO)];
    [tapRecognizerPhone setNumberOfTouchesRequired:1];
    [self.lblContact addGestureRecognizer:tapRecognizerPhone];
    [self.lblContact setUserInteractionEnabled:YES];
    tapRecognizerPhone=nil;
    
    
    
    
}

-(void)success:(id)response
{
    NSLog(@"success at DetailView Contoller");
    
    
    /*
     {
     message = "Your new password has been sent to you email";
     status = 1;
     }
     */
    
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
        NSString *str=[params objectForKey:@"message"];
        
        if([[str uppercaseString] containsString:[@"Successfully get data" uppercaseString]])
        {
            NSDictionary *d=[[params objectForKey:@"data"] objectAtIndex:0];
            dt.name=[d objectForKey:@"name"];
            
            
            dt.range=[d objectForKey:@"priceRangeTo"];
            dt.imgCat=[d objectForKey:@"businessImageLogoUrl"];
            dt.bannerUrl=[d objectForKey:@"businessImageBannerUrl"];
            
            dt.busId=[d objectForKey:@"id"];
            dt.rangeFrom=[d objectForKey:@"priceRangeFrom"];
            dt.rangeTo=[d objectForKey:@"priceRangeTo"];
            dt.currencySymbol=[d objectForKey:@"currencySymbol"];
            dt.isFavorite=[d objectForKey:@"isFavorite"];
            dt.latitude=[d objectForKey:@"latitude"];
            dt.longitude=[d objectForKey:@"longitude"];
            dt.rating=[d objectForKey:@"rating"];
            dt.ratingProvidedByUser=[d objectForKey:@"ratingProvidedByUser"];
            
            
            dt.businessImageBannerUrl=[d objectForKey:@"banner_img_path"];
            dt.businessImageLogoUrl=[d objectForKey:@"logo_img_path"];
            dt.active=[d objectForKey:@"active"];
            dt.address=[d objectForKey:@"address"];
            dt.amenities=[d objectForKey:@"amenities"];
            dt.city=[d objectForKey:@"city"];
            dt.shortDescription=[d objectForKey:@"description"];
            dt.facebook_page=[d objectForKey:@"facebook_page"];
            dt.payment_status=[d objectForKey:@"payment_status"];
            
            
            
            dt.phone=[d objectForKey:@"phone"];
            dt.province=[d objectForKey:@"province"];
            dt.restaurant_id=[d objectForKey:@"restaurant_id"];
            dt.country=[d objectForKey:@"country"];
            dt.serial_no=[d objectForKey:@"serial_no"];
            dt.specialize_in=[d objectForKey:@"specialize_in"];
            dt.suburb=[d objectForKey:@"suburb"];
            
            
            dt.today=[d objectForKey:@"today"];
            dt.trading_hours_from=[d objectForKey:@"trading_hours_from"];
            dt.trading_hours_to=[d objectForKey:@"trading_hours_to"];
            dt.website_link=[d objectForKey:@"website_link"];
            dt.account_number=[d objectForKey:@"account_number"];
            dt.operatingTimeArray=[d objectForKey:@"operatingTime"];
            
            
            [self performSelector:@selector(setDataOnView) withObject:nil afterDelay:0.2];
            
        }
        else if([[str uppercaseString] containsString:[@"removed" uppercaseString]])
        {
            NSLog(@"Business removed from favorite sucessfully.");
            [btn2 setTitle:@"Add To Favorite" forState:UIControlStateNormal];
        }
        else
        {
            NSLog(@"Business added In favorite sucessfully.");
            [btn2 setTitle:@"Remove From Favorite" forState:UIControlStateNormal];
        }
        
    }
    
}


-(void)failure:(id)response
{
    
    NSLog(@"fail at detail");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews
{
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.baseBottomView.frame.origin.y+self.baseBottomView.frame.size.height +50)];
    [self.scrollView setBounces:NO];
    
}



-(void)openMail
{
    if(dt.address!=nil)
    {
        
        [self displayMailComposerSheet:dt.address Subj:@" " theText:@" "];
    }
    
}
-(void)displayMailComposerSheet:(NSString*)torecipient Subj:(NSString*)tosub theText:(NSString*)totext
{
    if([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
        picker.mailComposeDelegate = self;
        [picker setToRecipients:[torecipient componentsSeparatedByString:@"\n"]];
        [picker setSubject:tosub];
        [picker setMessageBody:totext isHTML:NO];
        [self presentViewController:picker animated:YES completion:nil];
        picker=nil;
        
    }
    else
    {
        UIAlertView *alt=[[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Unable To Send Mail! Please Configure At Least One Mail Account" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alt show];
    }
}
- (void)mailComposeController:(MFMailComposeViewController*)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    
    
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Result: Mail sending canceled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Result: Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog( @"Result: Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Result: Mail sending failed");
            break;
        default:
            NSLog(@"Result: Mail not sent");
            break;
    }
    [self dismissModalViewControllerAnimated:YES];
}


-(void)openWeb
{
    if(dt.website_link!=nil)
    {
        NSLog(@"in open web yes");
        NSURL *facebookURL = [NSURL URLWithString:dt.website_link];
        if ([[UIApplication sharedApplication] canOpenURL:facebookURL])
        {
            
            NSRange range = [dt.website_link rangeOfString:@"https://"];
            
            if (range.location == NSNotFound) {
                
                dt.website_link = [NSString stringWithFormat:@"https://%@", dt.website_link];
            }
            else {
            }
            
            CommonWebView *webview = [self.storyboard instantiateViewControllerWithIdentifier:@"CommonWebView"];
            webview.webviewUrl = dt.website_link;
            [self.navigationController pushViewController:webview animated:YES];
            
            NSLog(@"can open given url");
            //[[UIApplication sharedApplication] openURL:facebookURL];
        }
        else
            NSLog(@"in can open web No sorry");
        
        
    }
    else
        NSLog(@"in open web No");
    
}


-(void)makeCallTO
{
    if(dt.address!=nil)
    {
        
        NSLog(@"open dilar to call =%@",dt.phone);
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",dt.phone]]];
    }
    
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

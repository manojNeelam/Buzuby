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
@interface DetailViewController ()<ServerResponseDelegate>
{
    DetailViewData *dt;
    NSMutableArray *ratingArr;
    NSMutableArray *ratingArr2;
    AppDelegate *appdeligate;
}
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"BuZuaby"];
    appdeligate = [[UIApplication sharedApplication] delegate];
    
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
    _lblAvertise.text=[NSString stringWithFormat:@"%@",dt.province]; //about Us
    _lblAminiti.text=[NSString stringWithFormat:@"%@",dt.amenities];
    _lblLocation.text=[NSString stringWithFormat:@"%@",dt.address];  //address
    _lblContact.text=[NSString stringWithFormat:@"%@",dt.phone];  //address
    _lblLink.text=[NSString stringWithFormat:@"%@",dt.website_link];  //address
    
    
    
    //lblLocation
    
    //lblContact
    //lblLink
    //
    
    
    
    
    //  _lblDesc.text=[NSString stringWithFormat:@"Price Range %@-%@ %@",dt.rangeFrom,dt.rangeTo,dt.currencySymbol];
    
    
    [self drawStarOnView];
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
    if(k!=n&&k>0)
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
        bt.tag=i;
        [bt addTarget:self action:@selector(onStarClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}




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
}
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
            
            dt.busId=[d objectForKey:@"businessId"];
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
            dt.country=[d objectForKey:@"country"];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews
{
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.baseBottomView.frame.origin.y+self.baseBottomView.frame.size.height +50)];
    [self.scrollView setBounces:NO];
    
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

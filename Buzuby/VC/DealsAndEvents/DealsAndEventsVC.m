//
//  DealsAndEventsVC.m
//  Buzuby
//
//  Created by Pai, Ankeet on 16/05/16.
//  Copyright © 2016 com.demo. All rights reserved.
//

#import "DealsAndEventsVC.h"
#import "DealsAndEventsCell.h"
#import "UIImageView+JMImageCache.h"
#import "ConnectionsManager.h"

@interface DealsAndEventsVC () <UITableViewDataSource, UITableViewDelegate,ServerResponseDelegate>
{
    int counter,apiCounter;
    NSArray *bannerArr;
    NSArray *dataArr;

    
}
@end

@implementation DealsAndEventsVC
@synthesize bannerImageView;
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setTitle:@"Event & Deals"];
    [_btnsEARCH setHidden:YES];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    if ([[ver objectAtIndex:0] intValue] >= 7) {
        // iOS 7.0 or later
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:68.0f/255.0f green:78.0f/255.0f blue:85.0f/255.0f alpha:1.0f];
        self.navigationController.navigationBar.translucent = NO;
    }else {
        // iOS 6.1 or earlier
        self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:68.0f/255.0f green:78.0f/255.0f blue:85.0f/255.0f alpha:1.0f];;
    }
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    
    
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backButton"] style:UIBarButtonItemStyleDone target:self action:@selector(onClickBackbutton:)]];
    
    [self getBannerList];
    
}

-(void)getBannerList
{
    apiCounter=1;
    NSMutableDictionary* paramDict =
    [NSMutableDictionary dictionaryWithCapacity:1];
    
    NSString *strToken=[[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    [paramDict setObject:strToken forKey:@"token"];
    
    [paramDict setObject:@"getAdBanner" forKey:@"action"];
    
    [[ConnectionsManager sharedManager] getMyFaviroteData:paramDict withdelegate:self];
    
}


-(void)getDealsAndEventDataByPrefernce
{
    apiCounter=2;

    NSDictionary *dct=[[NSUserDefaults standardUserDefaults] objectForKey:@"prefernceData"];
    [[ConnectionsManager sharedManager] getMyFaviroteData:dct withdelegate:self];
    
}

-(void)getDealsAndEventDataByBusinessId
{
    apiCounter=3;
    NSMutableDictionary* paramDict =
    [NSMutableDictionary dictionaryWithCapacity:1];
    
    NSString *strToken=[[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    [paramDict setObject:strToken forKey:@"token"];
    
    [paramDict setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"dealsBusID"] forKey:@"businessId"];
    
    
    NSString *strUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    [paramDict setObject:strUserId forKey:@"userId"];

   
    NSString *str=[[NSUserDefaults standardUserDefaults] objectForKey:@"locationPoint"];
    
    [paramDict setObject:[[str componentsSeparatedByString:@","] objectAtIndex:0] forKey:@"latitude"];
    [paramDict setObject:[[str componentsSeparatedByString:@","] objectAtIndex:1] forKey:@"longitude"];

    
 
    
    [paramDict setObject:@"getDealEventsByBusinessId" forKey:@"action"];
    
    NSLog(@"getDealsAndEventDataByBusinessId Final parameter =%@",paramDict);
    
    [[ConnectionsManager sharedManager] getMyFaviroteData:paramDict withdelegate:self];
    //token, userId, businessId,latitude,longitude

}


//
-(void)success:(id)response
{
    NSLog(@"success at Add favorite");
    
    
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
        if(apiCounter==1)
        {
            bannerArr=[params objectForKey:@"data"];
            if(bannerArr.count>0)
            {
                [self showBanner];
                
                
                bannerTimer=nil;
                bannerTimer= [NSTimer scheduledTimerWithTimeInterval:3.5f
                                                              target:self
                                                            selector:@selector(showBanner)
                                                            userInfo:nil
                                                             repeats:YES];
                
                if([[NSUserDefaults standardUserDefaults] boolForKey:@"fromPreference"])
                {
                    if([[NSUserDefaults standardUserDefaults] boolForKey:@"preferenceSet"])
                    {
                        
                        NSLog(@"make request for get deal and events on the basis of Preference");
                        
                        [self getDealsAndEventDataByPrefernce];

                    }
                    else
                    {
                        UIAlertView *alt=[[UIAlertView alloc] initWithTitle:@"Sorry!" message:@"Go back and Set the value at prefernce Page first" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                        [alt show];
                    }
                    
                }
                else
                {
                    NSLog(@"make request for get deal and events on the basis of busunes id");
                    
                    [self getDealsAndEventDataByBusinessId];
                }
                
                
            }
        }
        else
        {
            if([[params objectForKey:@"total_records"] intValue]==0)
            {
                UIAlertView *alt=[[UIAlertView alloc] initWithTitle:@"Sorry!" message:@"No Record Found" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alt show];
            }
            else
            {
            dataArr=[params objectForKey:@"data"];
                [_tableView reloadData];
            }
        }
        
    }
}
//

NSTimer *bannerTimer;
-(void)showBanner
{
    if(counter<bannerArr.count)
        [bannerImageView setImageWithURL:[NSURL URLWithString:[[bannerArr objectAtIndex:counter] objectForKey:@"businessImageBannerUrl"]] placeholder:[UIImage imageNamed:@"left_part.png"]];
    counter++;
    
    if(counter==bannerArr.count)
        counter=0;
}
-(void)failure:(id)response
{
    NSLog(@"failure at Add favorite");
}


-(void)onClickBackbutton:(id)sender
{
    NSLog(@"onClickBackbutton");

    if([[NSUserDefaults standardUserDefaults] boolForKey:@"toPop"])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifer = @"DealsAndEventsCell";
    DealsAndEventsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    cell.baseLocateMeView.layer.borderColor = cell.lblTitle.textColor.CGColor;
    cell.baseLocateMeView.layer.borderWidth = 1.0f;
    
    cell.baseRangeView.layer.borderColor = cell.lblTitle.textColor.CGColor;
    cell.baseRangeView.layer.borderWidth = 1.0f;
    
    cell.baseLinkView.layer.borderColor = [UIColor whiteColor].CGColor;
    cell.baseLinkView.layer.borderWidth = 1.0f;
    
    cell.baseBodyView.layer.borderColor = [UIColor whiteColor].CGColor;
    cell.baseBodyView.layer.borderWidth = 1.0f;
    
    NSDictionary *dct=[dataArr objectAtIndex:indexPath.row];
    
    cell.lblTitle.text=[dct objectForKey:@"businessName"];
    cell.lblDesc.text=[dct objectForKey:@"dealHeading"];
    cell.lblPrice.text=[NSString stringWithFormat:@"%@-%@ %@",[dct objectForKey:@"priceRangeFrom"],[dct objectForKey:@"priceRangeTo"],[dct objectForKey:@"currencySymbol"]];

    
    [cell.logoImg setImageWithURL:[NSURL URLWithString:[dct objectForKey:@"businessImageLogoUrl"]] placeholder:[UIImage imageNamed:@"left_part.png"]];
    
     [cell.imgBody setImageWithURL:[NSURL URLWithString:[dct objectForKey:@"dealImageurl"]] placeholder:[UIImage imageNamed:@"left_part.png"]];

    cell.lblLink.text=[dct objectForKey:@"businessWebsiteUrl"];

    cell.btnLocateus.tag=2000+indexPath.row;
    [cell.btnLocateus addTarget:self action:@selector(openMap:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArr.count;
}


- (IBAction)onClickSearchButton:(id)sender
{
    

}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 327;
}

-(void)openMap:(UIButton*)bt
{
    NSDictionary *dct=[dataArr objectAtIndex:bt.tag-2000];

     NSString *nativeMapScheme = @"maps.apple.com";
    NSString* url = [NSString stringWithFormat:@"http://%@/maps?q=%@,%@", nativeMapScheme,[dct objectForKey:@"latitude"], [dct objectForKey:@"longitude"]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];

}

@end

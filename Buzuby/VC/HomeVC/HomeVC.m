//
//  HomeVC.m
//  Buzuby
//
//  Created by Pai, Ankeet on 12/05/16.
//  Copyright © 2016 com.demo. All rights reserved.
//

#import "HomeVC.h"
#import "HomeData.h"
#import "HomeTableViewCell.h"
#import "ConnectionsManager.h"
#import "UIImageView+JMImageCache.h"
#import "DetailViewController.h"
#import "AppDelegate.h"

@interface HomeVC ()<UITableViewDataSource, UITableViewDelegate,ServerResponseDelegate>
{
    NSArray *list;
}
@property (nonatomic) IBOutlet UIBarButtonItem* revealButtonItem;


@end

@implementation HomeVC

- (void)viewDidLoad {
    
    [self.navigationItem setTitle:@"Buzuby"];
    
    [super viewDidLoad];
    
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

    
    
    [self customSetup];
    // Do any additional setup after loading the view.
  // [self performSelector:@selector(makeRequestForFavariote) withObject:nil afterDelay:0.2];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"fromPreference"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"toPop"];

    [self performSelector:@selector(makeRequestForFavariote) withObject:nil afterDelay:0.2];
}
-(void)makeRequestForFavariote
{
    NSMutableDictionary* paramDict =
    [NSMutableDictionary dictionaryWithCapacity:1];
    
    NSString *strToken=[[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    [paramDict setObject:strToken forKey:@"token"];
    
    NSString *strUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    [paramDict setObject:strUserId forKey:@"userId"];
    
    [paramDict setObject:@"getAllFavoriteBusiness" forKey:@"action"];
    
    [[ConnectionsManager sharedManager] getMyFaviroteData:paramDict withdelegate:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)customSetup
{
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.revealButtonItem setTarget: self.revealViewController];
        [self.revealButtonItem setAction: @selector( revealToggle: )];
        [self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
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

- (IBAction)onClickSearchButton:(id)sender
{
   // UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:PreferenceSBID];
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:SearchSBID];

    [self.navigationController pushViewController:vc animated:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HomeData *dt=[list objectAtIndex:indexPath.row];
    static NSString *cellIdentifier = @"HomeTableViewCell";
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    cell.lblTitle.text=dt.name;
    
    [cell.imgItem setImageWithURL:[NSURL URLWithString:dt.imgCat] placeholder:[UIImage imageNamed:@"left_part.png"]];
    
    cell.lblDesc.text=[NSString stringWithFormat:@"Price Range %@-%@ %@",dt.rangeFrom,dt.rangeTo,dt.currencySymbol];
    
    cell.btnDelete.tag=indexPath.row+2000;
    [cell.btnDelete addTarget:self action:@selector(favoriteClicked:) forControlEvents:UIControlEventTouchUpInside];

    cell.btnLocation.tag=3000+indexPath.row;
    [cell.btnLocation addTarget:self action:@selector(openMap:) forControlEvents:UIControlEventTouchUpInside];

    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];

    delegate.selectedData=[list objectAtIndex:indexPath.row];
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController_SB_ID"];
    [self.navigationController pushViewController:vc animated:YES];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return 4;
    
    if(list && list.count)
    {
        [self.tableView setHidden:NO];
        [self.baseEmptyView setHidden:YES];
        return list.count;
    }
    else
    {
        [self.baseEmptyView setHidden:NO];
        [self.tableView setHidden:YES];
        return 0;
    }
}


-(void)favoriteClicked:(UIButton*)bt
{
  //  NSDictionary *dct=[list objectAtIndex:bt.tag-2000];
    HomeData *dt=[list objectAtIndex:bt.tag-2000];

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


-(void)success:(id)response
{
    NSLog(@"success at Home");
    
    
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

        if([[str uppercaseString] containsString:[@"removed" uppercaseString]])
        {
            NSLog(@"Business removed from favorite sucessfully.");
            list=nil;
            
            [self performSelector:@selector(makeRequestForFavariote) withObject:nil afterDelay:0.2];

        }
        else
        {

         [_tableView reloadData];
        NSArray *arr=[params objectForKey:@"data"];
        NSMutableArray *listArr=[[NSMutableArray alloc] init];
        for(NSDictionary *d in arr)
        {
            HomeData *dt=[[HomeData alloc] init];
            dt.name=[d objectForKey:@"businessName"];
            dt.range=[d objectForKey:@"priceRangeTo"];
            dt.imgCat=[d objectForKey:@"businessImageLogoUrl"];
            dt.busId=[d objectForKey:@"businessId"];
            dt.rangeFrom=[d objectForKey:@"priceRangeFrom"];
            dt.rangeTo=[d objectForKey:@"priceRangeTo"];
            dt.currencySymbol=[d objectForKey:@"currencySymbol"];
            dt.isFavorite=[d objectForKey:@"isFavorite"];
            dt.latitude=[d objectForKey:@"latitude"];
            
            dt.longitude=[d objectForKey:@"longitude"];
            dt.rating=[d objectForKey:@"rating"];
            dt.ratingProvidedByUser=[d objectForKey:@"ratingProvidedByUser"];
            dt.bannerUrl=[d objectForKey:@"businessImageBannerUrl"];
           
            [listArr addObject:dt];
        }
        if(listArr.count>0)
        {
            self.view.backgroundColor=[UIColor colorWithRed:68.0/255 green:78.0/255 blue:84.0/255 alpha:1];
            _tableView.backgroundColor=[UIColor clearColor];

            list=listArr;
            listArr=nil;
            [_tableView reloadData];
        }
    }
    }
}

-(void)openMap:(UIButton*)bt
{
   HomeData *dt=[list objectAtIndex:bt.tag-3000];
    NSString *nativeMapScheme = @"maps.apple.com";
    NSString* url = [NSString stringWithFormat:@"http://%@/maps?q=%@,%@", nativeMapScheme,dt.latitude,dt.longitude];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    
}


@end

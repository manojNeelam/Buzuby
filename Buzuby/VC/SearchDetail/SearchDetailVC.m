

//
//  SearchDetailVC.m
//  Buzuby
//
//  Created by Pai, Ankeet on 18/05/16.
//  Copyright © 2016 com.demo. All rights reserved.
//

#import "SearchDetailVC.h"
#import "SearchDetailCell.h"
#import "AppDelegate.h"
#import "UIImageView+JMImageCache.h"
#import "ConnectionsManager.h"

@interface SearchDetailVC () <UITableViewDelegate, UITableViewDataSource,ServerResponseDelegate>
{
    NSArray *searchListArray;
}
@end
@implementation SearchDetailVC
-(void)viewDidLoad
{
    [super viewDidLoad];

    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    
    searchListArray=delegate.searchList;
    
    NSLog(@"SearchDetailVC viewDidLoad");

}
- (IBAction)onClickSearchbutton:(id)sender {
    NSLog(@"SearchDetailVC onClickSearchbutton");
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"SearchDetailCell";
    SearchDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    NSDictionary *dct=[searchListArray objectAtIndex:indexPath.row];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openDetailVC:)];
    [cell.baseTopView addGestureRecognizer:tapGesture];
    
    cell.baseTopView.tag=indexPath.row+1000;
    cell.baseAddRemoveView.layer.borderColor = [UIColor whiteColor].CGColor;
    cell.baseAddRemoveView.layer.borderWidth = 1.0f;
    
    cell.baseDealsview.layer.borderColor = [UIColor whiteColor].CGColor;
    cell.baseDealsview.layer.borderWidth = 1.0f;
    [cell.logoImg setImageWithURL:[NSURL URLWithString:[dct objectForKey:@"businessImageLogoUrl"]] placeholder:[UIImage imageNamed:@"left_part.png"]];
    cell.lblTitle.text=[dct objectForKey:@"businessName"];
    if([dct objectForKey:@"shortDescription"]!=nil&&[[dct objectForKey:@"shortDescription"] length]>0)
        cell.lblDesc.text=[dct objectForKey:@"shortDescription"];
    else
        cell.lblDesc.text=@"Description not found";
    
    
    [cell.btnPrice setTitle:[NSString stringWithFormat:@"Price Range %@-%@ %@",[dct objectForKey:@"priceRangeFrom"],[dct objectForKey:@"priceRangeTo"],[dct objectForKey:@"currencySymbol"]] forState:UIControlStateNormal];
    
    if([[dct objectForKey:@"isFavorite"] isEqualToString:@"no"])
    {
        [cell.btnAddRemove setTitle:@"Add To Favorite" forState:UIControlStateNormal];
    }
    else
    {
        [cell.btnAddRemove setTitle:@"Remove From Favorite" forState:UIControlStateNormal];
        
    }
    cell.btnAddRemove.tag=indexPath.row+2000;
    [cell.btnAddRemove addTarget:self action:@selector(favoriteClicked:) forControlEvents:UIControlEventTouchUpInside];

    cell.btnDeals.tag=indexPath.row+3000;
    [cell.btnDeals addTarget:self action:@selector(eventClicked:) forControlEvents:UIControlEventTouchUpInside];

    return cell;
}

-(void)eventClicked:(UIButton*)bt
{
    NSDictionary *dct=[searchListArray objectAtIndex:bt.tag-3000];
    NSLog(@"favoriteClicked businessName=%@",[dct objectForKey:@"businessName"]);
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"fromPreference"];
    [[NSUserDefaults standardUserDefaults] setObject:[dct objectForKey:@"businessId"] forKey:@"dealsBusID"];


    UIViewController *dealsvc = [self.storyboard instantiateViewControllerWithIdentifier:@"DealsAndEventsVC_SB_ID"];
    [self.navigationController pushViewController:dealsvc animated:YES];
    
}

UIButton *btn;

-(void)favoriteClicked:(UIButton*)bt
{
    btn=bt;
    NSDictionary *dct=[searchListArray objectAtIndex:bt.tag-2000];
    
    NSLog(@"favoriteClicked businessName=%@",[dct objectForKey:@"businessName"]);
    
    NSMutableDictionary* paramDict =
    [NSMutableDictionary dictionaryWithCapacity:1];
    
    NSString *strToken=[[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    [paramDict setObject:strToken forKey:@"token"];
    
    NSString *strUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    [paramDict setObject:strUserId forKey:@"userId"];
    
    [paramDict setObject:[dct objectForKey:@"businessId"] forKey:@"businessId"];
    
    
    [paramDict setObject:@"addBusinessToFavorite" forKey:@"action"];
    
    
    [[ConnectionsManager sharedManager] getMyFaviroteData:paramDict withdelegate:self];
    
}


//addBusinessToFavorite token, userId, businessId

/*-(void)drawStarOnView
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
 [bt addTarget:self action:@selector(onStarClick:) forControlEvents:UIControlEventTouchUpInside];
 }
 }
 
 -(void)onStarClick:(UIButton*)bt
 {
 int n=(int)bt.tag;
 if([[bt backgroundImageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"star_normal.png"]])
 {
 [ bt setBackgroundImage:[UIImage imageNamed:@"star_selected.png"] forState:UIControlStateNormal];
 [ratingArr replaceObjectAtIndex:n withObject:@"1"];
 
 }
 else if([[bt backgroundImageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"star_selected.png"]])
 {
 [ bt setBackgroundImage:[UIImage imageNamed:@"star_normal.png"] forState:UIControlStateNormal];
 [ratingArr replaceObjectAtIndex:n withObject:@"0"];
 
 
 }
 }*/



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

-(void)openDetailVC:(UIGestureRecognizer *)aGest
{
    UIView *v=[aGest view];
    
    NSLog(@"openDetailVC selected view at position=%ld",(long)v.tag);
    NSDictionary *d=[searchListArray objectAtIndex:v.tag-1000];
    
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
    
    
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    
    delegate.selectedData=dt;
    
    
    
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController_SB_ID"];
    [self.navigationController pushViewController:vc animated:YES];
}

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
        NSString *str=[params objectForKey:@"message"];
        
        if([[str uppercaseString] containsString:[@"removed" uppercaseString]])
        {
            NSLog(@"Business removed from favorite sucessfully.");
            [btn setTitle:@"Add To Favorite" forState:UIControlStateNormal];
            
        }
        else
        {
            NSLog(@"Business added In favorite sucessfully.");
            [btn setTitle:@"Remove From Favorite" forState:UIControlStateNormal];
        }
        
        
    }
}


-(void)failure:(id)response
{
    NSLog(@"failure at Add favorite");
}


/*
 @property (weak, nonatomic) IBOutlet UILabel *lblTitle;
 @property (weak, nonatomic) IBOutlet UILabel *lblDesc;
 @property (weak, nonatomic) IBOutlet UIImageView *imgItem;
 @property (weak, nonatomic) IBOutlet UIButton *btnDelete;
 @property (weak, nonatomic) IBOutlet UIButton *btnLocation;
 
 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return searchListArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 368;
}

@end

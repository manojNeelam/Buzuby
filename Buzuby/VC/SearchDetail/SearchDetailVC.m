

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

@interface SearchDetailVC () <UITableViewDelegate, UITableViewDataSource>
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
}
- (IBAction)onClickSearchbutton:(id)sender {
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

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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

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
    
    return cell;
}
/*
 @property (weak, nonatomic) IBOutlet UILabel *lblTitle;
 @property (weak, nonatomic) IBOutlet UILabel *lblDesc;
 @property (weak, nonatomic) IBOutlet UIImageView *imgItem;
 @property (weak, nonatomic) IBOutlet UIButton *btnDelete;
 @property (weak, nonatomic) IBOutlet UIButton *btnLocation;

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 92.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
    
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *detailvc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController_SB_ID"];
    [self.navigationController pushViewController:detailvc animated:YES];
    
}

@end

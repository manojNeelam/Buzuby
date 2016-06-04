

//
//  SettingsVC.m
//  Buzuby
//
//  Created by Pai, Ankeet on 12/05/16.
//  Copyright © 2016 com.demo. All rights reserved.
//

#import "SettingsVC.h"
#import "SettingTitleCell.h"
#import "SettingDefaultCell.h"
#import "AppDelegate.h"

#import "PreferenceViewController.h"
#import "SearchViewController.h"
#import "DealsAndEventsVC.h"

@interface SettingsVC () <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *titleAray;
}
@end

@implementation SettingsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    titleAray = [[NSArray alloc] initWithObjects:@"My Favourites",@"preference",@"Search Bussiness",@"Deals & Events",@"Share",@"Logout", nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        if(indexPath.row == 0)
        {
            static NSString *cellIdentifier = @"SettingTitleCell";
            SettingTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            return cell;
        }
    }
    
    static NSString *defaultCllIdentifier = @"SettingDefaultCell";
    SettingDefaultCell *cellDefault = [tableView dequeueReusableCellWithIdentifier:defaultCllIdentifier];
    
    if(indexPath.section == 0)
    {
        NSString *stringTitle = [titleAray objectAtIndex:indexPath.row-1];
        [cellDefault.lblName setText:stringTitle];
    }
    
    else if(indexPath.section == 1)
    {
        [cellDefault.lblName setText:[titleAray objectAtIndex:indexPath.row+4]];
    }
    
    return cellDefault;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 5;
    }
    
    return 2;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return nil;
    }
    UIView *headerView = [[UIView alloc] init];
    headerView.frame = CGRectMake(0, 0, tableView.frame.size.width, 44);
    
    [headerView setBackgroundColor:[UIColor whiteColor]];
    
    UILabel *sepLabel = [[UILabel alloc] init];
    [sepLabel setFrame:CGRectMake(0, 0, tableView.frame.size.width, 1)];
    [sepLabel setBackgroundColor:[UIColor grayColor]];
    [sepLabel setText:@""];
    [headerView addSubview:sepLabel];
    
    UILabel *lblTitle = [[UILabel alloc] init];
    [lblTitle setFrame:CGRectMake(10, 44/2-21/2, tableView.frame.size.width-20, 21)];
    [lblTitle setText:@"Communicate"];
    [lblTitle setTextColor:[UIColor lightGrayColor]];
    [headerView addSubview:lblTitle];
    
    
    
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 0;
    }
    
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        if(indexPath.row == 0)
        {
            return 175;
        }
    }
    
    return 44;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(indexPath.section == 1)
    {
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"userName"];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"userId"];
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"token"];
        
        
        
        AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
        [delegate showLoginVC];
    }
    else if (indexPath.section == 0)
    {
        switch (indexPath.row) {
            case 1:
            {
                [self.revealViewController revealToggleAnimated:YES];
            }
                break;
            case 2:
            {
                NSLog(@"PreferenceViewController selected");
               /* PreferenceViewController *peferencevc = [self.storyboard instantiateViewControllerWithIdentifier:PreferenceSBID];
                
                
                peferencevc.isFromSettings = YES;
                */
                UIViewController *peferencevc = [self.storyboard instantiateViewControllerWithIdentifier:@"Preference2"];

                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:peferencevc];
                [self presentViewController:nav animated:YES completion:^{
                    
                }];
            }
                break;
            case 3:
            {
                SearchViewController *peferencevc = [self.storyboard instantiateViewControllerWithIdentifier:SearchSBID];
                peferencevc.isFromSettings = YES;
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:peferencevc];
                [self presentViewController:nav animated:YES completion:^{
                    
                }];
            }
                break;
            case 4:
            {
                
                DealsAndEventsVC *dealsvc = [self.storyboard instantiateViewControllerWithIdentifier:@"DealsAndEventsVC_SB_ID"];
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:dealsvc];
                [self presentViewController:nav animated:YES completion:^{
                    
                }];
                //[self.revealViewController revealToggleAnimated:YES];            }
                break;
            }
            default:
                break;
        }
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

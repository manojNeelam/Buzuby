//
//  HomeVC.m
//  Buzuby
//
//  Created by Pai, Ankeet on 12/05/16.
//  Copyright © 2016 com.demo. All rights reserved.
//

#import "HomeVC.h"
#import "HomeTableViewCell.h"

@interface HomeVC ()<UITableViewDataSource, UITableViewDelegate>
{
    NSArray *list;
}
@property (nonatomic) IBOutlet UIBarButtonItem* revealButtonItem;


@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customSetup];
    // Do any additional setup after loading the view.
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
    UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:PreferenceSBID];
    [self.navigationController pushViewController:vc animated:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"HomeTableViewCell";
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
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

@end

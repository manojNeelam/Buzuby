//
//  DealsAndEventsVC.m
//  Buzuby
//
//  Created by Pai, Ankeet on 16/05/16.
//  Copyright © 2016 com.demo. All rights reserved.
//

#import "DealsAndEventsVC.h"
#import "DealsAndEventsCell.h"

@interface DealsAndEventsVC () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation DealsAndEventsVC

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setTitle:@"Event & Deals"];
    
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
}

-(void)onClickBackbutton:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifer = @"DealsAndEventsCell";
    DealsAndEventsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (IBAction)onClickSearchButton:(id)sender {
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

@end

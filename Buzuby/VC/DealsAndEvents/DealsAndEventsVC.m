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
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifer = @"";
    DealsAndEventsCell *cell = [tableView dequeueReusableCellWithIdentifier:@""];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (IBAction)onClickSearchButton:(id)sender {
}
@end



//
//  SearchDetailVC.m
//  Buzuby
//
//  Created by Pai, Ankeet on 18/05/16.
//  Copyright © 2016 com.demo. All rights reserved.
//

#import "SearchDetailVC.h"
#import "SearchDetailCell.h"

@interface SearchDetailVC () <UITableViewDelegate, UITableViewDataSource>

@end
@implementation SearchDetailVC

- (IBAction)onClickSearchbutton:(id)sender {
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"SearchDetailCell";
    SearchDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openDetailVC:)];
    [cell.baseTopView addGestureRecognizer:tapGesture];
    
    
    cell.baseAddRemoveView.layer.borderColor = [UIColor whiteColor].CGColor;
    cell.baseAddRemoveView.layer.borderWidth = 1.0f;
    
    cell.baseDealsview.layer.borderColor = [UIColor whiteColor].CGColor;
    cell.baseDealsview.layer.borderWidth = 1.0f;
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)openDetailVC:(UIGestureRecognizer *)aGest
{
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
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 368;
}

@end

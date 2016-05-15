//
//  HomeVC.h
//  Buzuby
//
//  Created by Pai, Ankeet on 12/05/16.
//  Copyright © 2016 com.demo. All rights reserved.
//

#import "BaseViewController.h"

@interface HomeVC : BaseViewController
@property (weak, nonatomic) IBOutlet UIView *baseEmptyView;
@property (weak, nonatomic) IBOutlet UILabel *lblText;
- (IBAction)onClickSearchButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnSearch;
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@end

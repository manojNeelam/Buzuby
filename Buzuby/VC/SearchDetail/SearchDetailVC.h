//
//  SearchDetailVC.h
//  Buzuby
//
//  Created by Pai, Ankeet on 18/05/16.
//  Copyright © 2016 com.demo. All rights reserved.
//

#import "BaseViewController.h"

@interface SearchDetailVC : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *btnSearch;
- (IBAction)onClickSearchbutton:(id)sender;

@end

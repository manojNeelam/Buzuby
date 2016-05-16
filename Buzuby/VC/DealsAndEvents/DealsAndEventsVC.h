//
//  DealsAndEventsVC.h
//  Buzuby
//
//  Created by Pai, Ankeet on 16/05/16.
//  Copyright © 2016 com.demo. All rights reserved.
//

#import "BaseViewController.h"

@interface DealsAndEventsVC : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *btnsEARCH;
- (IBAction)onClickSearchButton:(id)sender;

@end

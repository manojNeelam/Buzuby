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
@property (weak, nonatomic) IBOutlet UIImageView *bannerImageView;

- (IBAction)onClickSearchButton:(id)sender;

@end

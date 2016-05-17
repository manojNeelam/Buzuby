//
//  SearchDetailCell.h
//  Buzuby
//
//  Created by Pai, Ankeet on 18/05/16.
//  Copyright © 2016 com.demo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *baseView;
@property (weak, nonatomic) IBOutlet UIImageView *logoImg;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblDesc;
@property (weak, nonatomic) IBOutlet UIButton *btnPrice;
@property (weak, nonatomic) IBOutlet UIView *baseAddRemoveView;
@property (weak, nonatomic) IBOutlet UIButton *btnAddRemove;
@property (weak, nonatomic) IBOutlet UIView *baseDealsview;
@property (weak, nonatomic) IBOutlet UIButton *btnDeals;
@property (weak, nonatomic) IBOutlet UILabel *lblEveryDay;
@property (weak, nonatomic) IBOutlet UILabel *lblDay;
@property (weak, nonatomic) IBOutlet UILabel *lblRating;
@property (weak, nonatomic) IBOutlet UIView *baseRatingView;

@property (weak, nonatomic) IBOutlet UIView *baseTopView;
@end

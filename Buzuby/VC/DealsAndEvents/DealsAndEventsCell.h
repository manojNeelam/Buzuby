//
//  DealsAndEventsCell.h
//  Buzuby
//
//  Created by Pai, Ankeet on 16/05/16.
//  Copyright © 2016 com.demo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DealsAndEventsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *orangeBGView;
@property (weak, nonatomic) IBOutlet UIView *baseTopView;
@property (weak, nonatomic) IBOutlet UIImageView *logoImg;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblSep;

@property (weak, nonatomic) IBOutlet UIView *baseBodyView;
@property (weak, nonatomic) IBOutlet UIImageView *imgBody;
@property (weak, nonatomic) IBOutlet UIView *baseRangeLocView;
@property (weak, nonatomic) IBOutlet UILabel *lblDesc;
@property (weak, nonatomic) IBOutlet UIView *baseRangeView;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UIView *baseLocateMeView;
@property (weak, nonatomic) IBOutlet UILabel *lblLocateus;
@property (weak, nonatomic) IBOutlet UIButton *btnLocateus;
@property (weak, nonatomic) IBOutlet UIView *baseLinkView;
@property (weak, nonatomic) IBOutlet UILabel *lblLink;
@end

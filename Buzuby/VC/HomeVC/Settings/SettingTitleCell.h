//
//  SettingTitleCell.h
//  Buzuby
//
//  Created by Pai, Ankeet on 12/05/16.
//  Copyright © 2016 com.demo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingTitleCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *baseView;
@property (weak, nonatomic) IBOutlet UIImageView *bgImg;
@property (weak, nonatomic) IBOutlet UIImageView *logoImg;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblEmail;
@end

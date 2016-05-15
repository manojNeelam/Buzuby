//
//  HomeTableViewCell.h
//  Buzuby
//
//  Created by Pai, Ankeet on 13/05/16.
//  Copyright © 2016 com.demo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblDesc;
@property (weak, nonatomic) IBOutlet UIImageView *imgItem;
@property (weak, nonatomic) IBOutlet UIButton *btnDelete;
@property (weak, nonatomic) IBOutlet UIButton *btnLocation;

@end

//
//  DetailVCViewController.h
//  Buzuby
//
//  Created by Pai, Ankeet on 15/05/16.
//  Copyright © 2016 com.demo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface DetailViewController : UIViewController<MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *baseView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *baseImgTitleHolder;
@property (weak, nonatomic) IBOutlet UIImageView *logoImg;
@property (weak, nonatomic) IBOutlet UILabel *lblSep;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIView *baseDescView;
@property (weak, nonatomic) IBOutlet UILabel *lblDescription;
@property (weak, nonatomic) IBOutlet UIView *baseSpecialityView;
@property (weak, nonatomic) IBOutlet UIView *holderSpecialityView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *aboutUsHeight_Cons;



@property (weak, nonatomic) IBOutlet UILabel *lblAdvertise;
@property (weak, nonatomic) IBOutlet UIView *baseRatingView;
@property (weak, nonatomic) IBOutlet UILabel *lblSpeciality;


@property (weak, nonatomic) IBOutlet UIView *baseAboutUSView;
@property (weak, nonatomic) IBOutlet UIView *aboutusHolderView;
@property (weak, nonatomic) IBOutlet UILabel *lblAvertise;


@property (weak, nonatomic) IBOutlet UIView *baseAminitiView;
@property (weak, nonatomic) IBOutlet UIView *holderAminitiView;
@property (weak, nonatomic) IBOutlet UILabel *lblAminiti;
@property (weak, nonatomic) IBOutlet UILabel *lblAminitiTitle;


@property (weak, nonatomic) IBOutlet UIView *baseStoreTimingsView;
@property (weak, nonatomic) IBOutlet UIView *holderStoreTimingsview;
@property (weak, nonatomic) IBOutlet UILabel *lblStoreTimings;


@property (weak, nonatomic) IBOutlet UIView *baseDaysView;


@property (weak, nonatomic) IBOutlet UIView *baseMondayView;
@property (weak, nonatomic) IBOutlet UILabel *lblMonTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblMonStartTime;
@property (weak, nonatomic) IBOutlet UILabel *lblMonEndTime;


@property (weak, nonatomic) IBOutlet UIView *baseTuesdayView;
@property (weak, nonatomic) IBOutlet UILabel *lblTueTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblTueStartTime;
@property (weak, nonatomic) IBOutlet UILabel *lblTueEndTime;

@property (weak, nonatomic) IBOutlet UIView *baseWednesdayView;
@property (weak, nonatomic) IBOutlet UILabel *lblWedTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblWedStartTime;
@property (weak, nonatomic) IBOutlet UILabel *lblWedEndTime;


@property (weak, nonatomic) IBOutlet UIView *baseThursdayView;
@property (weak, nonatomic) IBOutlet UILabel *lblThurTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblThurStartTime;
@property (weak, nonatomic) IBOutlet UILabel *lblThurEndTime;


@property (weak, nonatomic) IBOutlet UIView *baseFridayView;
@property (weak, nonatomic) IBOutlet UILabel *lblFriTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblFriStartTime;
@property (weak, nonatomic) IBOutlet UILabel *lblFriEndTime;


@property (weak, nonatomic) IBOutlet UIView *baseSaturdayView;
@property (weak, nonatomic) IBOutlet UILabel *lblSatTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblSatStartTime;
@property (weak, nonatomic) IBOutlet UILabel *lblSatEndTime;


@property (weak, nonatomic) IBOutlet UIView *baseSundayView;
@property (weak, nonatomic) IBOutlet UILabel *lblSunTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblSunStartTime;
@property (weak, nonatomic) IBOutlet UILabel *lblSunEndTime;

@property (weak, nonatomic) IBOutlet UIView *baseBottomView;

@property (weak, nonatomic) IBOutlet UIView *baseRemovefromFavouriteView;
@property (weak, nonatomic) IBOutlet UIButton *btnRemoveFromFav;

- (IBAction)onClickRemovefromFav:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *baseLociew;
@property (weak, nonatomic) IBOutlet UIImageView *imgLoc;
@property (weak, nonatomic) IBOutlet UILabel *lblLocation;
@property (weak, nonatomic) IBOutlet UILabel *lblLink;
@property (weak, nonatomic) IBOutlet UILabel *lblContact;

@property (weak, nonatomic) IBOutlet UIView *baseContactView;
@property (weak, nonatomic) IBOutlet UIImageView *imgContact;
@property (weak, nonatomic) IBOutlet UIView *baseLinkView;
@property (weak, nonatomic) IBOutlet UIImageView *imgLink;
@property (weak, nonatomic) IBOutlet UIImageView *bannerImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consBannerImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consBannerBaseHeight;
@property (weak, nonatomic) IBOutlet UIView *baseaminitiesValueView;

@end

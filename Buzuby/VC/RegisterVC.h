//
//  RegisterVC.h
//  Buzuby
//
//  Created by Pai, Ankeet on 11/05/16.
//  Copyright © 2016 com.demo. All rights reserved.
//

#import "BaseViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "NIDropDown.h"


@interface RegisterVC : BaseViewController<CLLocationManagerDelegate>
{
    NIDropDown *dropDown;
    CLLocationManager *locationManager;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) IBOutlet UIView *baseSuburbView;

@end

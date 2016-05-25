//
//  DealsAndEventsVC.m
//  Buzuby
//
//  Created by Pai, Ankeet on 16/05/16.
//  Copyright © 2016 com.demo. All rights reserved.
//

#import "DealsAndEventsVC.h"
#import "DealsAndEventsCell.h"
#import "UIImageView+JMImageCache.h"
#import "ConnectionsManager.h"

@interface DealsAndEventsVC () <UITableViewDataSource, UITableViewDelegate,ServerResponseDelegate>
{
    int counter,apiCounter;
    NSArray *bannerArr;
}
@end

@implementation DealsAndEventsVC
@synthesize bannerImageView;
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setTitle:@"Event & Deals"];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    if ([[ver objectAtIndex:0] intValue] >= 7) {
        // iOS 7.0 or later
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:68.0f/255.0f green:78.0f/255.0f blue:85.0f/255.0f alpha:1.0f];
        self.navigationController.navigationBar.translucent = NO;
    }else {
        // iOS 6.1 or earlier
        self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:68.0f/255.0f green:78.0f/255.0f blue:85.0f/255.0f alpha:1.0f];;
    }
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    

    
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backButton"] style:UIBarButtonItemStyleDone target:self action:@selector(onClickBackbutton:)]];
    
    [self getBannerList];

}

-(void)getBannerList
{
    apiCounter=1;
    NSMutableDictionary* paramDict =
    [NSMutableDictionary dictionaryWithCapacity:1];
    
    NSString *strToken=[[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    [paramDict setObject:strToken forKey:@"token"];
    
    [paramDict setObject:@"getAdBanner" forKey:@"action"];
    
    [[ConnectionsManager sharedManager] getMyFaviroteData:paramDict withdelegate:self];
    
}


-(void)getDealsAndEventData
{
    apiCounter=2;
    NSMutableDictionary* paramDict =
    [NSMutableDictionary dictionaryWithCapacity:1];
    
    NSString *strToken=[[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    [paramDict setObject:strToken forKey:@"token"];
    
    
    [paramDict setObject:@"getAdBanner" forKey:@"action"];
    
    [[ConnectionsManager sharedManager] getMyFaviroteData:paramDict withdelegate:self];
    
}

//
-(void)success:(id)response
{
    NSLog(@"success at Add favorite");
    
    
    NSDictionary *params;
    
    if([response isKindOfClass:[NSString class]])
    {
        NSData *data = [response dataUsingEncoding:NSUTF8StringEncoding];
        params = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    }
    else if ([response isKindOfClass:[NSDictionary class]])
    {
        params = response;
    }
    
    
    id statusStr_ = [params objectForKey:@"status"];
    NSString *statusStr;
    
    if([statusStr_ isKindOfClass:[NSNumber class]])
    {
        statusStr = [statusStr_ stringValue];
    }
    else
        statusStr = statusStr_;
    
    
    NSLog(@"params=%@",params);
    if([statusStr isEqualToString:@"200"])
    {
        if(apiCounter==1)
        {
            bannerArr=[params objectForKey:@"data"];
            if(bannerArr.count>0)
            {
                [self showBanner];
               
                
                bannerTimer=nil;
                bannerTimer= [NSTimer scheduledTimerWithTimeInterval:2.5f
                                                         target:self
                                                       selector:@selector(showBanner)
                                                       userInfo:nil
                                                        repeats:YES];

                
            }
        }
        
    }
}
//

NSTimer *bannerTimer;
-(void)showBanner
{
    if(counter<bannerArr.count)
     [bannerImageView setImageWithURL:[NSURL URLWithString:[[bannerArr objectAtIndex:counter] objectForKey:@"businessImageBannerUrl"]] placeholder:[UIImage imageNamed:@"left_part.png"]];
    counter++;
    
     if(counter==bannerArr.count)
         counter=0;
}
-(void)failure:(id)response
{
    NSLog(@"failure at Add favorite");
}


-(void)onClickBackbutton:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifer = @"DealsAndEventsCell";
    DealsAndEventsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    cell.baseLocateMeView.layer.borderColor = cell.lblTitle.textColor.CGColor;
    cell.baseLocateMeView.layer.borderWidth = 1.0f;
    
    cell.baseRangeView.layer.borderColor = cell.lblTitle.textColor.CGColor;
    cell.baseRangeView.layer.borderWidth = 1.0f;
    
    cell.baseLinkView.layer.borderColor = [UIColor whiteColor].CGColor;
    cell.baseLinkView.layer.borderWidth = 1.0f;
    
    cell.baseBodyView.layer.borderColor = [UIColor whiteColor].CGColor;
    cell.baseBodyView.layer.borderWidth = 1.0f;
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (IBAction)onClickSearchButton:(id)sender {
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 327;
}

@end

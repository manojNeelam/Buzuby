//
//  SearchViewController.m
//  Buzuby
//
//  Created by Pai, Ankeet on 11/05/16.
//  Copyright © 2016 com.demo. All rights reserved.
//

#import "SearchViewController.h"
#import "ConnectionsManager.h"
#import "NIDropDown.h"
#import "CategoryData.h"
#import "SubCategoryData.h"
#import "SubSubCategoryData.h"
#import "AppDelegate.h"
#import "NSString+CommonForApp.h"

@interface SearchViewController ()<ServerResponseDelegate, NIDropDownDelegate>
{
    NSArray *catList,*subCatList,*subSubCatList;
    CategoryData *selectedCategory;SubCategoryData  *selectedSubCategory; SubSubCategoryData *selectedSubSubCategory;
    int resultForApi;
    NIDropDown *dropDown;
}

@property (weak, nonatomic) IBOutlet DefaultTextField *txtFldSearch;
@property (weak, nonatomic) IBOutlet DefaultTextField *txtFldCatOption;
@property (weak, nonatomic) IBOutlet DefaultTextField *txtFldSubCatOption;
@property (weak, nonatomic) IBOutlet DefaultTextField *txtFldSubCatOption2;

@property (weak, nonatomic) IBOutlet UIButton *btnPreference;
@property (weak, nonatomic) IBOutlet UIButton *btnSearch;

- (IBAction)onClickPreferenceButton:(id)sender;
- (IBAction)onClickSearchbutton:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnNext;
- (IBAction)onClickNextButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnCat;
- (IBAction)onClickCatButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnSubcat;
- (IBAction)onClicksubCatButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnSubSubCat;
- (IBAction)onClickSubSubCatButton:(id)sender;

@end

@implementation SearchViewController
@synthesize isFromSettings;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
    if(self.isFromSettings)
    {
        [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backButton"] style:UIBarButtonItemStyleDone target:self action:@selector(onClickBackbutton:)]];
        
    }
    
    // Do any additional setup after loading the view.
    
    resultForApi=1;  //1 for catlist,2 for sub cat list 3 for subsub cat list
    
    
    //selectedCategory=@"4";
    //selectedSubCategory=@"185";
    [self performSelector:@selector(makeRequestForgetAllCategory) withObject:nil afterDelay:0.2];
    
    //[self performSelector:@selector(makeRequestgetSubCategoryByCategoryId) withObject:nil afterDelay:1.0];
    
    //[self performSelector:@selector(makeRequestgetSubSubCategoryBySubCategoryId) withObject:nil afterDelay:1.5];
    
}
-(void)makeRequestForgetAllCategory
{
    
    NSMutableDictionary* paramDict =
    [NSMutableDictionary dictionaryWithCapacity:1];
    
    NSString *strToken=[[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    [paramDict setObject:strToken forKey:@"token"];
    
    NSString *strUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    [paramDict setObject:strUserId forKey:@"userId"];
    
    [paramDict setObject:@"getAllCategory" forKey:@"action"];
    
    [[ConnectionsManager sharedManager] getMyFaviroteData:paramDict withdelegate:self];
    
}



-(void)makeRequestgetSubCategoryByCategoryId
{
    if(!selectedCategory.itemId || selectedCategory.itemId == nil)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please select category" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    resultForApi=2;  //1 for catlist,2 for sub cat list 3 for subsub cat list
    
    NSMutableDictionary* paramDict =
    [NSMutableDictionary dictionaryWithCapacity:1];
    
    NSString *strToken=[[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    [paramDict setObject:strToken forKey:@"token"];
    
    [paramDict setObject:selectedCategory.itemId forKey:@"itemId"];
    
    [paramDict setObject:@"getSubCategoryByCategoryId" forKey:@"action"];
    
    [[ConnectionsManager sharedManager] getMyFaviroteData:paramDict withdelegate:self];
    
}
//selectedSubCategory
-(void)makeRequestgetSubSubCategoryBySubCategoryId
{
    if(!selectedCategory.itemId || selectedCategory.itemId == nil || !selectedSubCategory.itemId || selectedSubCategory.itemId == nil)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please select sub category" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    resultForApi=3;  //1 for catlist,2 for sub cat list 3 for subsub cat list
    
    NSMutableDictionary* paramDict =
    [NSMutableDictionary dictionaryWithCapacity:1];
    
    NSString *strToken=[[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    [paramDict setObject:strToken forKey:@"token"];
    
    // NSString *strUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    [paramDict setObject:selectedSubCategory.itemId forKey:@"itemId"];
    
    [paramDict setObject:@"getSubSubCategoryBySubCategoryId" forKey:@"action"];
    
    [[ConnectionsManager sharedManager] getMyFaviroteData:paramDict withdelegate:self];
}


-(void)onClickBackbutton:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)onClickPreferenceButton:(id)sender
{
    UIViewController *searchVC = [self.storyboard instantiateViewControllerWithIdentifier:SearchSBID];
    [self.navigationController pushViewController:searchVC animated:YES];
}

- (IBAction)onClickSearchbutton:(id)sender
{
    
}

-(BOOL)isValidData
{
    
    if([self.txtFldSearch.text isEmpty])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please Fill Keyword must" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alert show];
        
        return NO;
    }
    
   
    
    return YES;
}


- (IBAction)onClickNextButton:(id)sender
{
    if([self isValidData])
    {
    resultForApi=4;
    NSMutableDictionary* paramDict =
    [NSMutableDictionary dictionaryWithCapacity:1];
    
    NSString *strToken=[[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    [paramDict setObject:strToken forKey:@"token"];
    
    NSString *strUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    [paramDict setObject:strUserId forKey:@"userId"];
    
    [paramDict setObject:_txtFldSearch.text forKey:@"keyword"];
   // [paramDict setObject:selectedCategory.itemId forKey:@"categoryId"];
        
        
        
        if([[self.btnCat titleForState:UIControlStateNormal] isEqualToString:@"All"])
        {
            [paramDict setObject:@"0" forKey:@"categoryId"];
            [paramDict setObject:@"0" forKey:@"subCategoryId"];
            [paramDict setObject:@"0" forKey:@"subSubCategoryId"];
        }
        else
        {
            [paramDict setObject:[self.btnCat titleForState:UIControlStateNormal] forKey:@"categoryId"];
            
            if([[self.btnSubcat titleForState:UIControlStateNormal] isEqualToString:@"All"])
                [paramDict setObject:@"0" forKey:@"subCategoryId"];
            else
                [paramDict setObject:[self.btnSubcat titleForState:UIControlStateNormal] forKey:@"subCategoryId"];
            
            if([[self.btnSubSubCat titleForState:UIControlStateNormal] isEqualToString:@"All"])
                [paramDict setObject:@"0" forKey:@"subSubCategoryId"];
            else
                [paramDict setObject:[self.btnSubSubCat titleForState:UIControlStateNormal] forKey:@"subSubCategoryId"];
            
        }

        
        
    /*[paramDict setObject:@"0" forKey:@"categoryId"];

    [paramDict setObject:@"0" forKey:@"subCategoryId"];
    [paramDict setObject:@"0" forKey:@"subSubCategoryId"];*/

    
    [paramDict setObject:@"getBusinessByPreference" forKey:@"action"];
    
    NSLog(@"onClickNextButton paramDict=%@",paramDict);
    
    [[ConnectionsManager sharedManager] getMyFaviroteData:paramDict withdelegate:self];

}

    //token, userId, keyword, categoryId, subCategoryId, subSubCategoryId


  //  UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchDetailVC_SB_ID"];
  //  [self.navigationController pushViewController:vc animated:YES];
}

/*
 if([self isValidData])
 {
 // resultForApi=4;
 NSMutableDictionary* paramDict =
 [NSMutableDictionary dictionaryWithCapacity:1];
 
 NSString *strToken=[[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
 [paramDict setObject:strToken forKey:@"token"];
 
 NSString *strUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
 [paramDict setObject:strUserId forKey:@"userId"];
 
 
 if([[self.btnCategoryOption titleForState:UIControlStateNormal] isEqualToString:@"All"])
 {
 [paramDict setObject:@"0" forKey:@"categoryId"];
 [paramDict setObject:@"0" forKey:@"subCategoryId"];
 [paramDict setObject:@"0" forKey:@"subSubCategoryId"];
 }
 else
 {
 [paramDict setObject:[self.btnCategoryOption titleForState:UIControlStateNormal] forKey:@"categoryId"];
 
 if([[self.btnSubcategory titleForState:UIControlStateNormal] isEqualToString:@"All"])
 [paramDict setObject:@"0" forKey:@"subCategoryId"];
 else
 [paramDict setObject:[self.btnSubcategory titleForState:UIControlStateNormal] forKey:@"subCategoryId"];
 
 if([[self.btnSubSubCategory titleForState:UIControlStateNormal] isEqualToString:@"All"])
 [paramDict setObject:@"0" forKey:@"subSubCategoryId"];
 else
 [paramDict setObject:[self.btnSubSubCategory titleForState:UIControlStateNormal] forKey:@"subSubCategoryId"];
 
 }

 */

-(void)goToSearchDetail
{
      UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchDetailVC_SB_ID"];
     [self.navigationController pushViewController:vc animated:YES];
 
}

-(void)success:(id)response
{
    NSLog(@"success at Home");
    
    
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
        NSArray *arr=[params objectForKey:@"data"];
        
        if(resultForApi==1)
        {
            /*
             {
             itemId = 2;
             itemName = Dining;
             },
             */
            NSLog(@"Category list recived");
            if(arr.count)
            {
                NSMutableArray *catTemp = [NSMutableArray array];
                for(NSDictionary *dict in arr)
                {
                    CategoryData *catData = [[CategoryData alloc] initwithDictionary:dict];
                    [catTemp addObject:catData];
                }
                
                catList = catTemp;
            }
        }
        else if(resultForApi==2)
        {
            /*
             {
             itemId = 19;
             itemName = Accommodation;
             },
             */
            NSLog(@"subCatList list recived");
            if(arr.count)
            {
                NSMutableArray *catTemp = [NSMutableArray array];
                for(NSDictionary *dict in arr)
                {
                    SubCategoryData *catData = [[SubCategoryData alloc] initwithDictionary:dict];
                    [catTemp addObject:catData];
                }
                
                subCatList = catTemp;
                [self openDropdown:subCatList withSender:self.btnSubcat withDir:@"up"];
            }
        }
        else if(resultForApi==3)
        {
            
            NSLog(@"subSubCatList list recived");
            if(arr.count)
            {
                NSMutableArray *catTemp = [NSMutableArray array];
                for(NSDictionary *dict in arr)
                {
                    SubSubCategoryData *catData = [[SubSubCategoryData alloc] initwithDictionary:dict];
                    [catTemp addObject:catData];
                }
                
                subSubCatList = catTemp;
                [self openDropdown:subSubCatList withSender:self.btnSubSubCat withDir:@"up"];
            }
        }
        
        else if(resultForApi==4)
        {
            
            NSLog(@"subSubCatList list recived");
            
            AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
            
            delegate.searchList=arr;
            
            [self goToSearchDetail];

            /*if(arr.count)
            {
                NSMutableArray *catTemp = [NSMutableArray array];
                for(NSDictionary *dict in arr)
                {
                    SubSubCategoryData *catData = [[SubSubCategoryData alloc] initwithDictionary:dict];
                    [catTemp addObject:catData];
                }
                
                subSubCatList = catTemp;
                [self openDropdown:subSubCatList withSender:self.btnSubSubCat withDir:@"up"];
            }*/
        }
        
        
    }
}

-(void)failure:(id)response
{
    
    NSLog(@"fail at Search");
}

- (IBAction)onClickCatButton:(id)sender {
    
    [self openDropdown:catList withSender:sender withDir:@"down"];
    
}

-(void)openDropdown:(NSArray*)array withSender:(id)sender withDir:(NSString *)dir
{
    if(dropDown == nil) {
        CGFloat f = 150;
        dropDown = [[NIDropDown alloc]showDropDown:sender :&f :array :nil :dir];
        dropDown.delegate = self;
    }
    else {
        [dropDown hideDropDown:sender];
        [self rel];
    }
}

- (void) niDropDownDelegateMethod: (NIDropDown *) sender withData:(id)Data_ {
    [self rel];
    NSLog(@"%@", self.btnSearch.titleLabel.text);
    
    if([Data_ isKindOfClass:[CategoryData class]])
    {
        CategoryData *cat = Data_;
        selectedCategory = cat;
        
        [self.btnCat setTitle:cat.itemName forState:UIControlStateNormal];
    }
    else if ([Data_ isKindOfClass:[SubCategoryData class]])
    {
        SubCategoryData *cat = Data_;
        selectedSubCategory = cat;
        
        [self.btnSubcat setTitle:cat.itemName forState:UIControlStateNormal];
    }
    else if ([Data_ isKindOfClass:[SubSubCategoryData class]])
    {
        SubSubCategoryData *cat = Data_;
        selectedSubSubCategory = cat;
        
        [self.btnSubSubCat setTitle:cat.itemName forState:UIControlStateNormal];
    }
}

-(void)rel{
    //    [dropDown release];
    dropDown = nil;
}

- (IBAction)onClicksubCatButton:(id)sender {
    
    [self makeRequestgetSubCategoryByCategoryId];
    //[self openDropdown:subCatList withSender:sender];
}
- (IBAction)onClickSubSubCatButton:(id)sender {
    
    [self makeRequestgetSubSubCategoryBySubCategoryId];
    
    //[self openDropdown:subSubCatList withSender:sender];

}
@end

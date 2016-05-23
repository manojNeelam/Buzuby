//
//  PreferenceViewController.m
//  Buzuby
//
//  Created by Pai, Ankeet on 11/05/16.
//  Copyright © 2016 com.demo. All rights reserved.
//

#import "PreferenceViewController.h"
#import "ConnectionsManager.h"
#import "NIDropDown.h"
#import "CategoryData.h"
#import "SubCategoryData.h"
#import "SubSubCategoryData.h"
#import "AppDelegate.h"

@interface PreferenceViewController () <NIDropDownDelegate, ServerResponseDelegate>
{
    UIButton *selectedButton;
    
    NSArray *catList,*subCatList,*subSubCatList;
    CategoryData *selectedCategory;SubCategoryData  *selectedSubCategory; SubSubCategoryData *selectedSubSubCategory;
    int resultForApi;
    NIDropDown *dropDown;
    
    NSArray *commonList;
}
@end

@implementation PreferenceViewController
@synthesize isFromSettings;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    if(self.isFromSettings)
    {
        [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backButton"] style:UIBarButtonItemStyleDone target:self action:@selector(onClickBackbutton:)]];
    }
    // Do any additional setup after loading the view.

    resultForApi=1;  //1 for catlist,2 for sub cat list 3 for subsub cat list

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


-(void)onClickBackbutton:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)viewDidLayoutSubviews
{
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width,500)];
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

- (IBAction)onClickNextButton:(id)sender
{
    
}

- (IBAction)onClickSubcategoryButton:(id)sender
{
    [self makeRequestgetSubCategoryByCategoryId];
}

- (IBAction)onCllickCategoryButton:(id)sender
{
    [self openDropdown:catList withSender:sender withDir:@"down"];
}

- (IBAction)onClickSubSubCategoryButton:(id)sender
{
    [self makeRequestgetSubSubCategoryBySubCategoryId];
}

- (IBAction)onClickPriceButton:(id)sender
{
    
}

//-(void)setFrameCommonTableView:(CGRect)frameView andTextFieldRect:(CGRect)frameTxtFld
//{
//    [commonTblView setFrame:CGRectMake(frameTxtFld.origin.x, frameView.origin.y+frameView.size.height, frameTxtFld.size.width, 44*4)];
//    [commonTblView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
//    
//    [commonTblView setBackgroundColor:[UIColor lightGrayColor]];//[UIColor colorWithRed:49.0/255.0 green:191.0/255.0 blue:180.0/255.0 alpha:1.0]];
//    
//    [commonTblView setHidden:NO];
//    [commonTblView reloadData];
//}
//
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return commonList.count;
//}
//
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *cellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    if(cell == nil)
//    {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//    }
//    
//    [cell setBackgroundColor:[UIColor lightGrayColor]];//[UIColor colorWithRed:49.0/255.0 green:191.0/255.0 blue:180.0/255.0 alpha:1.0]];
//    [cell.textLabel setFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
//    [cell.textLabel setText:[commonList objectAtIndex:indexPath.row]];
//    [cell.textLabel setNumberOfLines:0];
//    [cell.textLabel setTextColor:[UIColor whiteColor]];
//    [cell.textLabel sizeToFit];
//    
//    return cell;
//}
//
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSString *str = [commonList objectAtIndex:indexPath.row];
//    [commonTblView setHidden:YES];
//    if(selectedButton)
//    {
//        [selectedButton setTitle:str forState:UIControlStateNormal];
//    }
//}

- (IBAction)onClickLocationButon:(id)sender {
}


-(void)rel{
    //    [dropDown release];
    dropDown = nil;
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
    
    if([Data_ isKindOfClass:[CategoryData class]])
    {
        CategoryData *cat = Data_;
        selectedCategory = cat;
        
        [self.btnCategoryOption setTitle:cat.itemName forState:UIControlStateNormal];
    }
    else if ([Data_ isKindOfClass:[SubCategoryData class]])
    {
        SubCategoryData *cat = Data_;
        selectedSubCategory = cat;
        
        [self.btnSubcategory setTitle:cat.itemName forState:UIControlStateNormal];
    }
    else if ([Data_ isKindOfClass:[SubSubCategoryData class]])
    {
        SubSubCategoryData *cat = Data_;
        selectedSubSubCategory = cat;
        
        [self.btnSubSubCategory setTitle:cat.itemName forState:UIControlStateNormal];
    }
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
                [self openDropdown:subCatList withSender:self.btnSubcategory withDir:@"up"];
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
                [self openDropdown:subSubCatList withSender:self.btnSubSubCategory withDir:@"up"];
            }
        }
        
        else if(resultForApi==4)
        {
            
            NSLog(@"subSubCatList list recived");
            
            AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
            
            delegate.searchList=arr;
            
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

@end

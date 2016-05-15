//
//  PreferenceViewController.m
//  Buzuby
//
//  Created by Pai, Ankeet on 11/05/16.
//  Copyright © 2016 com.demo. All rights reserved.
//

#import "PreferenceViewController.h"

@interface PreferenceViewController () <NIDropDownDelegate, UITableViewDataSource, UITableViewDelegate>
{
    UITableView *commonTblView;
    UIButton *selectedButton;
    
    NSArray *commonList;
}
@end

@implementation PreferenceViewController
@synthesize isFromSettings;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    commonList = [[NSArray alloc] initWithObjects:@"All",@"Dining", @"Monitoring", @"Services", @"Stores", nil];
    
    
    commonTblView = [[UITableView alloc] init];
    [commonTblView setBackgroundColor:[UIColor colorWithRed:49.0/255.0 green:191.0/255.0 blue:180.0/255.0 alpha:1.0]];
    commonTblView.backgroundView = nil;
    [commonTblView setDataSource:self];
    [commonTblView setDelegate:self];
    [commonTblView setHidden:YES];
    
    [self.scrollView addSubview:commonTblView];
    
    
    if(self.isFromSettings)
    {
        [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backButton"] style:UIBarButtonItemStyleDone target:self action:@selector(onClickBackbutton:)]];
    }
    // Do any additional setup after loading the view.
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
    selectedButton = self.btnSubcategory;
    
    [self setFrameCommonTableView:self.baseSubcategoryView.frame andTextFieldRect:self.baseSubCategoryTitleView.frame];
}

- (IBAction)onCllickCategoryButton:(id)sender
{
    selectedButton = self.btnCategoryOption;
    
    [self setFrameCommonTableView:self.baseCategoryView.frame andTextFieldRect:self.baseCategoryTitleView.frame];
}

- (IBAction)onClickSubSubCategoryButton:(id)sender
{
    selectedButton = self.btnSubSubCategory;
    
    [self setFrameCommonTableView:self.baseSubSubCategoryView.frame andTextFieldRect:self.baseSubSubCategoryTitleView.frame];
}

- (IBAction)onClickPriceButton:(id)sender
{
    
}

-(void)setFrameCommonTableView:(CGRect)frameView andTextFieldRect:(CGRect)frameTxtFld
{
    [commonTblView setFrame:CGRectMake(frameTxtFld.origin.x, frameView.origin.y+frameView.size.height, frameTxtFld.size.width, 44*4)];
    [commonTblView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    [commonTblView setBackgroundColor:[UIColor lightGrayColor]];//[UIColor colorWithRed:49.0/255.0 green:191.0/255.0 blue:180.0/255.0 alpha:1.0]];
    
    [commonTblView setHidden:NO];
    [commonTblView reloadData];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return commonList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    [cell setBackgroundColor:[UIColor lightGrayColor]];//[UIColor colorWithRed:49.0/255.0 green:191.0/255.0 blue:180.0/255.0 alpha:1.0]];
    [cell.textLabel setFont:[UIFont fontWithName:@"AvenirNextLTPro-Regular" size:13]];
    [cell.textLabel setText:[commonList objectAtIndex:indexPath.row]];
    [cell.textLabel setNumberOfLines:0];
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    [cell.textLabel sizeToFit];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *str = [commonList objectAtIndex:indexPath.row];
    [commonTblView setHidden:YES];
    if(selectedButton)
    {
        [selectedButton setTitle:str forState:UIControlStateNormal];
    }
}

@end

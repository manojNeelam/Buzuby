//
//  CommonWebView.m
//  Buzuby
//
//  Created by Pai, Ankeet on 02/06/16.
//  Copyright © 2016 com.demo. All rights reserved.
//

#import "CommonWebView.h"

@implementation CommonWebView
@synthesize webviewUrl;

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"backButton"] style:UIBarButtonItemStyleDone target:self action:@selector(dismisView:)]];
    
    [self.navigationItem setTitle:self.title];
    NSURL *url = [NSURL URLWithString:self.webviewUrl];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webview loadRequest:urlRequest];
}

-(void)openUrl
{
    
}


-(void)dismisView:(id)sender
{
   [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  CommonWebView.h
//  Buzuby
//
//  Created by Pai, Ankeet on 02/06/16.
//  Copyright © 2016 com.demo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonWebView : UIViewController
@property (nonatomic, strong) NSString *webviewUrl;

@property (weak, nonatomic) IBOutlet UIWebView *webview;

@end

//
//  DefaultTextField.m
//  Buzuby
//
//  Created by Pai, Ankeet on 11/05/16.
//  Copyright © 2016 com.demo. All rights reserved.
//

#import "DefaultTextField.h"

@implementation DefaultTextField


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self setLeftPadding];
}

-(void)setLeftPadding
{
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    self.leftView = paddingView;
    self.leftViewMode = UITextFieldViewModeAlways;
}

@end

//
//  SubSubCategoryData.m
//  Buzuby
//
//  Created by Pai, Ankeet on 17/05/16.
//  Copyright © 2016 com.demo. All rights reserved.
//

#import "SubSubCategoryData.h"

@implementation SubSubCategoryData
@synthesize itemId, itemName;

-(id)initwithDictionary:(NSDictionary *)dict
{
    [self parseDictionary:dict];

    return self;
}

-(void)parseDictionary:(NSDictionary *)param
{
    self.itemName = [param objectForKey:@"itemName"];
    self.itemId = [param objectForKey:@"itemId"];
}
@end

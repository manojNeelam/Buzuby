

//
//  CategoryData.m
//  Buzuby
//
//  Created by Pai, Ankeet on 17/05/16.
//  Copyright © 2016 com.demo. All rights reserved.
//

#import "CategoryData.h"

@implementation CategoryData
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

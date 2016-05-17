//
//  CategoryData.h
//  Buzuby
//
//  Created by Pai, Ankeet on 17/05/16.
//  Copyright © 2016 com.demo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryData : NSObject
@property (nonatomic, strong) NSString *itemId, *itemName;


-(id)initwithDictionary:(NSDictionary *)dict;
@end

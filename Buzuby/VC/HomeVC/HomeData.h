//
//  HomeData.h
//  Buzuby
//
//  Created by Pai, Ankeet on 13/05/16.
//  Copyright © 2016 com.demo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeData : NSObject
@property (nonatomic, strong) NSString *name, *range, *imgCat;
@property (nonatomic, strong) NSString *busId, *rangeFrom,*rangeTo, *currencySymbol,*isFavorite,*latitude,*longitude,*rating,*ratingProvidedByUser,*bannerUrl;

@end

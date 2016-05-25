//
//  DetailViewData.h
//  Buzuby
//
//  Created by Atul Awasthi on 22/05/16.
//  Copyright © 2016 com.demo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DetailViewData : NSObject
@property (nonatomic, strong) NSString *name, *range, *imgCat;
@property (nonatomic, strong) NSString *busId, *rangeFrom,*rangeTo, *currencySymbol,*isFavorite,*latitude,*longitude,*rating,*ratingProvidedByUser,*bannerUrl,*shortDescription,*todayStart,*todayEnd,*address;

@property (nonatomic, strong) NSString *account_number,*active,*amenities,*businessImageBannerUrl,
*businessImageLogoUrl,*business_facebook_url,*city,*facebook_page,*payment_status,*phone;
@property (nonatomic, strong) NSString *province,*restaurant_id,*serial_no,*specialize_in,*sub_category_id,*sub_sub_category_id;
@property (nonatomic, strong) NSString *suburb,*today,*trading_hours_from,*trading_hours_to,*website_link,*country;
@property NSArray *operatingTimeArray;

@end
/*
 "account_number" = NL91JBW4;
 active = 1;
 address = "care@toyota.com";
 amenities = "Car care,Home pickup";
 "banner_img_path" = "/img/business/banner/5tmeccu6p0.png";
 businessImageBannerUrl = "http://buzuby.com/img/business/banner/5tmeccu6p0.png";
 businessImageLogoUrl = "http://buzuby.com/img/business/logo/3en8qt9c3q.jpg";
 "business_facebook_url" = "<null>";
 "category_id" = 3;
 city = indianpolise;
 country = USA;
 currency = USD;
 description = "";
 "facebook_page" = "facebook.com/toyota";
 id = 102;
 isFavorite = yes;
 latitude = "39.743098286948275";
 "logo_img_path" = "/img/business/logo/3en8qt9c3q.jpg";
 longitude = "-86.31237030029297";
 name = Toyota;
 operatingTime =             (
 );
 "payment_status" = completed;
 phone = "1 234-567-8998";
 "price_range_from" = 0;
 "price_range_to" = 1000;
 province = Indiana;
 rating = "3.5";
 ratingProvidedByUser = 3;
 "restaurant_id" = "<null>";
 "serial_no" = "";
 "specialize_in" = Servicing;
 "sub_category_id" = 42;
 "sub_sub_category_id" = 0;
 suburb = NA;
 today = Closed;
 "trading_hours_from" = "<null>";
 "trading_hours_to" = "<null>";
 "user_id" = 199;
 "website_link" = "toyota.com";
 */